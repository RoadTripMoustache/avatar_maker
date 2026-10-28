import "package:avatar_maker/src/core/models/property_item.dart";

/// List of all the noses displayed by default.
enum Noses implements PropertyItem {
  Default("""
  <g id="Nose/Default" transform="translate(28.000000, 40.000000)" opacity="0.16">
							<path d="M16,8 C16,12.418278 21.372583,16 28,16 L28,16 C34.627417,16 40,12.418278 40,8" id="Nose"></path>
						</g>
  """),
  Button(
      """<g id="Nose/Button" opacity="0.16"><ellipse cx="56" cy="52" rx="7" ry="5"/></g>"""),
  Wide(
      """<g id="Nose/Wide" opacity="0.16"><path d="M40,48 C40,56 47,60 56,60 C65,60 72,56 72,48"/></g>"""),
  Small(
      """<g id="Nose/Small" opacity="0.16"><path d="M50,49 C50,53 52,55 56,55 C60,55 62,53 62,49"/></g>"""),
  Nostrils(
      """<g id="Nose/Nostrils" opacity="0.16"><ellipse cx="50" cy="53" rx="3.5" ry="2.5"/><ellipse cx="62" cy="53" rx="3.5" ry="2.5"/></g>"""),
  Hooked(
      """<g id="Nose/Hooked" opacity="0.16"><path d="M50,41 C50,51 58,54 63,57 C58,59 52,58 50,55"/></g>"""),
  Upturned(
      """<g id="Nose/Upturned" opacity="0.16"><path d="M45,51 C49,58 63,58 67,51 C62,54 50,54 45,51"/></g>"""),
  Pointed(
      """<g id="Nose/Pointed" opacity="0.16"><path d="M56,40 L63,56 L49,56 Z"/></g>"""),
  Bulbous(
      """<g id="Nose/Bulbous" opacity="0.16"><ellipse cx="56" cy="52" rx="11" ry="8"/><ellipse cx="47" cy="55" rx="3" ry="2"/><ellipse cx="65" cy="55" rx="3" ry="2"/></g>"""),
  Roman(
      """<g id="Nose/Roman" opacity="0.16"><path d="M53,36 L53,51 C53,56 58,59 63,58 C57,62 50,58 50,51 L50,36 Z"/></g>"""),
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
  Straight("""<g id=\"Nose/Straight\" None><path d=\"M54,38 L52,52 C52,55 56,57 60,56\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  Beak("""<g id=\"Nose/Beak\" None><path d=\"M56,40 L60,52 L66,56 L52,56 L52,50 Z\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  Soft("""<g id=\"Nose/Soft\" None><path d=\"M50,46 C50,52 53,55 56,55 C59,55 62,52 62,46\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  Defined("""<g id=\"Nose/Defined\" None><path d=\"M56,36 L56,52 C56,56 60,57 64,55\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  Tiny("""<g id=\"Nose/Tiny\" None><path d=\"M52,51 C52,54 54,55 56,55 C58,55 60,54 60,51\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  Big("""<g id=\"Nose/Big\" None><path d=\"M44,46 C44,53 49,58 56,58 C63,58 68,53 68,46\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  PigNose("""<g id=\"Nose/PigNose\" None><path d=\"M50,50 C50,54 52,56 56,56 C60,56 62,54 62,50\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /><ellipse cx=\"51\" cy=\"53\" rx=\"2\" ry=\"1.6\" fill=\"#000000\" fill-opacity=\"0.2\"/><ellipse cx=\"61\" cy=\"53\" rx=\"2\" ry=\"1.6\" fill=\"#000000\" fill-opacity=\"0.2\"/></g>"""),
  Sharp("""<g id=\"Nose/Sharp\" None><path d=\"M56,42 L58,52 L62,56 L50,56 L54,52 Z\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  Cleft("""<g id=\"Nose/Cleft\" None><path d=\"M56,44 L56,52 M52,54 C54,57 58,57 60,54\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  Droopy("""<g id=\"Nose/Droopy\" None><path d=\"M48,48 C48,54 52,57 56,57 C60,57 64,54 64,48\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  UpturnedWide("""<g id=\"Nose/UpturnedWide\" None><path d=\"M42,50 C46,58 66,58 70,50 C64,54 48,54 42,50\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  Downturned("""<g id=\"Nose/Downturned\" None><path d=\"M46,46 C46,52 50,55 56,55 C62,55 66,52 66,46\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  Subtle("""<g id=\"Nose/Subtle\" None><path d=\"M50,50 C50,53 53,55 56,55 C59,55 62,53 62,50\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /><path d=\"M54,42 L54,48\" stroke=\"#000000\" stroke-opacity=\"0.1\" stroke-width=\"2\" fill=\"none\" stroke-linecap=\"round\"/></g>"""),
  Angular("""<g id=\"Nose/Angular\" None><path d=\"M56,38 L53,52 L56,56 L59,52 Z\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  Bridge("""<g id=\"Nose/Bridge\" None><path d=\"M54,36 L54,50 C54,54 58,56 62,54\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  WideBridge("""<g id=\"Nose/WideBridge\" None><path d=\"M52,36 L50,50 C50,55 62,55 62,50 L60,36\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  Crooked("""<g id=\"Nose/Crooked\" None><path d=\"M54,38 C53,46 51,50 53,54 C55,57 60,56 62,54\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  ButtonSmall("""<g id=\"Nose/ButtonSmall\" None><path d=\"M51,51 C51,54 53,55 56,55 C59,55 61,54 61,51\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  RomanHook("""<g id=\"Nose/RomanHook\" None><path d=\"M53,34 L52,48 C52,54 57,58 63,56 C58,61 50,57 50,50 L50,34 Z\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  FlatBridge("""<g id=\"Nose/FlatBridge\" None><path d=\"M46,50 C50,55 62,55 66,50 C62,53 50,53 46,50\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  Greek("""<g id=\"Nose/Greek\" None><path d=\"M56,36 L56,52 C56,56 59,57 62,56\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  Snake("""<g id=\"Nose/Snake\" None><path d=\"M50,50 C53,53 59,53 62,50 C60,55 52,55 50,50 Z\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  Fine("""<g id=\"Nose/Fine\" None><path d=\"M51,49 C51,53 53,55 56,55 C59,55 61,53 61,49\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  NostrilWide("""<g id=\"Nose/NostrilWide\" None><path d=\"M46,50 C46,54 50,57 56,57 C62,57 66,54 66,50\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /><ellipse cx=\"48\" cy=\"53\" rx=\"4\" ry=\"2.6\" fill=\"#000000\" fill-opacity=\"0.18\"/><ellipse cx=\"64\" cy=\"53\" rx=\"4\" ry=\"2.6\" fill=\"#000000\" fill-opacity=\"0.18\"/></g>"""),
  RoundedTip("""<g id=\"Nose/RoundedTip\" None><path d=\"M51,48 C51,54 54,57 56,57 C58,57 61,54 61,48\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  LongStraight("""<g id=\"Nose/LongStraight\" None><path d=\"M54,32 L53,52 C53,56 58,58 62,56\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  Distinct("""<g id=\"Nose/Distinct\" None><path d=\"M56,38 L55,50 C55,54 59,56 63,54\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  SoftBridge("""<g id=\"Nose/SoftBridge\" None><path d=\"M52,40 C52,48 51,52 54,55 C56,57 60,55 60,51\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  Classic("""<g id=\"Nose/Classic\" None><path d=\"M50,48 C50,53 52,56 56,56 C60,56 62,53 62,48\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  ButtonNose("""<g id=\"Nose/ButtonNose\" None><path d=\"M51,50 C51,54 53,56 56,56 C59,56 61,54 61,50\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  WideFlat("""<g id=\"Nose/WideFlat\" None><path d=\"M42,50 C42,54 48,57 56,57 C64,57 70,54 70,50\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  ThinNose("""<g id=\"Nose/ThinNose\" None><path d=\"M53,40 L52,52 C52,55 56,56 60,55\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  WideNostril("""<g id=\"Nose/WideNostril\" None><path d=\"M48,50 C48,55 51,57 56,57 C61,57 64,55 64,50\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /><ellipse cx=\"50\" cy=\"53\" rx=\"3\" ry=\"2\" fill=\"#000000\" fill-opacity=\"0.18\"/><ellipse cx=\"62\" cy=\"53\" rx=\"3\" ry=\"2\" fill=\"#000000\" fill-opacity=\"0.18\"/></g>"""),
  SharperHook("""<g id=\"Nose/SharperHook\" None><path d=\"M52,38 C51,48 50,52 54,55 C56,56 60,55 62,53\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  SoftButton("""<g id=\"Nose/SoftButton\" None><path d=\"M52,50 C52,53 54,55 56,55 C58,55 60,53 60,50\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  StraightBridge2("""<g id=\"Nose/StraightBridge2\" None><path d=\"M56,36 L55,50 C55,54 58,56 61,54\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),
  BroadTip("""<g id=\"Nose/BroadTip\" None><path d=\"M50,47 C50,54 53,57 56,57 C59,57 62,54 62,47\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.16\" stroke-width=\"2.6\" stroke-linecap=\"round\" stroke-linejoin=\"round\" /></g>"""),

  Bumped("""
  <g id="Nose/Bumped" opacity="0.16"><path d="M53,36 C53,44 50,48 52,53 C54,57 60,58 63,56 C58,57 55,54 56,49 C57,44 56,40 53,36 Z"/></g>
  """);

  final String svg;

  const Noses(this.svg);

  String get label => name;
  String get id => "Nose/${name}";
  String get value => svg;
}
