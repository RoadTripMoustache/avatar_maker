import "package:avatar_maker/src/models/property_item.dart";

enum HairColors implements PropertyItem {
  Auburn("#A55728"),
  Black("#2C1B18"),
  Blonde("#B58143"),
  BlondeGolden("#D6B370"),
  Brown("#724133"),
  BrownDark("#4A312C"),
  PastelPink("#F59797"),
  Platinum("#ECDCBF"),
  Red("#C93305"),
  SilverGray("#E8E1E1");

  final String hexCode;

  const HairColors(this.hexCode);

  String get label => this.name;

  String get value => this.hexCode;
}
