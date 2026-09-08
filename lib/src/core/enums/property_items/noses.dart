import "package:avatar_maker/src/core/models/property_item.dart";

/// List of all the noses displayed by default.
enum Noses implements PropertyItem {
  Default("""
  <g id="Nose/Default" transform="translate(28.000000, 40.000000)" opacity="0.16">
							<path d="M16,8 C16,12.418278 21.372583,16 28,16 L28,16 C34.627417,16 40,12.418278 40,8" id="Nose"></path>
						</g>
  """),
  Button("""<g id="Nose/Button" opacity="0.16"><ellipse cx="56" cy="52" rx="7" ry="5"/></g>"""),
  Wide("""<g id="Nose/Wide" opacity="0.16"><path d="M40,48 C40,56 47,60 56,60 C65,60 72,56 72,48"/></g>"""),
  Small("""<g id="Nose/Small" opacity="0.16"><path d="M50,49 C50,53 52,55 56,55 C60,55 62,53 62,49"/></g>"""),
  Nostrils("""<g id="Nose/Nostrils" opacity="0.16"><ellipse cx="50" cy="53" rx="3.5" ry="2.5"/><ellipse cx="62" cy="53" rx="3.5" ry="2.5"/></g>"""),
  Hooked("""<g id="Nose/Hooked" opacity="0.16"><path d="M50,41 C50,51 58,54 63,57 C58,59 52,58 50,55"/></g>"""),
  Upturned("""<g id="Nose/Upturned" opacity="0.16"><path d="M45,51 C49,58 63,58 67,51 C62,54 50,54 45,51"/></g>"""),
  Pointed("""<g id="Nose/Pointed" opacity="0.16"><path d="M56,40 L63,56 L49,56 Z"/></g>"""),
  Bulbous("""<g id="Nose/Bulbous" opacity="0.16"><ellipse cx="56" cy="52" rx="11" ry="8"/><ellipse cx="47" cy="55" rx="3" ry="2"/><ellipse cx="65" cy="55" rx="3" ry="2"/></g>"""),
  Roman("""<g id="Nose/Roman" opacity="0.16"><path d="M53,36 L53,51 C53,56 58,59 63,58 C57,62 50,58 50,51 L50,36 Z"/></g>""");

  final String svg;

  const Noses(this.svg);

  String get label => name;
  String get id => "Nose/${name}";
  String get value => svg;
}
