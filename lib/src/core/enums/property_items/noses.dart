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
  Roman("""<g id="Nose/Roman" opacity="0.16"><path d="M53,36 L53,51 C53,56 58,59 63,58 C57,62 50,58 50,51 L50,36 Z"/></g>"""),
  Round("""
  <g id="Nose/Round" opacity="0.16"><ellipse cx="56" cy="52" rx="8" ry="6"/></g>
  """),
  Narrow("""
  <g id="Nose/Narrow" opacity="0.16"><path d="M54,38 L54,52 C54,55 57,57 60,56 C57,59 51,57 51,52 L51,38 Z"/></g>
  """),
  Snub("""
  <g id="Nose/Snub" opacity="0.16"><path d="M48,53 C50,58 62,58 64,53 C61,55 51,55 48,53 Z"/></g>
  """),
  Long("""
  <g id="Nose/Long" opacity="0.16"><path d="M54,34 L54,54 C54,58 58,60 63,59 C58,62 51,59 51,54 L51,34 Z"/></g>
  """),
  Flat("""
  <g id="Nose/Flat" opacity="0.16"><path d="M44,52 C44,55 49,57 56,57 C63,57 68,55 68,52 C64,54 48,54 44,52 Z"/></g>
  """),
  Aquiline("""
  <g id="Nose/Aquiline" opacity="0.16"><path d="M52,38 C52,46 56,50 61,54 C57,58 50,56 50,50 L50,38 Z"/></g>
  """),
  Broad("""
  <g id="Nose/Broad" opacity="0.16"><path d="M38,47 C38,55 46,61 56,61 C66,61 74,55 74,47 C70,56 62,58 56,58 C50,58 42,56 38,47 Z"/></g>
  """),
  Dotted("""
  <g id="Nose/Dotted" opacity="0.16"><ellipse cx="56" cy="52" rx="6" ry="4.5"/><circle cx="46" cy="49" r="2"/><circle cx="66" cy="49" r="2"/></g>
  """),
  Pinched("""
  <g id="Nose/Pinched" opacity="0.16"><path d="M56,40 C60,48 62,53 60,56 C58,58 54,58 52,56 C50,53 52,48 56,40 Z"/></g>
  """),
  Bumped("""
  <g id="Nose/Bumped" opacity="0.16"><path d="M53,36 C53,44 50,48 52,53 C54,57 60,58 63,56 C58,57 55,54 56,49 C57,44 56,40 53,36 Z"/></g>
  """);

  final String svg;

  const Noses(this.svg);

  String get label => name;
  String get id => "Nose/${name}";
  String get value => svg;
}
