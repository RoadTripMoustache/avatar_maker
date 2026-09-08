import "package:avatar_maker/src/core/models/property_item.dart";

/// List of all the accessories skin colors by default.
enum SkinColors implements PropertyItem {
  Tanned("""
  <g id="SkinColor/Tanned" mask="url(#mask-6)" fill="#FD9841">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g>
  """),
  Yellow("""
  <g id="SkinColor/Yellow" mask="url(#mask-6)" fill="#F8D25C">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g>
  """),
  White("""
  <g id="SkinColor/White" mask="url(#mask-6)" fill="#FFDBB4">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g>  """),
  Peach("""
  <g id="SkinColor/Pale" mask="url(#mask-6)" fill="#EDB98A">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g> 
  """),
  Brown("""
  <g id="SkinColor/Brown" mask="url(#mask-6)" fill="#D08B5B">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g>
  """),
  DarkBrown("""
  <g id="SkinColor/DarkBrown" mask="url(#mask-6)" fill="#AE5D29">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g> 
  """),
  Black("""
  <g id="SkinColor/Black" mask="url(#mask-6)" fill="#614335">
    <g transform="translate(0.000000, 0.000000)" id="Color">
      <rect x="0" y="0" width="264" height="280" />
    </g>
  </g>
  """),
  Porcelain("""<g id="SkinColor/Porcelain" mask="url(#mask-6)" fill="#FFE9D6"><rect x="0" y="0" width="264" height="280"/></g>"""),
  Almond("""<g id="SkinColor/Almond" mask="url(#mask-6)" fill="#E0AC69"><rect x="0" y="0" width="264" height="280"/></g>"""),
  Olive("""<g id="SkinColor/Olive" mask="url(#mask-6)" fill="#C68642"><rect x="0" y="0" width="264" height="280"/></g>"""),
  Sienna("""<g id="SkinColor/Sienna" mask="url(#mask-6)" fill="#8D5524"><rect x="0" y="0" width="264" height="280"/></g>"""),
  Espresso("""<g id="SkinColor/Espresso" mask="url(#mask-6)" fill="#422B21"><rect x="0" y="0" width="264" height="280"/></g>"""),
  Stone("""<g id="SkinColor/Stone" mask="url(#mask-6)" fill="#B9B3AC"><rect x="0" y="0" width="264" height="280"/></g>"""),
  Mint("""<g id="SkinColor/Mint" mask="url(#mask-6)" fill="#9FD8B8"><rect x="0" y="0" width="264" height="280"/></g>"""),
  Lilac("""<g id="SkinColor/Lilac" mask="url(#mask-6)" fill="#D3B8E8"><rect x="0" y="0" width="264" height="280"/></g>"""),
  Rose("""<g id="SkinColor/Rose" mask="url(#mask-6)" fill="#F0A8B8"><rect x="0" y="0" width="264" height="280"/></g>"""),
  Azure("""<g id="SkinColor/Azure" mask="url(#mask-6)" fill="#A9CBE8"><rect x="0" y="0" width="264" height="280"/></g>"""),
  Fern("""<g id="SkinColor/Fern" mask="url(#mask-6)" fill="#7FBF8A"><rect x="0" y="0" width="264" height="280"/></g>"""),
  Ivory("""
  <g id="SkinColor/Ivory" mask="url(#mask-6)" fill="#FFF0DE">
    <rect x="0" y="0" width="264" height="280" />
  </g>
  """),
  Bisque("""
  <g id="SkinColor/Bisque" mask="url(#mask-6)" fill="#F5D6B8">
    <rect x="0" y="0" width="264" height="280" />
  </g>
  """),
  Honey("""
  <g id="SkinColor/Honey" mask="url(#mask-6)" fill="#DEA96A">
    <rect x="0" y="0" width="264" height="280" />
  </g>
  """),
  Amber("""
  <g id="SkinColor/Amber" mask="url(#mask-6)" fill="#C98A4B">
    <rect x="0" y="0" width="264" height="280" />
  </g>
  """),
  Chestnut("""
  <g id="SkinColor/Chestnut" mask="url(#mask-6)" fill="#7A4A2A">
    <rect x="0" y="0" width="264" height="280" />
  </g>
  """),
  Mahogany("""
  <g id="SkinColor/Mahogany" mask="url(#mask-6)" fill="#5C3320">
    <rect x="0" y="0" width="264" height="280" />
  </g>
  """),
  Slate("""
  <g id="SkinColor/Slate" mask="url(#mask-6)" fill="#8A98A8">
    <rect x="0" y="0" width="264" height="280" />
  </g>
  """),
  Sand("""
  <g id="SkinColor/Sand" mask="url(#mask-6)" fill="#E8D2A8">
    <rect x="0" y="0" width="264" height="280" />
  </g>
  """),
  Coral("""
  <g id="SkinColor/Coral" mask="url(#mask-6)" fill="#F2A08A">
    <rect x="0" y="0" width="264" height="280" />
  </g>
  """),
  Violet("""
  <g id="SkinColor/Violet" mask="url(#mask-6)" fill="#B79BE0">
    <rect x="0" y="0" width="264" height="280" />
  </g>
  """);

  final String svg;

  const SkinColors(this.svg);

  String get label => this.name;

  String get id => "SkinColor/$name";

  String get value => this.svg;
}
