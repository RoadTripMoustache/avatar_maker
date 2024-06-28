/// List of property categories which exist in the library.
import "package:avatar_maker/l10n/app_localizations.dart";
import "package:avatar_maker/src/core/enums/property_category_ids.dart";
import "package:avatar_maker/src/core/enums/property_items/accessories.dart";
import "package:avatar_maker/src/core/enums/property_items/background_style.dart";
import "package:avatar_maker/src/core/enums/property_items/noses.dart";
import "package:avatar_maker/src/core/enums/property_items/outfit_colors.dart";
import "package:avatar_maker/src/core/enums/property_items/eyebrows.dart";
import "package:avatar_maker/src/core/enums/property_items/eyes.dart";
import "package:avatar_maker/src/core/enums/property_items/facial_hair_colors.dart";
import "package:avatar_maker/src/core/enums/property_items/facial_hair_types.dart";
import "package:avatar_maker/src/core/enums/property_items/hair_colors.dart";
import "package:avatar_maker/src/core/enums/property_items/hair_styles.dart";
import "package:avatar_maker/src/core/enums/property_items/outfit_types.dart";
import "package:avatar_maker/src/core/enums/property_items/mouths.dart";
import "package:avatar_maker/src/core/enums/property_items/skin_colors.dart";
import "package:avatar_maker/src/core/models/property_category.dart";

final PropertyCategory Accessory = PropertyCategory(
  id: PropertyCategoryIds.Accessory,
  getL10nName: (AppLocalizations l10n) {
    return l10n.property_category_accessories;
  },
  iconFile: "assets/icons/accessories.svg",
  properties: Accessories.values,
  toDisplay: true,
  defaultValue: Accessories.Nothing,
);
final PropertyCategory Background = PropertyCategory(
  id: PropertyCategoryIds.Background,
  getL10nName: (AppLocalizations l10n) {
    return l10n.property_category_backgrounds;
  },
  iconFile: "assets/icons/background.svg",
  properties: BackgroundStyles.values,
  toDisplay: false,
  defaultValue: BackgroundStyles.Transparent,
);
final PropertyCategory EyebrowType = PropertyCategory(
  id: PropertyCategoryIds.EyebrowType,
  getL10nName: (AppLocalizations l10n) {
    return l10n.property_category_eyebrows;
  },
  iconFile: "assets/icons/eyebrows.svg",
  properties: Eyebrows.values,
  toDisplay: true,
  defaultValue: Eyebrows.Default,
);
final PropertyCategory EyeType = PropertyCategory(
  id: PropertyCategoryIds.EyeType,
  getL10nName: (AppLocalizations l10n) {
    return l10n.property_category_eyes;
  },
  iconFile: "assets/icons/eyes.svg",
  properties: Eyes.values,
  toDisplay: true,
  defaultValue: Eyes.Default,
);
final PropertyCategory FacialHairColor = PropertyCategory(
  id: PropertyCategoryIds.FacialHairColor,
  getL10nName: (AppLocalizations l10n) {
    return l10n.property_category_facial_hair_colors;
  },
  iconFile: "assets/icons/facial_hair_color.svg",
  properties: FacialHairColors.values,
  toDisplay: true,
  defaultValue: FacialHairColors.Black,
);
final PropertyCategory FacialHairType = PropertyCategory(
  id: PropertyCategoryIds.FacialHairType,
  getL10nName: (AppLocalizations l10n) {
    return l10n.property_category_facial_hair_types;
  },
  iconFile: "assets/icons/facial_hair.svg",
  properties: FacialHairTypes.values,
  toDisplay: true,
  defaultValue: FacialHairTypes.Nothing,
);
final PropertyCategory HairStyle = PropertyCategory(
  id: PropertyCategoryIds.HairStyle,
  getL10nName: (AppLocalizations l10n) {
    return l10n.property_category_hairstyles;
  },
  iconFile: "assets/icons/hair.svg",
  properties: HairStyles.values,
  toDisplay: true,
  defaultValue: HairStyles.Bald,
);
final PropertyCategory HairColor = PropertyCategory(
  id: PropertyCategoryIds.HairColor,
  getL10nName: (AppLocalizations l10n) {
    return l10n.property_category_hair_colors;
  },
  iconFile: "assets/icons/hair_color.svg",
  properties: HairColors.values,
  toDisplay: true,
  defaultValue: HairColors.Black,
);
final PropertyCategory MouthType = PropertyCategory(
  id: PropertyCategoryIds.MouthType,
  getL10nName: (AppLocalizations l10n) {
    return l10n.property_category_mouths;
  },
  iconFile: "assets/icons/mouth.svg",
  properties: Mouths.values,
  toDisplay: true,
  defaultValue: Mouths.Default,
);
final PropertyCategory NoseType = PropertyCategory(
  id: PropertyCategoryIds.Nose,
  getL10nName: (AppLocalizations l10n) {
    return l10n.property_category_noses;
  },
  iconFile: "assets/icons/noses.svg",
  properties: Noses.values,
  toDisplay: false,
  defaultValue: Noses.Default,
);
final PropertyCategory OutfitColor = PropertyCategory(
  id: PropertyCategoryIds.OutfitColor,
  getL10nName: (AppLocalizations l10n) {
    return l10n.property_category_outfit_colors;
  },
  iconFile: "assets/icons/outfit_color.svg",
  properties: OutfitColors.values,
  toDisplay: true,
  defaultValue: OutfitColors.PastelBlue,
);
final PropertyCategory OutfitType = PropertyCategory(
  id: PropertyCategoryIds.OutfitType,
  getL10nName: (AppLocalizations l10n) {
    return l10n.property_category_outfit_types;
  },
  iconFile: "assets/icons/outfit.svg",
  properties: OutfitTypes.values,
  toDisplay: true,
  defaultValue: OutfitTypes.Hoodie,
);
final PropertyCategory SkinColor = PropertyCategory(
  id: PropertyCategoryIds.SkinColor,
  getL10nName: (AppLocalizations l10n) {
    return l10n.property_category_skins;
  },
  iconFile: "assets/icons/skin.svg",
  properties: SkinColors.values,
  toDisplay: true,
  defaultValue: SkinColors.Brown,
);

// List of all the default property categories. The order here represents the
// tab order to display in the Customizer widget.
final List<PropertyCategory> defaultPropertyCategories = [
  HairStyle,
  HairColor,
  FacialHairType,
  FacialHairColor,
  EyeType,
  EyebrowType,
  NoseType,
  MouthType,
  SkinColor,
  OutfitType,
  OutfitColor,
  Accessory,
  Background,
];
