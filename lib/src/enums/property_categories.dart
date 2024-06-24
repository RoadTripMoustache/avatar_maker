import 'package:avatar_maker/src/enums/property_category_ids.dart';
import 'package:avatar_maker/src/enums/property_items/accessories.dart';
import 'package:avatar_maker/src/enums/property_items/background_style.dart';
import 'package:avatar_maker/src/enums/property_items/noses.dart';
import 'package:avatar_maker/src/enums/property_items/outfit_colors.dart';
import 'package:avatar_maker/src/enums/property_items/eyebrows.dart';
import 'package:avatar_maker/src/enums/property_items/eyes.dart';
import 'package:avatar_maker/src/enums/property_items/facial_hair_colors.dart';
import 'package:avatar_maker/src/enums/property_items/facial_hair_types.dart';
import 'package:avatar_maker/src/enums/property_items/hair_colors.dart';
import 'package:avatar_maker/src/enums/property_items/hair_styles.dart';
import 'package:avatar_maker/src/enums/property_items/outfit_types.dart';
import 'package:avatar_maker/src/enums/property_items/mouths.dart';
import 'package:avatar_maker/src/enums/property_items/skin_colors.dart';
import 'package:avatar_maker/src/models/property_category.dart';
import 'package:avatar_maker/src/models/property_item.dart';

// TODO : l10n
enum PropertyCategories implements PropertyCategory {
  HairStyle(
    PropertyCategoryIds.HairStyle,
    "Hairstyle",
    "assets/icons/hair.svg",
    HairStyles.values,
    true,
    HairStyles.Bald,
  ),
  HairColor(
    PropertyCategoryIds.HairColor,
    "Hair Colour",
    "assets/icons/hair_color.svg",
    HairColors.values,
    true,
    HairColors.Black,
  ),
  FacialHairType(
    PropertyCategoryIds.FacialHairType,
    "Facial Hair",
    "assets/icons/facial_hair.svg",
    FacialHairTypes.values,
    true,
    FacialHairTypes.Nothing,
  ),
  FacialHairColor(
    PropertyCategoryIds.FacialHairColor,
    "Facial Hair Colour",
    "assets/icons/facial_hair_color.svg",
    FacialHairColors.values,
    true,
    FacialHairColors.Black,
  ),
  OutfitType(
    PropertyCategoryIds.OutfitType,
    "Outfit",
    "assets/icons/outfit.svg",
    OutfitTypes.values,
    true,
    OutfitTypes.Hoodie,
  ),
  OutfitColor(
    PropertyCategoryIds.OutfitColor,
    "Outfit Color",
    "assets/icons/outfit_color.svg",
    OutfitColors.values,
    true,
    OutfitColors.PastelBlue,
  ),
  EyeType(
    PropertyCategoryIds.EyeType,
    "Eyes",
    "assets/icons/eyes.svg",
    Eyes.values,
    true,
    Eyes.Default,
  ),
  EyebrowType(
    PropertyCategoryIds.EyebrowType,
    "Eyebrows",
    "assets/icons/eyebrows.svg",
    Eyebrows.values,
    true,
    Eyebrows.Default,
  ),
  MouthType(
    PropertyCategoryIds.MouthType,
    "Mouth",
    "assets/icons/mouth.svg",
    Mouths.values,
    true,
    Mouths.Default,
  ),
  SkinColor(
    PropertyCategoryIds.SkinColor,
    "Skin",
    "assets/icons/skin.svg",
    SkinColors.values,
    true,
    SkinColors.Brown,
  ),
  Accessory(
    PropertyCategoryIds.Accessory,
    "Accessories",
    "assets/icons/accessories.svg",
    Accessories.values,
    true,
    Accessories.Nothing,
  ),
  Nose(
    PropertyCategoryIds.Nose,
    "Noses",
    "assets/icons/noses.svg",
    Noses.values,
    false,
    Noses.Default,
  ),
  Background(
    PropertyCategoryIds.Background,
    "Background",
    "assets/icons/background.svg",
    BackgroundStyles.values,
    false,
    BackgroundStyles.Transparent,
  );

  final PropertyCategoryIds id;
  final String name;
  final String iconFile;
  final List<PropertyItem> properties;
  final bool toDisplay;
  final PropertyItem defaultValue;

  const PropertyCategories(
    this.id,
    this.name,
    this.iconFile,
    this.properties,
    this.toDisplay,
    this.defaultValue,
  );
}
