import "package:avatar_maker/src/core/models/property_item.dart";

/// 50 additional mouth styles contributed as SVG assets.
enum MouthsExtra implements PropertyItem {
  Default("""<g id=\"Mouth/Default\" transform=\"translate(2,52)\"><path d=\"M42,74 Q56,70 70,74 Q56,78 42,74 Z\" /><path d=\"M45,74 Q56,82 67,74 Z\" /></g>"""),
  Neutral("""<g id=\"Mouth/Neutral\" transform=\"translate(2,52)\"><path d=\"M42,76 Q56,74 70,76 Q56,79 42,76 Z\" /><path d=\"M45,76 Q56,81 67,76 Z\" /></g>"""),
  Smile("""<g id=\"Mouth/Smile\" transform=\"translate(2,52)\"><path d=\"M40,72 Q56,68 72,72 Q56,78 40,72 Z\" /><path d=\"M44,72 Q56,84 68,72 Z\" /></g>"""),
  BigSmile("""<g id=\"Mouth/BigSmile\" transform=\"translate(2,52)\"><path d=\"M38,70 Q56,66 74,70 Q56,78 38,70 Z\" /><path d=\"M42,70 Q56,86 70,70 Z\" /></g>"""),
  SmallSmile("""<g id=\"Mouth/SmallSmile\" transform=\"translate(2,52)\"><path d=\"M46,73 Q56,70 66,73 Q56,77 46,73 Z\" /><path d=\"M48,73 Q56,80 64,73 Z\" /></g>"""),
  Frown("""<g id=\"Mouth/Frown\" transform=\"translate(2,52)\"><path d=\"M42,72 Q56,78 70,72 Q56,75 42,72 Z\" /><path d=\"M45,72 Q56,80 67,72 Z\" /></g>"""),
  Open("""<g id=\"Mouth/Open\" transform=\"translate(2,52)\"><path d=\"M42,74 Q56,70 70,74 L68,82 Q56,88 44,82 Z\" /><path d=\"M45,76 Q56,81 67,76 Q56,85 45,76 Z\" /></g>"""),
  OpenWide("""<g id=\"Mouth/OpenWide\" transform=\"translate(2,52)\"><path d=\"M40,73 Q56,69 72,73 L69,84 Q56,92 43,84 Z\" /><path d=\"M44,75 Q56,82 68,75 Q56,88 44,75 Z\" /></g>"""),
  OpenSmall("""<g id=\"Mouth/OpenSmall\" transform=\"translate(2,52)\"><path d=\"M46,74 Q56,71 66,74 L65,80 Q56,84 47,80 Z\" /><path d=\"M48,75 Q56,79 64,75 Q56,82 48,75 Z\" /></g>"""),
  ToothSmile("""<g id=\"Mouth/ToothSmile\" transform=\"translate(2,52)\"><path d=\"M40,72 Q56,68 72,72 Q56,78 40,72 Z\" /><path d=\"M42,72 Q56,76 70,72 L69,76 Q56,80 43,76 Z\" /></g>"""),
  Buck("""<g id=\"Mouth/Buck\" transform=\"translate(2,52)\"><path d=\"M40,74 Q56,70 72,74 Q56,78 40,74 Z\" /><path d=\"M46,74 Q56,80 66,74 Z\" /><path d=\"M50,74 L62,74 L62,79 L50,79 Z\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.35\" stroke-width=\"1\" stroke-linecap=\"round\" /></g>"""),
  Full("""<g id=\"Mouth/Full\" transform=\"translate(2,52)\"><path d=\"M41,73 Q56,69 71,73 Q56,84 41,73 Z\" /></g>"""),
  Thin("""<g id=\"Mouth/Thin\" transform=\"translate(2,52)\"><path d=\"M42,75 Q56,73 70,75 Q56,78 42,75 Z\" /></g>"""),
  Wide("""<g id=\"Mouth/Wide\" transform=\"translate(2,52)\"><path d=\"M39,75 Q56,72 73,75 Q56,78 39,75 Z\" /></g>"""),
  Narrow("""<g id=\"Mouth/Narrow\" transform=\"translate(2,52)\"><path d=\"M46,75 Q56,73 66,75 Q56,78 46,75 Z\" /></g>"""),
  Pout("""<g id=\"Mouth/Pout\" transform=\"translate(2,52)\"><path d=\"M43,73 Q56,69 69,73 Q56,84 43,73 Z\" /></g>"""),
  Kiss("""<g id=\"Mouth/Kiss\" transform=\"translate(2,52)\"><path d=\"M46,73 Q56,70 66,73 Q56,79 46,73 Z\" /></g>"""),
  Grin("""<g id=\"Mouth/Grin\" transform=\"translate(2,52)\"><path d=\"M40,72 Q56,68 72,72 Q56,79 40,72 Z\" /><path d=\"M43,72 Q56,82 69,72 Z\" /></g>"""),
  Sneer("""<g id=\"Mouth/Sneer\" transform=\"translate(2,52)\"><path d=\"M42,73 Q50,70 56,73 Q62,70 70,73 Q56,78 42,73 Z\" /><path d=\"M46,73 Q56,79 66,73 Z\" /></g>"""),
  Confused("""<g id=\"Mouth/Confused\" transform=\"translate(2,52)\"><path d=\"M44,72 Q52,74 56,73 Q60,72 68,75 Q56,78 44,72 Z\" /></g>"""),
  Surprised("""<g id=\"Mouth/Surprised\" transform=\"translate(2,52)\"><path d=\"M48,74 C48,68 64,68 64,74 C64,80 48,80 48,74 Z\" /></g>"""),
  O("""<g id=\"Mouth/O\" transform=\"translate(2,52)\"><path d=\"M49,73 C49,67 63,67 63,73 C63,79 49,79 49,73 Z\" /></g>"""),
  Ooh("""<g id=\"Mouth/Ooh\" transform=\"translate(2,52)\"><path d=\"M48,73 C48,67 64,67 64,73 C64,81 48,81 48,73 Z\" /></g>"""),
  Tongue("""<g id=\"Mouth/Tongue\" transform=\"translate(2,52)\"><path d=\"M43,73 Q56,70 69,73 Q56,80 43,73 Z\" /><path d=\"M48,74 Q56,86 64,74 Q56,80 48,74 Z\" /></g>"""),
  Teeth("""<g id=\"Mouth/Teeth\" transform=\"translate(2,52)\"><path d=\"M42,73 Q56,70 70,73 L69,77 Q56,80 43,77 Z\" /></g>"""),
  LowerLipOut("""<g id=\"Mouth/LowerLipOut\" transform=\"translate(2,52)\"><path d=\"M43,73 Q56,70 69,73 Q56,77 43,73 Z\" /><path d=\"M45,74 Q56,86 67,74 Z\" /></g>"""),
  UpperLipOut("""<g id=\"Mouth/UpperLipOut\" transform=\"translate(2,52)\"><path d=\"M43,74 Q56,68 69,74 Q56,79 43,74 Z\" /><path d=\"M46,74 Q56,81 66,74 Z\" /></g>"""),
  Heart("""<g id=\"Mouth/Heart\" transform=\"translate(2,52)\"><path d=\"M56,84 C46,76 42,71 45,68 C48,65 52,67 56,71 C60,67 64,65 67,68 C70,71 66,76 56,84 Z\" /></g>"""),
  Tiny("""<g id=\"Mouth/Tiny\" transform=\"translate(2,52)\"><path d=\"M49,75 Q56,73 63,75 Q56,78 49,75 Z\" /></g>"""),
  Big("""<g id=\"Mouth/Big\" transform=\"translate(2,52)\"><path d=\"M38,73 Q56,68 74,73 Q56,85 38,73 Z\" /></g>"""),
  Asym("""<g id=\"Mouth/Asym\" transform=\"translate(2,52)\"><path d=\"M42,74 Q56,70 70,75 Q56,79 42,74 Z\" /><path d=\"M45,74 Q56,82 67,75 Z\" /></g>"""),
  Cleft("""<g id=\"Mouth/Cleft\" transform=\"translate(2,52)\"><path d=\"M42,74 Q56,70 70,74 Q56,78 42,74 Z\" /><path d=\"M45,74 Q56,82 67,74 Z\" /><path d=\"M56,71 L56,74\" fill=\"none\" stroke=\"#000000\" stroke-opacity=\"0.35\" stroke-width=\"1\" stroke-linecap=\"round\" /></g>"""),
  MShape("""<g id=\"Mouth/MShape\" transform=\"translate(2,52)\"><path d=\"M44,74 L52,71 L56,73 L60,71 L68,74 Q56,78 44,74 Z\" /><path d=\"M46,74 Q56,81 66,74 Z\" /></g>"""),
  Flat("""<g id=\"Mouth/Flat\" transform=\"translate(2,52)\"><path d=\"M42,75 Q56,73 70,75 Q56,77 42,75 Z\" /></g>"""),
  Smirk("""<g id=\"Mouth/Smirk\" transform=\"translate(2,52)\"><path d=\"M42,74 Q50,71 58,73 Q64,74 70,72 Q64,78 42,74 Z\" /></g>"""),
  Biting("""<g id=\"Mouth/Biting\" transform=\"translate(2,52)\"><path d=\"M44,74 Q56,72 68,74 Q56,76 44,74 Z\" /></g>"""),
  Pursed("""<g id=\"Mouth/Pursed\" transform=\"translate(2,52)\"><path d=\"M48,74 C48,70 64,70 64,74 C64,79 48,79 48,74 Z\" /></g>"""),
  Whistle("""<g id=\"Mouth/Whistle\" transform=\"translate(2,52)\"><path d=\"M46,74 Q56,71 66,74 Q56,77 46,74 Z\" /></g>"""),
  Contour("""<g id=\"Mouth/Contour\" transform=\"translate(2,52)\"><path d=\"M43,73 Q56,69 69,73 Q56,79 43,73 Z\" /></g>"""),
  WideOpen("""<g id=\"Mouth/WideOpen\" transform=\"translate(2,52)\"><path d=\"M40,72 Q56,67 72,72 L70,86 Q56,94 42,86 Z\" /></g>"""),
  SmileOpen("""<g id=\"Mouth/SmileOpen\" transform=\"translate(2,52)\"><path d=\"M41,72 Q56,68 71,72 Q56,80 41,72 Z\" /><path d=\"M44,72 Q56,86 68,72 Z\" /></g>"""),
  SideSmile("""<g id=\"Mouth/SideSmile\" transform=\"translate(2,52)\"><path d=\"M42,74 Q48,70 56,72 Q64,75 70,73 Q64,79 42,74 Z\" /></g>"""),
  Ducky("""<g id=\"Mouth/Ducky\" transform=\"translate(2,52)\"><path d=\"M44,74 Q50,71 56,73 Q62,71 68,74 Q56,80 44,74 Z\" /></g>"""),
  Bow("""<g id=\"Mouth/Bow\" transform=\"translate(2,52)\"><path d=\"M46,73 Q56,71 66,73 Q56,76 46,73 Z\" /></g>"""),
  FlatGrin("""<g id=\"Mouth/FlatGrin\" transform=\"translate(2,52)\"><path d=\"M40,74 Q56,71 72,74 Q56,78 40,74 Z\" /><path d=\"M44,74 Q56,80 68,74 Z\" /></g>"""),
  OpenGrin("""<g id=\"Mouth/OpenGrin\" transform=\"translate(2,52)\"><path d=\"M40,72 Q56,68 72,72 L70,84 Q56,90 42,84 Z\" /><path d=\"M43,73 Q56,78 69,73 Q56,86 43,73 Z\" /></g>"""),
  PursedRound("""<g id=\"Mouth/PursedRound\" transform=\"translate(2,52)\"><path d=\"M50,73 C50,68 62,68 62,73 C62,79 50,79 50,73 Z\" /></g>"""),
  Subtle("""<g id=\"Mouth/Subtle\" transform=\"translate(2,52)\"><path d=\"M45,75 Q56,73 67,75 Q56,78 45,75 Z\" /></g>"""),
  BigTeeth("""<g id=\"Mouth/BigTeeth\" transform=\"translate(2,52)\"><path d=\"M40,72 Q56,68 72,72 Q56,78 40,72 Z\" /><path d=\"M42,72 Q56,75 70,72 L69,78 Q56,81 43,78 Z\" /></g>"""),
  Fangs("""<g id=\"Mouth/Fangs\" transform=\"translate(2,52)\"><path d=\"M42,73 Q56,70 70,73 Q56,79 42,73 Z\" /><path d=\"M45,73 L49,73 L48,80 L45,80 Z M63,73 L67,73 L67,80 L64,80 Z\" /></g>"""),
  LipsSealed("""<g id=\"Mouth/LipsSealed\" transform=\"translate(2,52)\"><path d=\"M43,74 Q56,71 69,74 Q56,77 43,74 Z\" /></g>"""),
  SoftSmile("""<g id=\"Mouth/SoftSmile\" transform=\"translate(2,52)\"><path d=\"M43,74 Q56,70 69,74 Q56,79 43,74 Z\" /><path d=\"M46,74 Q56,81 66,74 Z\" /></g>""");

  final String svg;

  const MouthsExtra(this.svg);

  String get label => name;
  String get id => "Mouth/$name";
  String get value => svg;
}
