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
import "package:avatar_maker/src/core/models/cosmetic_property_item.dart";
import "package:avatar_maker/src/core/models/customized_property_category.dart";
import "package:avatar_maker/src/core/models/effect_color_cosmetic_item.dart";
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

  /// Currently selected cosmetic background item.
  CosmeticPropertyItem? _selectedBackgroundCosmetic;

  /// Currently selected cosmetic effect item.
  CosmeticPropertyItem? _selectedEffectCosmetic;

  /// Currently selected cosmetic effect color item.
  CosmeticPropertyItem? _selectedEffectColorCosmetic;

  /// Temporary preview options. These are rendered on the avatar but are not saved.
  final Map<PropertyCategoryIds, PropertyItem> _previewOptions = {};

  /// Currently previewed cosmetic background item.
  CosmeticPropertyItem? _previewBackgroundCosmetic;

  /// Currently previewed cosmetic effect item.
  CosmeticPropertyItem? _previewEffectCosmetic;

  /// Currently previewed cosmetic effect color item.
  CosmeticPropertyItem? _previewEffectColorCosmetic;

  /// The currently selected cosmetic background item.
  CosmeticPropertyItem? get selectedBackgroundCosmetic =>
      _selectedBackgroundCosmetic;

  /// The currently selected cosmetic effect item.
  CosmeticPropertyItem? get selectedEffectCosmetic => _selectedEffectCosmetic;

  /// The currently selected cosmetic effect color item.
  CosmeticPropertyItem? get selectedEffectColorCosmetic =>
      _selectedEffectColorCosmetic;

  /// Temporary preview options.
  Map<PropertyCategoryIds, PropertyItem> get previewOptions {
    final result = <PropertyCategoryIds, PropertyItem>{};
    _previewOptions.forEach((key, value) {
      result[key] = value;
    });
    return result;
  }

  /// Whether a temporary preview is active.
  bool get hasPreviewOptions => _previewOptions.isNotEmpty;

  /// Selected options combined with temporary preview options.
  Map<PropertyCategoryIds, PropertyItem> get effectiveSelectedOptions {
    if (_previewOptions.isEmpty) {
      return selectedOptions;
    }

    final result = <PropertyCategoryIds, PropertyItem>{};
    selectedOptions.forEach((key, value) {
      result[key] = value;
    });
    _previewOptions.forEach((key, value) {
      result[key] = value;
    });
    return result;
  }

  /// The currently previewed cosmetic background item.
  CosmeticPropertyItem? get previewBackgroundCosmetic =>
      _previewBackgroundCosmetic;

  /// The currently previewed cosmetic effect item.
  CosmeticPropertyItem? get previewEffectCosmetic => _previewEffectCosmetic;

  /// The currently previewed cosmetic effect color item.
  CosmeticPropertyItem? get previewEffectColorCosmetic =>
      _previewEffectColorCosmetic;

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
    _syncCosmeticSelectionsFromSelectedOptions();
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
    if (newAvatarMakerSVG.isEmpty) {
      newAvatarMakerSVG = drawAvatarSVG(
        selectedOptionsOverride: effectiveSelectedOptions,
      );
    }
    _displayedAvatarSVG = newAvatarMakerSVG;
    notifyListeners();
  }

  void _syncCosmeticSelectionsFromSelectedOptions() {
    _syncCosmeticSelectionsFromOptions(selectedOptions, preview: false);
  }

  void _syncPreviewCosmeticSelectionsFromPreviewOptions() {
    _syncCosmeticSelectionsFromOptions(_previewOptions, preview: true);
  }

  void _syncCosmeticSelectionsFromOptions(
    Map<PropertyCategoryIds, PropertyItem> options, {
    required bool preview,
  }) {
    final background = options[PropertyCategoryIds.AvatarBackground];
    final effect = options[PropertyCategoryIds.AvatarEffect];
    final effectColor = options[PropertyCategoryIds.AvatarEffectColor];

    if (preview) {
      _previewBackgroundCosmetic =
          background is CosmeticPropertyItem && background.cosmeticId != "none"
              ? background
              : null;
      _previewEffectCosmetic =
          effect is CosmeticPropertyItem && effect.cosmeticId != "none"
              ? effect
              : null;
      _previewEffectColorCosmetic =
          effectColor is EffectColorCosmeticItem ? effectColor : null;
      return;
    }

    _selectedBackgroundCosmetic =
        background is CosmeticPropertyItem && background.cosmeticId != "none"
            ? background
            : null;
    _selectedEffectCosmetic =
        effect is CosmeticPropertyItem && effect.cosmeticId != "none"
            ? effect
            : null;
    _selectedEffectColorCosmetic =
        effectColor is EffectColorCosmeticItem ? effectColor : null;
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
    clearPreview();

    // Update the selectedOptions if jsonAvatarOptions is not null
    if (jsonAvatarOptions != null) {
      selectedOptions = OptionsService.jsonDecodeSelectedOptions(
          this.propertyCategories, jsonAvatarOptions);
      _syncCosmeticSelectionsFromSelectedOptions();
    }

    // Perform the save operation (implemented by subclasses)
    await save();

    // Update the preview
    updatePreview(newAvatarMakerSVG: drawAvatarSVG());
  }

  /// Perform the save operation. This method should be implemented by subclasses
  /// to provide the appropriate save strategy.
  Future<String> save();

  /// Restore controller state with the latest version of
  /// [displayedAvatarSVG] and [selectedOptions]
  Future<void> restoreState() async {
    // Get the SVG and options (implemented by subclasses)
    final restoredData = await performRestore();

    // Update the preview with the restored SVG or generate a new one
    updatePreview(newAvatarMakerSVG: restoredData.svg);

    // Update selected options
    selectedOptions = restoredData.options;
    _syncCosmeticSelectionsFromSelectedOptions();
    clearPreview();
    notifyListeners();
  }

  /// Perform the restore operation. This method should be implemented by subclasses
  /// to provide the appropriate restore strategy.
  Future<RestoredData> performRestore();

  /// Generates a [String] SVG from the [selectedOptions] stored.
  String drawAvatarSVG({
    Map<PropertyCategoryIds, PropertyItem>? selectedOptionsOverride,
  }) {
    final options = selectedOptionsOverride ?? selectedOptions;
    return AvatarService.drawSVG(
      accessory: options[PropertyCategoryIds.Accessory]!.value,
      backgroundStyle: options[PropertyCategoryIds.Background]!.value,
      eyebrows: options[PropertyCategoryIds.EyebrowType]!.value,
      eyes: options[PropertyCategoryIds.EyeType]!.value,
      facialHair: FacialHairsService.generateFacialHair(
        color: options[PropertyCategoryIds.FacialHairColor]
            as FacialHairColors,
        type: options[PropertyCategoryIds.FacialHairType]
            as FacialHairTypes,
      ),
      hair: HairService.generateHairStyle(
        color: options[PropertyCategoryIds.HairColor] as HairColors,
        style: options[PropertyCategoryIds.HairStyle] as HairStyles,
      ),
      mouth: options[PropertyCategoryIds.MouthType]!.value,
      nose: options[PropertyCategoryIds.Nose]!.value,
      outfit: OutfitService.generateOutfit(
        color: options[PropertyCategoryIds.OutfitColor] as OutfitColors,
        type: options[PropertyCategoryIds.OutfitType] as OutfitTypes,
      ),
      skin: options[PropertyCategoryIds.SkinColor]!.value,
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

      case PropertyCategoryIds.AvatarBackground:
      case PropertyCategoryIds.AvatarEffect:
      case PropertyCategoryIds.AvatarEffectColor:
        return emptySVGIcon;
    }
  }

  /// Randomize the select options of all the displayed property categories.
  /// All the non displayed categories keep their default value.
  void randomizedSelectedOptions() {
    clearPreview();
    var rng = Random();
    displayedPropertyCategories.forEach(
      (propertyCategory) {
        final randomItem = propertyCategory.properties!
            .elementAt(rng.nextInt(propertyCategory.properties!.length));
        selectedOptions.update(
          propertyCategory.id,
          (value) => randomItem,
        );

        // Also update cosmetic selections for cosmetic categories.
        if (randomItem is CosmeticPropertyItem) {
          switch (randomItem.category) {
            case "background":
              _selectedBackgroundCosmetic = randomItem;
              break;
            case "effect":
              _selectedEffectCosmetic = randomItem;
              break;
            case "effect_color":
              _selectedEffectColorCosmetic = randomItem;
              break;
          }
        }
      },
    );
    _syncCosmeticSelectionsFromSelectedOptions();

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

  /// Flag to know if the controller used is a persistant one or not.
  /// Useful for some widgets like the "Reset" or "Save" button to know if it's
  /// useful to be displayed.
  bool isPersistentController();

  /// Preview an option without changing saved selected options.
  void previewOption(PropertyItem item, PropertyCategoryIds categoryId) {
    _previewOptions[categoryId] = item;
    if (item is CosmeticPropertyItem) {
      _syncPreviewCosmeticSelectionsFromPreviewOptions();
    }
    updatePreview();
  }

  /// Preview a cosmetic option without changing saved selected options.
  void previewCosmetic(CosmeticPropertyItem item) {
    previewOption(item, _categoryIdForCosmetic(item.category));
  }

  /// Clear temporary preview options.
  void clearPreview() {
    _previewOptions.clear();
    _previewBackgroundCosmetic = null;
    _previewEffectCosmetic = null;
    _previewEffectColorCosmetic = null;
    // Render using selectedOptions (without preview) so the avatar
    // goes back to the saved state, not the previewed one.
    _displayedAvatarSVG = drawAvatarSVG();
    notifyListeners();
  }

  PropertyCategoryIds _categoryIdForCosmetic(String category) {
    switch (category) {
      case "background":
        return PropertyCategoryIds.AvatarBackground;
      case "effect":
        return PropertyCategoryIds.AvatarEffect;
      case "effect_color":
        return PropertyCategoryIds.AvatarEffectColor;
      default:
        return PropertyCategoryIds.AvatarEffect;
    }
  }

  /// Select a cosmetic item (background, effect, or effect color).
  /// If the item is a "None" placeholder (cosmeticId == "none"), clears
  /// the corresponding cosmetic.
  void selectCosmetic(CosmeticPropertyItem item) {
    clearPreview();
    if (item.cosmeticId == "none") {
      switch (item.category) {
        case "background":
          _selectedBackgroundCosmetic = null;
          break;
        case "effect":
          _selectedEffectCosmetic = null;
          break;
        case "effect_color":
          _selectedEffectColorCosmetic = null;
          break;
      }
    } else {
      switch (item.category) {
        case "background":
          _selectedBackgroundCosmetic = item;
          break;
        case "effect":
          _selectedEffectCosmetic = item;
          break;
        case "effect_color":
          _selectedEffectColorCosmetic = item;
          break;
      }
    }
    // Also update selectedOptions so the grid highlights the correct item.
    final categoryId = _categoryIdForCosmetic(item.category);
    selectedOptions[categoryId] = item;
    updatePreview();
    notifyListeners();
  }

  /// Clear all selected cosmetics.
  void clearCosmetics() {
    clearPreview();
    _selectedBackgroundCosmetic = null;
    _selectedEffectCosmetic = null;
    _selectedEffectColorCosmetic = null;
    // Reset to "None" placeholder items.
    selectedOptions[PropertyCategoryIds.AvatarBackground] =
        defaultSelectedOptions[PropertyCategoryIds.AvatarBackground]!;
    selectedOptions[PropertyCategoryIds.AvatarEffect] =
        defaultSelectedOptions[PropertyCategoryIds.AvatarEffect]!;
    selectedOptions[PropertyCategoryIds.AvatarEffectColor] =
        defaultSelectedOptions[PropertyCategoryIds.AvatarEffectColor]!;
    updatePreview();
    notifyListeners();
  }
}

/// Class to hold restored data from persistence
class RestoredData {
  final String svg;
  final Map<PropertyCategoryIds, PropertyItem> options;

  RestoredData({required this.svg, required this.options});
}
