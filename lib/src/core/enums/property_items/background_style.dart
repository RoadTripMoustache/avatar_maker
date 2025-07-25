import "package:avatar_maker/src/core/models/property_item.dart";

/// List of all the background styles displayed by default.
enum BackgroundStyles implements PropertyItem {
  Transparent(""),
  Circle("""
<g id="Circle" stroke-width="1" fill-rule="evenodd" transform="translate(12.000000, 40.000000)">
<mask id="mask-2" fill="white"><use xlink:href="#path-1">
</use>
</mask>
<use id="Circle-Background" fill="#E6E6E6" xlink:href="#path-1"></use>
<g id="Color/Palette/Blue-01" mask="url(#mask-2)" fill="#65C9FF">
<rect id="🖍Color" x="0" y="0" width="240" height="240"></rect>
</g>
</g>
<mask id="mask-4" fill="white"><use xlink:href="#path-3"></use></mask>""");

  final String svg;

  const BackgroundStyles(this.svg);

  String get label => this.name;
  String get id => this.name.toLowerCase();
  String get value => this.svg;
}
