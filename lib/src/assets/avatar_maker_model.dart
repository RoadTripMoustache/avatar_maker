import 'package:flutter/foundation.dart';

// TODO : Trouver un meilleur nom à ce fichier
// TODO : Trouver une meilleure façon d'organiser les propriétés

/// Maps attribute keys to the attribute value list
final Map<String, AvatarMakerPropertyItem> avatarProperties = {
  "style": AvatarMakerPropertyItem(
    title: "Style",
    property: backgroundStyles,
  ),
  "topType": AvatarMakerPropertyItem(
    title: "Hair",
    property: TopTypes,
  ),
  "accessoriesType": AvatarMakerPropertyItem(
    title: "Accessory",
    property: AccessoriesTypes,
  ),
  "hairColor": AvatarMakerPropertyItem(
    title: "Hair\nColor",
    property: HairColors,
  ),
  "facialHairType": AvatarMakerPropertyItem(
    title: "Facial\nHair",
    property: FacialHairTypes,
  ),
  "facialHairColor": AvatarMakerPropertyItem(
    title: "F-Hair\nColor",
    property: FacialHairColors,
  ),
  "clotheType": AvatarMakerPropertyItem(
    title: "Outfit",
    property: ClotheTypes,
  ),
  "clotheColor": AvatarMakerPropertyItem(
    title: "Outfit\nColor",
    property: ClotheColors,
  ),
  "eyeType": AvatarMakerPropertyItem(
    title: "Eye",
    property: EyeTypes,
  ),
  "eyebrowType": AvatarMakerPropertyItem(
    title: "Eyebrow",
    property: EyebrowTypes,
  ),
  "mouthType": AvatarMakerPropertyItem(
    title: "Mouth",
    property: MouthTypes,
  ),
  "skinColor": AvatarMakerPropertyItem(
    title: "Skin",
    property: SkinColors,
  ),
};

/// Models the metadata needed for rendering widgets in the UI
class AttributeItem {
  String title;
  String? key;
  String? iconAsset;
  double? iconsize;

  AttributeItem(
      {this.iconsize, this.title = "Unnamed", this.key, this.iconAsset});
}

class AvatarMakerPropertyItem extends ChangeNotifier {
  String title;
  int choice;
  List<String>? property;

  AvatarMakerPropertyItem({
    this.title = "Unnamed",
    this.choice = 0,
    this.property,
  });
}

const String emptySVGIcon = '''
<svg xmlns="http://www.w3.org/2000/svg"  viewBox="-20 -20 80 80" width="80px" height="80px"><path fill="#dff0fe" stroke="#4788c7" stroke-miterlimit="10" d="M20,1C9.507,1,1,9.507,1,20s8.507,19,19,19s19-8.507,19-19 S30.493,1,20,1z M6,20c0-7.732,6.268-14,14-14c2.963,0,5.706,0.926,7.968,2.496L8.496,27.968C6.926,25.706,6,22.963,6,20z M20,34 c-2.963,0-5.706-0.926-7.968-2.496l19.472-19.472C33.074,14.294,34,17.037,34,20C34,27.732,27.732,34,20,34z"/></svg>
''';

const Map<String, int> defaultAvatarOptions = {
  'topType': 24,
  'accessoriesType': 0,
  'hairColor': 1,
  'facialHairType': 0,
  'facialHairColor': 1,
  'clotheType': 4,
  'eyeType': 6,
  'eyebrowType': 10,
  'mouthType': 8,
  'skinColor': 3,
  'clotheColor': 8,
  'style': 0,
  'graphicType': 0
};

const List<String> backgroundStyles = [
  'Transparent',
  'Circle',
];

// TODO : A déplacer dans le fichier dart qui contient les informations sur les top
const List<String> TopTypes = [
  'Bald',
  'Eyepatch',
  'Hijab',
  'Turban',
  'Hat',
  'I\'m not bald',
  'Flat',
  'from School',
  'Short n waved',
  'Short n curly',
  'The caesar',
  'Another caeser',
  'Short w/ dreads',
  'Short w/ lots of dreads',
  'Bob cut',
  'Bun',
  'Fro',
  'Its not short',
  'Long (Female)',
  'Curvy',
  'Shaggy',
  'Short w/ frizzle',
  'LongHairStraight',
  'LongHairStraight2',
  'LongHairStraightStrand',
  'Curly (Female)',
  'Long w/ dreads',
  'Frida',
  'Fro w/ band',
  'Long w/ shaved sides',
  'Mia Wallace',
  'WinterHat1',
  'WinterHat2',
  'Santa Hat',
  'Santa Hat w/ ears',
];

