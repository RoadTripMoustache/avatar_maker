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
import 'package:avatar_maker/src/core/services/avatar_service.dart';
import 'package:avatar_maker/src/core/services/options_service.dart';
import 'package:avatar_maker/src/core/services/outfit_service.dart';
import 'package:avatar_maker/src/core/services/facial_hairs_service.dart';
import 'package:avatar_maker/src/core/services/hair_service.dart';
import 'package:avatar_maker/src/core/services/property_category_service.dart';
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
  // TODO : Sortir la génération du SVG dans des méthodes
  String getComponentSVG(PropertyCategoryIds categoryId, int index) {
    PropertyItem item = PropertyCategoryService.getPropertyCategoryById(
            this.propertyCategories, categoryId)
        .properties![index];
    switch (categoryId) {
      case PropertyCategoryIds.OutfitType:
        return """<svg width="100px" height="120px" viewBox="30 100 200 250" >${OutfitService.generateOutfit(
          color:
              selectedOptions[PropertyCategoryIds.OutfitColor] as OutfitColors,
          type: item as OutfitTypes,
        )}</svg>""";

      case PropertyCategoryIds.OutfitColor:
        return """<svg width="120px" height="120px" > 
                <circle cx="60" cy="60" r="35" stroke="black" stroke-width="1" fill="${item.value}"/></svg>""";

      case PropertyCategoryIds.HairStyle:
        if (item.value == "") return emptySVGIcon;
        return """<svg width="100px" height="100px" viewBox="10 0 250 250">${HairService.generateHairStyle(
          color: selectedOptions[PropertyCategoryIds.HairColor] as HairColors,
          style: item as HairStyles,
        )}</svg>""";

      case PropertyCategoryIds.HairColor:
        return """<svg width="120px" height="120px" > 
                <circle cx="60" cy="60" r="30" stroke="black" stroke-width="1" fill="${item.value}"/> </svg>""";

      case PropertyCategoryIds.FacialHairType:
        if (item.value == "") return emptySVGIcon;
        return """<svg width="20px" height="20px" viewBox="0 -40 112 180" >${FacialHairsService.generateFacialHair(
          color: selectedOptions[PropertyCategoryIds.FacialHairColor]
              as FacialHairColors,
          type: item as FacialHairTypes,
        )}</svg>""";

      case PropertyCategoryIds.FacialHairColor:
        return """<svg width="120px" height="120px" > 
                <circle cx="60" cy="60" r="30" stroke="black" stroke-width="1" fill="${item.value}"/></svg>""";

      case PropertyCategoryIds.EyeType:
        return """<svg width="20px" height="20px" viewBox="-3 -30 120 120">${item.value}</svg>""";

      case PropertyCategoryIds.EyebrowType:
        return """<svg width="20px" height="20px" viewBox="-3 -50 120 120">${item.value}</svg>""";

      case PropertyCategoryIds.MouthType:
        return """<svg width="20px" height="20px" viewBox="0 10 120 120">${item.value}</svg>""";

      case PropertyCategoryIds.Accessory:
        if (item.value == "") return emptySVGIcon;
        return """<svg width="20px" height="20px" viewBox="-3 -50 120 170" >${item.value}</svg>""";

      case PropertyCategoryIds.SkinColor:
        return """<svg width="264px" height="280px" viewBox="0 0 264 280" version="1.1"
    xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
    <defs>
        <path
            d="M124,144.610951 L124,163 L128,163 L128,163 C167.764502,163 200,195.235498 200,235 L200,244 L0,244 L0,235 C-4.86974701e-15,195.235498 32.235498,163 72,163 L72,163 L76,163 L76,144.610951 C58.7626345,136.422372 46.3722246,119.687011 44.3051388,99.8812385 C38.4803105,99.0577866 34,94.0521096 34,88 L34,74 C34,68.0540074 38.3245733,63.1180731 44,62.1659169 L44,56 L44,56 C44,25.072054 69.072054,5.68137151e-15 100,0 L100,0 L100,0 C130.927946,-5.68137151e-15 156,25.072054 156,56 L156,62.1659169 C161.675427,63.1180731 166,68.0540074 166,74 L166,88 C166,94.0521096 161.51969,99.0577866 155.694861,99.8812385 C153.627775,119.687011 141.237365,136.422372 124,144.610951 Z"
            id="path-5"></path>
    </defs>
    <g id="AvatarMaker" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
    <g transform="translate(-825.000000, -1100.000000)" id="avatar_maker/Circle">
    <g transform="translate(825.000000, 1100.000000)">
        <g id="Mask"></g>
        <g id="AvatarMaker" stroke-width="1" fill-rule="evenodd">
            <g id="Body" transform="translate(32.000000, 36.000000)">
                <mask id="mask-6" fill="white">
                    <use xlink:href="#path-5"></use>
                </mask>
                <use fill="#D0C6AC" xlink:href="#path-5"></use>
                ${item.value}
                <path
                    d="M156,79 L156,102 C156,132.927946 130.927946,158 100,158 C69.072054,158 44,132.927946 44,102 L44,79 L44,94 C44,124.927946 69.072054,150 100,150 C130.927946,150 156,124.927946 156,94 L156,79 Z"
                    id="Neck-Shadow" opacity="0.100000001" fill="#000000"
                    mask="url(#mask-6)"></path>
            </g>
        </g>
    </g>
</svg>""";

      case PropertyCategoryIds.Background:
        return """<svg width="264px" height="280px" viewBox="0 0 264 280" version="1.1"
xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
<defs>
<path d="M124,144.610951 L124,163 L128,163 L128,163 C167.764502,163 200,195.235498 200,235 L200,244 L0,244 L0,235 C-4.86974701e-15,195.235498 32.235498,163 72,163 L72,163 L76,163 L76,144.610951 C58.7626345,136.422372 46.3722246,119.687011 44.3051388,99.8812385 C38.4803105,99.0577866 34,94.0521096 34,88 L34,74 C34,68.0540074 38.3245733,63.1180731 44,62.1659169 L44,56 L44,56 C44,25.072054 69.072054,5.68137151e-15 100,0 L100,0 L100,0 C130.927946,-5.68137151e-15 156,25.072054 156,56 L156,62.1659169 C161.675427,63.1180731 166,68.0540074 166,74 L166,88 C166,94.0521096 161.51969,99.0577866 155.694861,99.8812385 C153.627775,119.687011 141.237365,136.422372 124,144.610951 Z" id="path-5"></path>
</defs>
	<g id="AvatarMaker" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
    <g transform="translate(-825.000000, -1100.000000)" id="avatar_maker/Circle">
			<g transform="translate(825.000000, 1100.000000)">${item.value}<g id="Mask"></g>
        <g id="AvatarMaker" stroke-width="1" fill-rule="evenodd">
					<g id="Body" transform="translate(32.000000, 36.000000)">
						<mask id="mask-6" fill="white">
							<use xlink:href="#path-5"></use>
						</mask>
						<use fill="#D0C6AC" xlink:href="#path-5"></use>
						${selectedOptions[PropertyCategoryIds.SkinColor]!.value}
						<path d="M156,79 L156,102 C156,132.927946 130.927946,158 100,158 C69.072054,158 44,132.927946 44,102 L44,79 L44,94 C44,124.927946 69.072054,150 100,150 C130.927946,150 156,124.927946 156,94 L156,79 Z" id="Neck-Shadow" opacity="0.100000001" fill="#000000" mask="url(#mask-6)"></path>
				</g>
		</g>
	</g>
</svg>""";

      default:
        return emptySVGIcon;
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
