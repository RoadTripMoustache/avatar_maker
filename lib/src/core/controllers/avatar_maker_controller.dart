import "dart:math";

import "package:avatar_maker/l10n/app_localizations.dart";
import "package:avatar_maker/src/core/enums/placeholders.dart";
import "package:avatar_maker/src/core/enums/property_category_ids.dart";
import "package:avatar_maker/src/core/enums/property_items/facial_hair_colors.dart";
import "package:avatar_maker/src/core/enums/property_items/facial_hair_types.dart";
import "package:avatar_maker/src/core/enums/property_items/hair_colors.dart";
import "package:avatar_maker/src/core/enums/property_items/hair_styles.dart";
import "package:avatar_maker/src/core/enums/property_items/outfit_colors.dart";
import "package:avatar_maker/src/core/enums/property_items/outfit_types.dart";
import "package:avatar_maker/src/core/models/customized_property_category.dart";
import "package:avatar_maker/src/core/models/property_item.dart";
import "package:avatar_maker/src/core/services/accessory_service.dart";
import "package:avatar_maker/src/core/services/avatar_service.dart";
import "package:avatar_maker/src/core/services/background_service.dart";
import "package:avatar_maker/src/core/services/color_service.dart";
import "package:avatar_maker/src/core/services/eye_service.dart";
import "package:avatar_maker/src/core/services/eyebrow_service.dart";
import "package:avatar_maker/src/core/services/mouth_service.dart";
import "package:avatar_maker/src/core/services/nose_service.dart";
import "package:avatar_maker/src/core/services/options_service.dart";
import "package:avatar_maker/src/core/services/outfit_service.dart";
import "package:avatar_maker/src/core/services/facial_hairs_service.dart";
import "package:avatar_maker/src/core/services/hair_service.dart";
import "package:avatar_maker/src/core/services/property_category_service.dart";
import "package:avatar_maker/src/core/services/skin_service.dart";
import "package:flutter/material.dart";

/// Abstract base class for Avatar Maker controllers
///
/// This class provides the core functionality for avatar customization
/// without any persistence logic. Subclasses should implement the
/// persistence strategy as needed.
abstract class AvatarMakerController extends ChangeNotifier {
  /// Value which contains the svg code of the avatar to display
  String _displayedAvatarSVG = "";

  String get displayedAvatarSVG => _displayedAvatarSVG;

  /// List of all the property categories merged (the one given by the user with
  /// the default one stored in the code). Useful to get the default value from
  /// property categories which are not updatable.
  late final List<CustomizedPropertyCategory> propertyCategories;

  /// List of all the property categories which are updatable.
  late final List<CustomizedPropertyCategory> displayedPropertyCategories;

  /// Map of all the default selected options for all property category
  /// (displayed or not).
  late final Map<PropertyCategoryIds, PropertyItem> defaultSelectedOptions;

  /// Localization instance to manage property categories displayed title.
  late final AppLocalizations l10n;

  /// Stores the option selected by the user for each attribute
  /// where the key represents the Attribute
  /// and the value represents the index of the selected option.
  ///
  /// Eg: selectedOptions["eyes"] gives the index of
  /// the kind of eyes picked by the user
  late Map<PropertyCategoryIds, PropertyItem> selectedOptions;

  AvatarMakerController({
    List<CustomizedPropertyCategory>? customizedPropertyCategories,
    Map<PropertyCategoryIds, PropertyItem>? selectedOptions,
    Locale? locale,
  }) {
    // If no locale is provided, display the english text by default.
    if (locale == null) {
      locale = Locale("en");
    }
    this.l10n = lookupAppLocalizations(locale);
    this.propertyCategories = PropertyCategoryService.mergePropertyCategories(
        customizedPropertyCategories ?? [], l10n);
    this.displayedPropertyCategories = this
        .propertyCategories
        .where((category) => category.toDisplay)
        .toList();
    this.selectedOptions = selectedOptions ?? {};
    // Generate the default selected options based on the
    // [CustomizedPropertyCategory] list given to the constructor.
    this.defaultSelectedOptions = {
      for (var category in this.propertyCategories)
        category.id: category.defaultValue!
    };

    // Initialize the controller
    initController();
  }

