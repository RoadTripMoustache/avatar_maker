// TODO : Trouver un meilleur nom à ce fichier

/// Models the metadata needed for rendering widgets in the UI
/*class AttributeItem {
  String title;
  String? key;
  String? iconAsset;
  double? iconsize;

  AttributeItem(
      {this.iconsize, this.title = "Unnamed", this.key, this.iconAsset});
}

// TODO : Checker pour voir si c'est encore utile
// TODO : Voir à quoi sert le ChangeNotifier
// TODO : Voir pour mettre les différents objets dans des fichiers dédiés dans models
class AvatarMakerPropertyItem extends ChangeNotifier {
  String title;
  int choice;
  List<PropertyItem> properties;

  AvatarMakerPropertyItem({
    required this.title,
    required this.properties,
    this.choice = 0,
  });
}*/

const String emptySVGIcon = '''
<svg xmlns="http://www.w3.org/2000/svg"  viewBox="-20 -20 80 80" width="80px" height="80px"><path fill="#dff0fe" stroke="#4788c7" stroke-miterlimit="10" d="M20,1C9.507,1,1,9.507,1,20s8.507,19,19,19s19-8.507,19-19 S30.493,1,20,1z M6,20c0-7.732,6.268-14,14-14c2.963,0,5.706,0.926,7.968,2.496L8.496,27.968C6.926,25.706,6,22.963,6,20z M20,34 c-2.963,0-5.706-0.926-7.968-2.496l19.472-19.472C33.074,14.294,34,17.037,34,20C34,27.732,27.732,34,20,34z"/></svg>
''';


// TODO : A déplacer dans une enum
// TODO : Pas implémenté
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
