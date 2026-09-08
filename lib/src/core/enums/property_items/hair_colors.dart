import "package:avatar_maker/src/core/models/property_item.dart";

/// List of all the hair colors displayed by default.
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
  SilverGray("#E8E1E1"),
  DarkGray("#212121"),
  LightGray("#78909C"),
  Purple("#8E24AA"),
  Fuchsia("#D81B60"),
  Blue("#0277BD"),
  Green("#1B5E20"),
  Copper("#B45A2A"),
  Chestnut("#5C3A21"),
  Burgundy("#6E2233"),
  Ginger("#E07A3E"),
  White("#F2F0EB"),
  Teal("#00796B"),
  Mint("#5FBFA0"),
  Lavender("#B39DDB");

  final String hexCode;

  const HairColors(this.hexCode);

  String get label => this.name;
  String get id => "HairColor/$name";
  String get value => this.hexCode;
}
