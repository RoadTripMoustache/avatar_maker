import "package:avatar_maker/src/core/models/property_item.dart";

/// List of all the accessories skin colors by default.
enum SkinColors implements PropertyItem {
  Tanned("""
  <g id="Skin/Tanned" mask="url(#mask-6)" fill="#FD9841">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g>
  """),
  Yellow("""
  <g id="Skin/Yellow" mask="url(#mask-6)" fill="#F8D25C">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g>
  """),
  White("""
  <g id="Skin/White" mask="url(#mask-6)" fill="#FFDBB4">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g>  """),
  Peach("""
  <g id="Skin/Pale" mask="url(#mask-6)" fill="#EDB98A">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g> 
  """),
  Brown("""
  <g id="Skin/Brown" mask="url(#mask-6)" fill="#D08B5B">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g>
  """),
  DarkBrown("""
  <g id="Skin/DarkBrown" mask="url(#mask-6)" fill="#AE5D29">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g> 
  """),
  Black("""
  <g id="Skin/Black" mask="url(#mask-6)" fill="#614335">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g>
  """);

  final String svg;

  const SkinColors(this.svg);

  String get label => this.name;

  String get value => this.svg;
}