  AvatarMakerController.fromSvg(
      {required String svg,
      List<CustomizedPropertyCategory>? customizedPropertyCategories,
      Locale? locale})
      : this(
            customizedPropertyCategories: customizedPropertyCategories,
            selectedOptions: AvatarService.extractPropertiesFromSvg(svg),
            locale: locale);

  /// Initialize the controller by loading options and updating the preview
  Future<void> initController() async {
    selectedOptions = await getSelectedOptions();
    _displayedAvatarSVG = drawAvatarSVG();
    notifyListeners();
  }

  /// Get the selected options. This method should be implemented by subclasses
  /// to provide the appropriate options retrieval strategy.
  Future<Map<PropertyCategoryIds, PropertyItem>> getSelectedOptions();

  /// Update the displayed SVG with the new SVG given in parameter, or the one
  /// draw based on the selected options.
  void updatePreview({
    String newAvatarMakerSVG = "",
  }) {
    print("Update? -> ${newAvatarMakerSVG.isEmpty}");
    if (newAvatarMakerSVG.isEmpty) {
      newAvatarMakerSVG = drawAvatarSVG();
    }
    _displayedAvatarSVG = newAvatarMakerSVG;
    print("Update finished -> ${newAvatarMakerSVG.isEmpty}");
    notifyListeners();
  }

  /// Save the selected options and update the preview.
  ///
  /// If avatar options are given in parameter, they will be loaded in
  /// the preview instead of the current ones.
  ///
  /// parameters :
  /// - [jsonAvatarOptions] : String? - The jsonAvatarOptions which are forced
  /// to set by the user
  Future<void> saveAvatarSVG({String? jsonAvatarOptions}) async {
    // Update the selectedOptions if jsonAvatarOptions is not null
    if (jsonAvatarOptions != null) {
      selectedOptions = OptionsService.jsonDecodeSelectedOptions(
          this.propertyCategories, jsonAvatarOptions);
    }

    // Perform the save operation (implemented by subclasses)
    await performSave();

    // Update the preview
    updatePreview(newAvatarMakerSVG: drawAvatarSVG());
  }

  /// Perform the save operation. This method should be implemented by subclasses
  /// to provide the appropriate save strategy.
  Future<void> performSave();

  /// Restore controller state with the latest version of
  /// [displayedAvatarSVG] and [selectedOptions]
  Future<void> restoreState() async {
    // Get the SVG and options (implemented by subclasses)
    final restoredData = await performRestore();

    // Update the preview with the restored SVG or generate a new one
    updatePreview(newAvatarMakerSVG: restoredData.svg);

    // Update selected options
    selectedOptions = restoredData.options;
    notifyListeners();
  }

  /// Perform the restore operation. This method should be implemented by subclasses
  /// to provide the appropriate restore strategy.
  Future<RestoredData> performRestore();

  /// Generates a [String] SVG from the [selectedOptions] stored.
  String drawAvatarSVG() {
    print("Drawing avatar SVG with selected options: $selectedOptions");
    return AvatarService.drawSVG(
      accessory: selectedOptions[PropertyCategoryIds.Accessory]!.value,
      backgroundStyle: selectedOptions[PropertyCategoryIds.Background]!.value,
      eyebrows: selectedOptions[PropertyCategoryIds.EyebrowType]!.value,
      eyes: selectedOptions[PropertyCategoryIds.EyeType]!.value,
      facialHair: FacialHairsService.generateFacialHair(
        color: selectedOptions[PropertyCategoryIds.FacialHairColor]
            as FacialHairColors,
        type: selectedOptions[PropertyCategoryIds.FacialHairType]
            as FacialHairTypes,
      ),
      hair: HairService.generateHairStyle(
        color: selectedOptions[PropertyCategoryIds.HairColor] as HairColors,
        style: selectedOptions[PropertyCategoryIds.HairStyle] as HairStyles,
      ),
      mouth: selectedOptions[PropertyCategoryIds.MouthType]!.value,
      nose: selectedOptions[PropertyCategoryIds.Nose]!.value,
      outfit: OutfitService.generateOutfit(
        color: selectedOptions[PropertyCategoryIds.OutfitColor] as OutfitColors,
        type: selectedOptions[PropertyCategoryIds.OutfitType] as OutfitTypes,
      ),
      skin: selectedOptions[PropertyCategoryIds.SkinColor]!.value,
    );
  }

