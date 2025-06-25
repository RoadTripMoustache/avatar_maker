import "package:avatar_maker/src/core/models/property_item.dart";

/// List of all the outfits displayed by default.
enum OutfitColors implements PropertyItem {
  Black("#262E33"),
  LightBlue("#65C9FF"),
  Blue("#5199E4"),
  DarkBlue("#25557C"),
  LightGray("#E6E6E6"),
  Gray("#929598"),
  Heather("#3C4F5C"),
  PastelBlue("#B1E2FF"),
  PastelGreen("#A7FFC4"),
  PastelOrange("#FFDEB5"),
  PastelRed("#FFAFB9"),
  PastelYellow("#FFFFB1"),
  Pink("#FF488E"),
  Red("#FF5C5C"),
  White("#FFFFFF"),
  Green("#1B5E20"),
  Purple("#8E24AA"),
  Fuchsia("#D81B60"),
  Orange("#E64A19"),
  Lemon("#CDDC39");

  final String hexCode;

  const OutfitColors(this.hexCode);

  String get label => this.name;
  String get id => "Color/Outfit";
  String get value => this.hexCode;
}
