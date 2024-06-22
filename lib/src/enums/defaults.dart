// TODO : Voir pour réorganiser ça en objet avec les différents paramètres
// Objet "Hair" qui a une icone, un titre, un nom de paramètre

// TODO : Voir pour renommer le fichier une fois réorganisé

/// Default list of icons that are rendered in the bottom row, indicating
/// the attributes available to modify.
///
/// These icons come bundled with the library and the paths below
/// are indicative of that.
const List<String> defaultAttributeIcons = [
  "assets/icons/hair.svg",
  "assets/icons/haircolor.svg",
  "assets/icons/beard.svg",
  "assets/icons/beardcolor.svg",
  "assets/icons/outfit.svg",
  "assets/icons/outfitcolor.svg",
  "assets/icons/eyes.svg",
  "assets/icons/eyebrow.svg",
  "assets/icons/mouth.svg",
  "assets/icons/skin.svg",
  "assets/icons/accessories.svg",
];

/// Default list of titles that are rendered at the top of the widget,
/// indicating
/// which attribute the user is customizing.
const List<String> defaultAttributeTitles = [
  "Hairstyle",
  "Hair Colour",
  "Facial Hair",
  "Facial Hair Colour",
  "Outfit",
  "Outfit Colour",
  "Eyes",
  "Eyebrows",
  "Mouth",
  "Skin",
  "Accessories"
];

/// List of keys used internally by this library to dereference
/// attributes and their values in the business logic.
///
/// This aspect is not modifiable by you at any stage of the app.
const List<String> attributeKeys = [
  "topType",
  "hairColor",
  "facialHairType",
  "facialHairColor",
  "clotheType",
  "clotheColor",
  "eyeType",
  "eyebrowType",
  "mouthType",
  "skinColor",
  "accessoriesType",
];