// TODO : A déplacer dans le fichier dart qui contient les informations sur les accessoires
const List<String> AccessoriesTypes = [
  'Nothing',
  'PrescriptionGlasses',
  'Another pair of prescriptions',
  'Round',
  'Sunglasses',
  'Wayfarers',
  'Kurt',
];

// TODO : A déplacer dans le fichier dart qui contient les informations sur les cheveux
const List<String> HairColors = [
  'Auburn',
  'Black',
  'Brown',
  'Blonde',
  'BlondeGolden',
  'BrownDark',
  'PastelPink',
  'Platinum',
  'Red',
  'SilverGray',
];

// TODO : A déplacer dans le fichier dart qui contient les informations sur les chapeaux
// TODO : ?? - This is the property I skipped on purpose
const List<String> HatColors = [
  'Black',
  'Blue01',
  'Blue02',
  'Blue03',
  'Gray01',
  'Gray02',
  'Heather',
  'PastelBlue',
  'PastelGreen',
  'PastelOrange',
  'PastelRed',
  'PastelYellow',
  'Pink',
  'Red',
  'White',
];

// TODO : A déplacer dans le fichier dart qui contient les informations sur le facial hair
const List<String> FacialHairTypes = [
  'Nothing',
  'Full Beard',
  'Beard, Light',
  'Moustache, Fancy',
  'That 80\'s moustache',
];

// TODO : A déplacer dans le fichier dart qui contient les informations sur le facial hair
const List<String> FacialHairColors = [
  'Auburn',
  'Black',
  'Blonde',
  'BlondeGolden',
  'Brown',
  'BrownDark',
  'Platinum',
  'Red',
];

// TODO : A déplacer dans le fichier dart qui contient les informations sur les vêtements
const List<String> ClotheTypes = [
  'Crew Neck Tee',
  'GraphicShirt',
  'Scoop-neck Tee',
  'ShirtVNeck',
  'Hoodie',
  'CollarSweater',
  'Overall',
  'Blazer + T-Shirt',
  'BlazerSweater',
];

// TODO : A déplacer dans le fichier dart qui contient les informations sur les vêtements
const List<String> ClotheColors = [
  'Blue01',
  'Blue02',
  'PastelYellow',
  'PastelGreen',
  'Gray02',
  'Black',
  'Blue03',
  'Gray01',
  'Heather',
  'PastelBlue',
  'PastelOrange',
  'PastelRed',
  'Pink',
  'Red',
  'White',
];

// TODO : A déplacer dans le fichier dart qui contient les informations sur les graphics
// TODO : Qu'est-ce que c'est ?? - Not implemented
const List<String> GraphicTypes = [
  'Cumbia',
  'Hola',
  'Bat',
  'Deer',
  'Diamond',
  'Pizza',
  'Resist',
  'Selena',
  'Bear',
  'SkullOutline',
  'Skull',
];

// TODO : A déplacer dans le fichier dart qui contient les informations sur les yeux
const List<String> EyeTypes = [
  'Default',
  'Happy',
  'Squint',
  'Close',
  'Cry',
  'Dizzy',
  'EyeRoll',
  'Hearts',
  'Side',
  'Surprised',
  'Wink',
  'WinkWacky',
];

// TODO : A déplacer dans le fichier dart qui contient les informations sur les sourcils
const List<String> EyebrowTypes = [
  'Default',
  'FlatNatural',
  'Angry',
  'AngryNatural',
  'DefaultNatural',
  'RaisedExcited',
  'RaisedExcitedNatural',
  'SadConcerned',
  'SadConcernedNatural',
  'UnibrowNatural',
  'UpDown',
  'UpDownNatural',
];

// TODO : A déplacer dans le fichier dart qui contient les informations sur la bouche
const List<String> MouthTypes = [
  'Concerned',
  'Default',
  'Sad',
  'Disbelief',
  'Eating',
  'Grimace',
  'ScreamOpen',
  'Serious',
  'Smile',
  'Tongue',
  'Twinkle',
  'Vomit',
];

// TODO : A déplacer dans le fichier dart qui contient les informations sur la peau
const List<String> SkinColors = [
  'White',
  'Peach',
  'Black',
  'Brown',
  'DarkBrown',
  'Yellow',
  'Tanned',
];
