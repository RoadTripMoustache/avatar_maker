import "dart:math";

import "package:avatar_maker/l10n/app_localizations.dart";
import "package:avatar_maker/src/core/enums/placeholders.dart";
import "package:avatar_maker/src/core/enums/preferences_label.dart";
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
import "package:shared_preferences/shared_preferences.dart";

/// Brains of the Avatar_Maker package
///
/// Built using the ChangeNotifier architecture to allow the two widgets to easily
/// communicate with each other
class AvatarMakerController extends ChangeNotifier {
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
  Map<PropertyCategoryIds, PropertyItem> selectedOptions =
      <PropertyCategoryIds, PropertyItem>{};

  AvatarMakerController({
    required List<CustomizedPropertyCategory>? customizedPropertyCategories,
    Locale? locale,
  }) {
    // If no locale is provided, display the english text by default.
    if (locale == null) {
      locale = Locale("en");
    }
    this.l10n = lookupAppLocalizations(locale);
    this.propertyCategories = PropertyCategoryService.mergePropertyCategories(
        customizedPropertyCategories, l10n);
    this.displayedPropertyCategories = this
        .propertyCategories
        .where((category) => category.toDisplay)
        .toList();
    // Generate the default selected options based on the
    // [CustomizedPropertyCategory] list given to the constructor.
    this.defaultSelectedOptions = {
      for (var category in this.propertyCategories)
        category.id: category.defaultValue!
    };

    // Initialize the controller
    initController();
  }

  /// Initialize the controller by loading stored options and updating the preview
  Future<void> initController() async {
    selectedOptions = await getStoredOptions();
    _displayedAvatarSVG = drawAvatarSVG();
    notifyListeners();
  }

  /// Update the displayed SVG with the new SVG given in parameter, or the one
  /// draw based on the selected options.
  void updatePreview({
    String newAvatarMakerSVG = "",
  }) {
    if (newAvatarMakerSVG.isEmpty) {
      newAvatarMakerSVG = drawAvatarSVG();
    }
    _displayedAvatarSVG = newAvatarMakerSVG;
    notifyListeners();
  }

  /// Restore controller state with the latest SAVED version of
  /// [displayedAvatarSVG] and [selectedOptions]
  void restoreState() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    // Replace observable value with latest saved version or use default
    // attributes if null
    updatePreview(
        newAvatarMakerSVG: pref
                .getString(PreferencesLabel.avatarMakerSVG.name) ??
            OptionsService.jsonEncodeSelectedOptions(defaultSelectedOptions));

    selectedOptions = await getStoredOptions();
    notifyListeners();
  }

  /// Save the selected options and the current SVG in the Shared Preferences,
  /// then update the preview.
  ///
  /// If avatar options are given in parameter, they will be saved and loaded in
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

    // Update selectedOptions stored
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(
      PreferencesLabel.avatarMakerSelectedOptions.name,
      OptionsService.jsonEncodeSelectedOptions(selectedOptions),
    );

    // Get the SVG to display and store
    final String avatarSVG = drawAvatarSVG();
    await pref.setString(PreferencesLabel.avatarMakerSVG.name, avatarSVG);

    // Update the preview
    updatePreview(newAvatarMakerSVG: avatarSVG);
  }

  /// Generates a [String] SVG from the [selectedOptions] stored.
  String drawAvatarSVG() {
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

  /// Get the current stored options from the shared preferences, or set the
  /// options with the default values if no options where stored.
  Future<Map<PropertyCategoryIds, PropertyItem>> getStoredOptions() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? _avatarMakerOptions =
        pref.getString(PreferencesLabel.avatarMakerSelectedOptions.name);

    if (_avatarMakerOptions == null || _avatarMakerOptions.isEmpty) {
      Map<PropertyCategoryIds, PropertyItem> _avatarMakerOptionsMap = {};
      _avatarMakerOptionsMap.addAll(defaultSelectedOptions);

      await pref.setString(PreferencesLabel.avatarMakerSelectedOptions.name,
          OptionsService.jsonEncodeSelectedOptions(_avatarMakerOptionsMap));
      selectedOptions = _avatarMakerOptionsMap;
    } else {
      selectedOptions = OptionsService.jsonDecodeSelectedOptions(
          this.propertyCategories, _avatarMakerOptions);
    }
    notifyListeners();
    return selectedOptions;
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
          color: (selectedOptions[PropertyCategoryIds.HairColor] ?? HairColors.values.first) as HairColors,
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

  /// Erase AvatarMaker user's preferences from local storage
  static Future<List<bool>> clearAvatarMaker() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return Future.wait([
      pref.remove(PreferencesLabel.avatarMakerSelectedOptions.name),
      pref.remove(PreferencesLabel.avatarMakerSVG.name),
    ]);
  }

  /// Extract the selected options to JSON for an external save.
  ///
  /// Method made to simplify actions from library users.
  static Future<String> getJsonOptions() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.get(PreferencesLabel.avatarMakerSelectedOptions.name) as String;
  }

  /// Import the given options in a JSON format to the controller.
  ///
  /// Method made to simplify actions from library users.
  /// 
  /// [controller] - The AvatarMakerController instance to use
  static void setJsonOptions(String jsonAvatarOptions, {required AvatarMakerController controller}) {
    controller.saveAvatarSVG(jsonAvatarOptions: jsonAvatarOptions);
  }

  /// Extract the current avatar SVG for an external save.
  ///
  /// Method made to simplify actions from library users.
  static Future<String> getAvatarSVG() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.get(PreferencesLabel.avatarMakerSVG.name) as String;
  }
}
