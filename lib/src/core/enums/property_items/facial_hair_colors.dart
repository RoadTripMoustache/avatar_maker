import "package:avatar_maker/src/core/models/property_item.dart";

/// List of all the facial hair colors displayed by default.
enum FacialHairColors implements PropertyItem {
  Auburn("#A55728"),
  Black("#2C1B18"),
  Blonde("#B58143"),
  BlondeGolden("#D6B370"),
  Brown("#724133"),
  BrownDark("#4A312C"),
  PastelPink("#F59797"),
  Platinum("#ECDCBF"),
  Red("#C93305"),
  SilverGray("#E8E1E1"),
  DarkGray("#444444"),
  LightGray("#78909C"),
  Purple("#8E24AA"),
  Fuchsia("#D81B60"),
  Blue("#0277BD"),
  Green("#1B5E20");

  final String hexCode;

  const FacialHairColors(this.hexCode);

  String get label => this.name;
  String get id => "Color/FacialHair";
  String get value => this.hexCode;
}
