import "package:avatar_maker/src/core/models/property_item.dart";

/// List of all the noses displayed by default.
enum Noses implements PropertyItem {
  Default("""
  <g id="Nose/Default" transform="translate(28.000000, 40.000000)" opacity="0.16">
							<path d="M16,8 C16,12.418278 21.372583,16 28,16 L28,16 C34.627417,16 40,12.418278 40,8" id="Nose"></path>
						</g>
  """);

  final String svg;

  const Noses(this.svg);

  String get label => this.name;
  String get value => this.svg;
}