  /// Generates component SVG string for an individual component
  /// to display as a preview
  String getComponentSVG(PropertyCategoryIds categoryId, int index) {
    PropertyItem item = PropertyCategoryService.getPropertyCategoryById(
            this.propertyCategories, categoryId)
        .properties![index];
    if (item.value == "") {
      return emptySVGIcon;
    }
    switch (categoryId) {
      case PropertyCategoryIds.Accessory:
        return AccessoryService.drawSVG(accessory: item.value);

      case PropertyCategoryIds.Background:
        return BackgroundService.drawSVG(background: item.value);

      case PropertyCategoryIds.EyebrowType:
        return EyebrowService.drawSVG(eyebrow: item.value);

      case PropertyCategoryIds.EyeType:
        return EyeService.drawSVG(eye: item.value);

      case PropertyCategoryIds.FacialHairColor:
        return ColorService.drawSVG(hexColorCode: item.value);

      case PropertyCategoryIds.FacialHairType:
        return FacialHairsService.drawSVG(
          color: selectedOptions[PropertyCategoryIds.FacialHairColor]
              as FacialHairColors,
          type: item as FacialHairTypes,
        );

      case PropertyCategoryIds.HairColor:
        return ColorService.drawSVG(hexColorCode: item.value);

      case PropertyCategoryIds.HairStyle:
        return HairService.drawSVG(
          color: (selectedOptions[PropertyCategoryIds.HairColor] ??
              HairColors.values.first) as HairColors,
          style: item as HairStyles,
        );

      case PropertyCategoryIds.MouthType:
        return MouthService.drawSVG(mouth: item.value);

      case PropertyCategoryIds.Nose:
        return NoseService.drawSVG(nose: item.value);

      case PropertyCategoryIds.OutfitColor:
        return ColorService.drawSVG(hexColorCode: item.value);

      case PropertyCategoryIds.OutfitType:
        return OutfitService.drawSVG(
          color:
              selectedOptions[PropertyCategoryIds.OutfitColor] as OutfitColors,
          type: item as OutfitTypes,
        );

      case PropertyCategoryIds.SkinColor:
        return SkinService.drawSVG(skinColor: item.value);
    }
  }

  /// Randomize the select options of all the displayed property categories.
  /// All the non displayed categories keep their default value.
  void randomizedSelectedOptions() {
    var rng = Random();
    displayedPropertyCategories.forEach(
      (propertyCategory) {
        selectedOptions.update(
          propertyCategory.id,
          (value) => propertyCategory.properties!
              .elementAt(rng.nextInt(propertyCategory.properties!.length)),
        );
      },
    );

    updatePreview();
  }

  /// Extract the selected options to JSON for an external save.
  String getJsonOptionsSync() {
    return OptionsService.jsonEncodeSelectedOptions(selectedOptions);
  }

  /// Extract the current avatar SVG for an external save.
  String getAvatarSVGSync() {
    return drawAvatarSVG();
  }
}

/// Class to hold restored data from persistence
class RestoredData {
  final String svg;
  final Map<PropertyCategoryIds, PropertyItem> options;

  RestoredData({required this.svg, required this.options});
}
