import 'dart:convert';
import 'package:avatar_maker/src/core/enums/placeholders.dart';
import 'package:avatar_maker/src/core/enums/preferences_label.dart';
import 'package:avatar_maker/src/core/enums/property_categories.dart';
import 'package:avatar_maker/src/core/enums/property_category_ids.dart';
import 'package:avatar_maker/src/core/enums/property_items/facial_hair_colors.dart';
import 'package:avatar_maker/src/core/enums/property_items/facial_hair_types.dart';
import 'package:avatar_maker/src/core/enums/property_items/hair_colors.dart';
import 'package:avatar_maker/src/core/enums/property_items/hair_styles.dart';
import 'package:avatar_maker/src/core/enums/property_items/outfit_colors.dart';
import 'package:avatar_maker/src/core/enums/property_items/outfit_types.dart';
import 'package:avatar_maker/src/core/models/customized_property_category.dart';
import 'package:avatar_maker/src/core/models/property_item.dart';
import 'package:avatar_maker/src/core/services/accessory_service.dart';
import 'package:avatar_maker/src/core/services/avatar_service.dart';
import 'package:avatar_maker/src/core/services/background_service.dart';
import 'package:avatar_maker/src/core/services/color_service.dart';
import 'package:avatar_maker/src/core/services/eye_service.dart';
import 'package:avatar_maker/src/core/services/eyebrow_service.dart';
import 'package:avatar_maker/src/core/services/mouth_service.dart';
import 'package:avatar_maker/src/core/services/nose_service.dart';
import 'package:avatar_maker/src/core/services/options_service.dart';
import 'package:avatar_maker/src/core/services/outfit_service.dart';
import 'package:avatar_maker/src/core/services/facial_hairs_service.dart';
import 'package:avatar_maker/src/core/services/hair_service.dart';
import 'package:avatar_maker/src/core/services/property_category_service.dart';
import 'package:avatar_maker/src/core/services/skin_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Brains of the Avatar_Maker package
///
/// Built using the getX architecture to allow the two widgets to communicate with each other
///
/// Exposes certain static functions for use by the developer
class AvatarMakerController extends GetxController {
  var displayedAvatarSVG = "".obs;

  late final List<CustomizedPropertyCategory> propertyCategories;
  late final List<CustomizedPropertyCategory> displayedPropertyCategories;
  late final Map<PropertyCategoryIds, PropertyItem> defaultSelectedOptions;

  AvatarMakerController(
    List<CustomizedPropertyCategory>? customizedPropertyCategories,
  ) {
    this.propertyCategories = PropertyCategoryService.mergePropertyCategories(
        customizedPropertyCategories);
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
  }

  /// Stores the option selected by the user for each attribute
  /// where the key represents the Attribute
  /// and the value represents the index of the selected option.
  ///
  /// Eg: selectedOptions["eyes"] gives the index of
  /// the kind of eyes picked by the user
  Map<PropertyCategoryIds, PropertyItem> selectedOptions =
      <PropertyCategoryIds, PropertyItem>{};

  @override
  void onInit() async {
    // called immediately after the widget is allocated memory
    selectedOptions = await getStoredOptions();
    displayedAvatarSVG.value = drawAvatarSVG();
    update();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  /// Adds avatarmaker new string to avatarmaker in GetX Controller
  void updatePreview({
    String avatarmakerNew = '',
  }) {
    if (avatarmakerNew.isEmpty) {
      avatarmakerNew = drawAvatarSVG();
    }
    displayedAvatarSVG.value = avatarmakerNew;
    update();
  }

  /// Restore controller state
  /// with the latest SAVED version of [displayedAvatarSVG] and [selectedOptions]
  void restoreState() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    // Replace observable [avatarmaker] with latest saved version or use default attributes if null
    updatePreview(
        avatarmakerNew: pref.getString(PreferencesLabel.avatarMakerSVG.name) ??
            OptionsService.jsonEncodeSelectedOptions(defaultSelectedOptions));

    selectedOptions = await getStoredOptions();
    update();
  }

  ///  Accepts a String [displayedAvatarSVG]
  ///
  ///  stores [displayedAvatarSVG] in device storage
  ///  adds the new name to controller
  ///
  ///  Thereby updating all the states which are listening to controller
  // TODO doc : modifier doc - Pour permettre à un utilisateur de charger un avatar + Enregistre les configs actuelles si rien n'est passé en paramètre
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
    displayedAvatarSVG.value = avatarSVG;

    update();
  }

  /// Generates a [String] avatarmaker from [selectedOptions] pref
  /// TODO doc : parler du SVG
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

  /// TODO doc : Permet de récupérer les préférences stockées de l'utilisateur ou les options sélectionnées par défaut.
  Future<Map<PropertyCategoryIds, PropertyItem>> getStoredOptions() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? _avatarmakerOptions =
        pref.getString(PreferencesLabel.avatarMakerSelectedOptions.name);
    if (_avatarmakerOptions == null || _avatarmakerOptions == '') {
      Map<PropertyCategoryIds, PropertyItem> _avatarmakerOptionsMap = {
        for (var category in PropertyCategories.values)
          category.id: category.defaultValue
      };

      await pref.setString(PreferencesLabel.avatarMakerSelectedOptions.name,
          OptionsService.jsonEncodeSelectedOptions(_avatarmakerOptionsMap));
      selectedOptions = _avatarmakerOptionsMap;
    } else {
      selectedOptions = OptionsService.jsonDecodeSelectedOptions(
          this.propertyCategories, _avatarmakerOptions);
    }
    update();
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
          color: selectedOptions[PropertyCategoryIds.HairColor] as HairColors,
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

  /// Erase AvatarMaker user's preferences from local storage
  Future<List<bool>> clearAvatarMaker() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return Future.wait([
      pref.remove(PreferencesLabel.avatarMakerSelectedOptions.name),
      pref.remove(PreferencesLabel.avatarMakerSVG.name),
    ]);
  }
}
