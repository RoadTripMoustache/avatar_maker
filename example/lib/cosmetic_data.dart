import "dart:math";

import "package:flutter/material.dart";
import "package:avatar_maker/avatar_maker.dart";

/// 16 effect colors for separate color selection.
List<EffectColorCosmeticItem> buildAllEffectColors() {
  return [
    EffectColorCosmeticItem(
      cosmeticId: "white",
      label: "Beyaz",
      tier: "basic",
      cost: 0,
      color: Colors.white,
    ),
    EffectColorCosmeticItem(
      cosmeticId: "amber",
      label: "Amber",
      tier: "basic",
      cost: 50,
      color: Colors.amber,
    ),
    EffectColorCosmeticItem(
      cosmeticId: "red",
      label: "Kirmizi",
      tier: "basic",
      cost: 50,
      color: Colors.red,
    ),
    EffectColorCosmeticItem(
      cosmeticId: "blue",
      label: "Mavi",
      tier: "basic",
      cost: 50,
      color: Colors.blue,
    ),
    EffectColorCosmeticItem(
      cosmeticId: "green",
      label: "Yesil",
      tier: "basic",
      cost: 50,
      color: Colors.green,
    ),
    EffectColorCosmeticItem(
      cosmeticId: "pink",
      label: "Pembe",
      tier: "basic",
      cost: 60,
      color: Colors.pink,
    ),
    EffectColorCosmeticItem(
      cosmeticId: "purple",
      label: "Mor",
      tier: "basic",
      cost: 60,
      color: Colors.purple,
    ),
    EffectColorCosmeticItem(
      cosmeticId: "cyan",
      label: "Camgobegi",
      tier: "basic",
      cost: 60,
      color: Colors.cyan,
    ),
    EffectColorCosmeticItem(
      cosmeticId: "orange",
      label: "Turuncu",
      tier: "basic",
      cost: 70,
      color: Colors.orange,
    ),
    EffectColorCosmeticItem(
      cosmeticId: "light_blue",
      label: "Aci Mavi",
      tier: "basic",
      cost: 70,
      color: Colors.lightBlue,
    ),
    EffectColorCosmeticItem(
      cosmeticId: "lime",
      label: "Lime",
      tier: "basic",
      cost: 70,
      color: Colors.lime,
    ),
    EffectColorCosmeticItem(
      cosmeticId: "deep_purple",
      label: "Koyu Mor",
      tier: "illustrated",
      cost: 120,
      color: Colors.deepPurple,
    ),
    EffectColorCosmeticItem(
      cosmeticId: "indigo",
      label: "Indigo",
      tier: "illustrated",
      cost: 120,
      color: Colors.indigo,
    ),
    EffectColorCosmeticItem(
      cosmeticId: "teal",
      label: "Teal",
      tier: "illustrated",
      cost: 120,
      color: Colors.teal,
    ),
    EffectColorCosmeticItem(
      cosmeticId: "gold",
      label: "Altin",
      tier: "premium",
      cost: 200,
      color: Color(0xFFFFD700),
    ),
    EffectColorCosmeticItem(
      cosmeticId: "neon_cyan",
      label: "Neon Camgobegi",
      tier: "premium",
      cost: 250,
      color: Color(0xFF00E5FF),
    ),
  ];
}

/// 50 unique gradient backgrounds organized by tier.
/// UX: Tier progression (basic → illustrated → premium) with increasing
/// visual complexity and cost. Colors follow color theory principles.
List<BackgroundCosmeticItem> buildAllBackgrounds() {
  return [
    // ── BASIC (18 items, cost 50-180) ──────────────────────────
    _bg("white", "Beyaz", "basic", 50, [Color(0xFFFFFFFF), Color(0xFFF5F5F5)]),
    _bg("light_gray", "Aci Grip", "basic", 50, [Color(0xFFE0E0E0), Color(0xFFBDBDBD)]),
    _bg("mint", "Nane", "basic", 60, [Color(0xFFB2DFDB), Color(0xFF80CBC4)]),
    _bg("baby_blue", "Bebek Mavi", "basic", 60, [Color(0xFFBBDEFB), Color(0xFF90CAF9)]),
    _bg("blush", "Kizarma", "basic", 65, [Color(0xFFFCE4EC), Color(0xFFF8BBD0)]),
    _bg("cream", "Krem", "basic", 65, [Color(0xFFFFF8E1), Color(0xFFFFECB3)]),
    _bg("lavender", "Lavanta", "basic", 70, [Color(0xFFE8EAF6), Color(0xFFC5CAE9)]),
    _bg("peach", "Sekrapeynir", "basic", 75, [Color(0xFFFFE0B2), Color(0xFFFFCC80)]),
    _bg("sky", "Gokyuzu", "basic", 80, [Color(0xFFB3E5FC), Color(0xFF81D4FA)]),
    _bg("seafoam", "Deniz Kopugu", "basic", 85, [Color(0xFFB2EBF2), Color(0xFF80DEEA)]),
    _bg("lilac", "Morgul", "basic", 90, [Color(0xFFE1BEE7), Color(0xFFCE93D8)]),
    _bg("sand", "Kum", "basic", 95, [Color(0xFFD7CCC8), Color(0xFFBCAAA4)]),
    _bg("ice", "Buz", "basic", 100, [Color(0xFFE0F7FA), Color(0xFFB2EBF2)]),
    _bg("rose_quartz", "Gul Kuarci", "basic", 110, [Color(0xFFF8BBD0), Color(0xFFF48FB1)]),
    _bg("powder", "Pudra", "basic", 120, [Color(0xFFF3E5F5), Color(0xFFE1BEE7)]),
    _bg("sage", "Adacayi", "basic", 130, [Color(0xFFDCEDC8), Color(0xFFC5E1A5)]),
    _bg("coral_soft", "Yumusak Mercan", "basic", 140, [Color(0xFFFFCCBC), Color(0xFFFFAB91)]),
    _bg("denim", "Kot", "basic", 150, [Color(0xFFBBDEFB), Color(0xFF90CAF9)]),

    // ── ILLUSTRATED (17 items, cost 180-400) ──────────────────
    _bg("sunset", "Gun Batimi", "illustrated", 180, [Color(0xFFFF6B35), Color(0xFFF7C59F)]),
    _bg("ocean", "Okyanus", "illustrated", 190, [Color(0xFF0077B6), Color(0xFF00B4D8)]),
    _bg("forest", "Orman", "illustrated", 200, [Color(0xFF1B4332), Color(0xFF2D6A4F)]),
    _bg("cherry", "Cicek", "illustrated", 210, [Color(0xFFFFAFCC), Color(0xFFFFC8DD)]),
    _bg("autumn", "Sonbahar", "illustrated", 220, [Color(0xFFFF8C00), Color(0xFF8B4513)]),
    _bg("sakura", "Sakura", "illustrated", 230, [Color(0xFFFFB7C5), Color(0xFFFF69B4)]),
    _bg("aurora", "Aurora", "illustrated", 240, [Color(0xFF1A237E), Color(0xFF00BCD4), Color(0xFF76FF03)]),
    _bg("ember", "Kor", "illustrated", 250, [Color(0xFFD84315), Color(0xFFFF6D00)]),
    _bg("royal_blue", "Kraliyet Mavi", "illustrated", 260, [Color(0xFF1565C0), Color(0xFF42A5F5)]),
    _bg("tropical", "Tropikal", "illustrated", 270, [Color(0xFF00695C), Color(0xFF26A69A), Color(0xFF80CBC4)]),
    _bg("candy", "Sekeri", "illustrated", 280, [Color(0xFFE91E63), Color(0xFFF48FB1)]),
    _bg("midnight", "Gece", "illustrated", 290, [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)]),
    _bg("spring", "Ilkbahar", "illustrated", 300, [Color(0xFF81C784), Color(0xFF66BB6A), Color(0xFFA5D6A7)]),
    _bg("dusk", "Alacakaranlik", "illustrated", 310, [Color(0xFF4A148C), Color(0xFF7B1FA2), Color(0xFFCE93D8)]),
    _bg("rust", "Pas", "illustrated", 320, [Color(0xFFBF360C), Color(0xFFE64A19)]),
    _bg("jade", "Yakut", "illustrated", 330, [Color(0xFF004D40), Color(0xFF00897B)]),
    _bg("blush_rose", "Gul Kizarmasi", "illustrated", 350, [Color(0xFFAD1457), Color(0xFFEC407A)]),

    // ── PREMIUM (15 items, cost 400-800) ─────────────────────
    _bg("neon", "Neon", "premium", 400, [Color(0xFF7400B8), Color(0xFF5390D9)]),
    _bg("royal", "Kraliyet", "premium", 420, [Color(0xFF4B0082), Color(0xFFDAA520)]),
    _bg("cosmic", "Kozmik", "premium", 450, [Color(0xFF0D0221), Color(0xFF0F084B), Color(0xFF26408B)]),
    _bg("fire", "Ates", "premium", 460, [Color(0xFFB71C1C), Color(0xFFFF6F00), Color(0xFFFFCA28)]),
    _bg("galaxy", "Galaksi", "premium", 500, [Color(0xFF0A0E27), Color(0xFF1A237E), Color(0xFF4A148C)]),
    _bg("lava", "Lav", "premium", 520, [Color(0xFF1B0000), Color(0xFFB71C1C), Color(0xFFFF6F00)]),
    _bg("emerald", "Zumrut", "premium", 540, [Color(0xFF004D40), Color(0xFF1B5E20), Color(0xFF4CAF50)]),
    _bg("sapphire", "Safir", "premium", 560, [Color(0xFF0D47A1), Color(0xFF1565C0), Color(0xFF42A5F5)]),
    _bg("pearl", "Inci", "premium", 580, [Color(0xFFECEFF1), Color(0xFFB0BEC5), Color(0xFF78909C)]),
    _bg("obsidian", "Obsidyen", "premium", 600, [Color(0xFF212121), Color(0xFF424242), Color(0xFF616161)]),
    _bg("golden", "Altin", "premium", 650, [Color(0xFFFF8F00), Color(0xFFFFD54F), Color(0xFFF57F17)]),
    _bg("midnight_blue", "Gece Mavisi", "premium", 680, [Color(0xFF0D1B2A), Color(0xFF1B2838), Color(0xFF2E4057)]),
    _bg("rainbow", "Gokkusagi", "premium", 700, [Color(0xFFE53935), Color(0xFFFF9800), Color(0xFFFFEB3B), Color(0xFF4CAF50), Color(0xFF2196F3), Color(0xFF9C27B0)]),
    _bg("void", "Boslik", "premium", 750, [Color(0xFF000000), Color(0xFF1A0033), Color(0xFF330066)]),
    _bg("divine", "Ilahi", "premium", 800, [Color(0xFFFFD700), Color(0xFFFFFFFF), Color(0xFFFFD700)]),
  ];
}

/// Cosmetic effects across animated, Lottie-inspired, and full-background effect types.
List<EffectCosmeticItem> buildAllEffects() {
  return [
    // ── BASIC (18 items, cost 50-180) ──────────────────────────
    _fx("stars_white", "Beyaz Yildiz", "basic", 50, EffectType.stars, [Colors.white]),
    _fx("aura_light_blue", "Acik Mavi Aura", "basic", 55, EffectType.aura, [Color(0xFF81D4FA)]),
    _fx("hearts_red", "Kirmizi Kalpler", "basic", 60, EffectType.hearts, [Colors.red]),
    _fx("snowflakes_light", "Hafif Kar", "basic", 65, EffectType.snowflakes, [Colors.lightBlueAccent]),
    _fx("sparkles_silver", "Gumus Parlati", "basic", 70, EffectType.sparkles, [Colors.grey]),
    _fx("birds_gray", "Gri Kuslar", "basic", 75, EffectType.birds, [Colors.blueGrey]),
    _fx("stars_blue", "Mavi Yildiz", "basic", 80, EffectType.stars, [Colors.blue]),
    _fx("aura_pink", "Pembe Aura", "basic", 85, EffectType.aura, [Colors.pinkAccent]),
    _fx("flames_candle", "Mum Alevi", "basic", 90, EffectType.flames, [Colors.yellow]),
    _fx("butterflies_white", "Beyaz Kelebek", "basic", 95, EffectType.butterflies, [Colors.white]),
    _fx("hearts_orange", "Turuncu Kalpler", "basic", 100, EffectType.hearts, [Colors.orange]),
    _fx("snowflakes_blue", "Mavi Kar", "basic", 105, EffectType.snowflakes, [Colors.cyan]),
    _fx("stars_green", "Yesil Yildiz", "basic", 110, EffectType.stars, [Colors.green]),
    _fx("aura_purple", "Mor Aura", "basic", 120, EffectType.aura, [Colors.deepPurpleAccent]),
    _fx("sparkles_white", "Beyaz Parlati", "basic", 130, EffectType.sparkles, [Colors.white]),
    _fx("birds_brown", "Kahverengi Kuslar", "basic", 140, EffectType.birds, [Colors.brown]),
    _fx("flames_camp", "Kamp Atesi", "basic", 150, EffectType.flames, [Color(0xFFFF6D00)]),
    _fx("particles_gold", "Altin Toz", "basic", 170, EffectType.particles, [Colors.amber]),
    _fx("bubbles_blue", "Mavi Baloncuk", "basic", 180, EffectType.bubbles, [Colors.lightBlue]),
    _fx("mist_white", "Beyaz Sis", "basic", 190, EffectType.mist, [Colors.white]),
    _fx("wavy_lines", "Dalga Cizgileri", "illustrated", 390, EffectType.wavyLines, [Colors.cyan]),
    _fx("orbit_dots", "Yorunge Noktalari", "illustrated", 400, EffectType.orbitDots, [Colors.amber]),
    _fx("rotating_ring", "Dönen Halka", "premium", 500, EffectType.rotatingRing, [Colors.purpleAccent]),
    _fx("abstract_shapes", "Soyut Sekiller", "premium", 550, EffectType.abstractShapes, [Colors.deepOrange]),

    // ── ILLUSTRATED (17 items, cost 180-400) ──────────────────
    _fx("stars_gold", "Altin Yildiz", "illustrated", 180, EffectType.stars, [Colors.amber]),
    _fx("hearts_pink", "Pembe Kalpler", "illustrated", 190, EffectType.hearts, [Colors.pink]),
    _fx("butterflies_blue", "Mavi Kelebek", "illustrated", 200, EffectType.butterflies, [Colors.lightBlue]),
    _fx("sparkles_gold", "Altin Parlati", "illustrated", 210, EffectType.sparkles, [Colors.amberAccent]),
    _fx("flames_red", "Kirmizi Alev", "illustrated", 220, EffectType.flames, [Colors.deepOrange]),
    _fx("snowflakes_crystal", "Kristal Kar", "illustrated", 230, EffectType.snowflakes, [Colors.white]),
    _fx("aura_green", "Yesil Aura", "illustrated", 240, EffectType.aura, [Colors.greenAccent]),
    _fx("birds_red", "Kirmizi Kuslar", "illustrated", 250, EffectType.birds, [Colors.redAccent]),
    _fx("stars_purple", "Mor Yildiz", "illustrated", 260, EffectType.stars, [Colors.purpleAccent]),
    _fx("hearts_lime", "Yesil Kalpler", "illustrated", 270, EffectType.hearts, [Colors.lightGreen]),
    _fx("butterflies_pink", "Pembe Kelebek", "illustrated", 280, EffectType.butterflies, [Colors.pinkAccent]),
    _fx("sparkles_pink", "Pembe Parlati", "illustrated", 290, EffectType.sparkles, [Colors.pinkAccent]),
    _fx("flames_purple", "Mor Alev", "illustrated", 300, EffectType.flames, [Colors.purple]),
    _fx("snowflakes_mint", "Nane Kar", "illustrated", 310, EffectType.snowflakes, [Color(0xFF80CBC4)]),
    _fx("aura_red", "Kirmizi Aura", "illustrated", 320, EffectType.aura, [Colors.redAccent]),
    _fx("birds_blue", "Mavi Kuslar", "illustrated", 340, EffectType.birds, [Colors.blueAccent]),
    _fx("bubbles_pink", "Pembe Baloncuk", "illustrated", 360, EffectType.bubbles, [Colors.pinkAccent]),
    _fx("particles_purple", "Mor Toz", "illustrated", 370, EffectType.particles, [Colors.deepPurpleAccent]),
    _fx("mist_blue", "Mavi Sis", "illustrated", 380, EffectType.mist, [Colors.cyan]),

    // ── PREMIUM (15 items, cost 400-800) ─────────────────────
    _fx("stars_rainbow", "Gokkusagi Yildiz", "premium", 400, EffectType.stars, [Colors.amber]),
    _fx("hearts_gold", "Altin Kalpler", "premium", 420, EffectType.hearts, [Colors.amber]),
    _fx("butterflies_neon", "Neon Kelebek", "premium", 440, EffectType.butterflies, [Color(0xFF76FF03)]),
    _fx("sparkles_diamond", "Elmas Parlati", "premium", 460, EffectType.sparkles, [Colors.white]),
    _fx("flames_blue", "Mavi Alev", "premium", 480, EffectType.flames, [Colors.cyan]),
    _fx("snowflakes_ice", "Buz Kar", "premium", 500, EffectType.snowflakes, [Color(0xFFE0F7FA)]),
    _fx("aura_fire", "Ateş Aura", "premium", 520, EffectType.aura, [Color(0xFFFF6D00)]),
    _fx("birds_gold", "Altin Kuslar", "premium", 540, EffectType.birds, [Colors.amber]),
    _fx("stars_cosmic", "Kozmik Yildiz", "premium", 560, EffectType.stars, [Color(0xFF7C4DFF)]),
    _fx("hearts_neon", "Neon Kalpler", "premium", 580, EffectType.hearts, [Color(0xFFFF1744)]),
    _fx("butterflies_rainbow", "Gokkusagi Kelebek", "premium", 600, EffectType.butterflies, [Colors.purple]),
    _fx("sparkles_cosmic", "Kozmik Parlati", "premium", 650, EffectType.sparkles, [Color(0xFF7C4DFF)]),
    _fx("flames_solar", "Gunes Alevi", "premium", 700, EffectType.flames, [Color(0xFFFFD600)]),
    _fx("snowflakes_crystal_purple", "Kristal Kar", "premium", 750, EffectType.snowflakes, [Color(0xFFB388FF)]),
    _fx("bubbles_rainbow", "Gokkusagi Baloncuk", "premium", 720, EffectType.bubbles, [Colors.cyan, Colors.pinkAccent, Colors.amber]),
    _fx("particles_diamond", "Elmas Toz", "premium", 760, EffectType.particles, [Colors.white, Colors.lightBlueAccent]),
    _fx("rising_bubbles", "Yukari Cikan Balonlar", "premium", 770, EffectType.risingBubbles, [Colors.cyan, Colors.lightBlueAccent]),
    _fx("flying_objects", "Ucus Nesneler", "premium", 775, EffectType.flyingObjects, [Colors.amberAccent]),
    _fx("push_symbols", "Itisen Semboller", "premium", 785, EffectType.pushSymbols, [Colors.deepPurpleAccent, Colors.pinkAccent]),
    _fx("color_waves", "Renk Dalgaları", "premium", 795, EffectType.colorWaves, [Colors.cyan, Colors.pinkAccent, Colors.amber]),
    _fx("growing_vines", "Buyuyen Sarmaşik", "premium", 805, EffectType.growingVines, [Colors.lightGreenAccent]),
    _fx("network_web", "Ag Haritasi", "premium", 815, EffectType.networkWeb, [Colors.lightBlueAccent]),
    _fx("infinity_snake", "Sonsuzluk Yilanı", "premium", 825, EffectType.infinitySnake, [Colors.deepPurpleAccent, Colors.cyan]),
    _fx("graph_nodes", "Grafik Aglari", "premium", 835, EffectType.graphNodes, [Colors.cyanAccent]),
    _fx("water_droplets", "Su Damlalari", "premium", 845, EffectType.waterDroplets, [Colors.lightBlueAccent]),
    _fx("liquid_metaballs", "Sivi Metaboller", "premium", 855, EffectType.liquidMetaballs, [Colors.pinkAccent, Colors.purpleAccent]),
    _fx("morph_shapes", "Sekil Degistiren", "premium", 865, EffectType.morphShapes, [Colors.amber, Colors.deepOrange]),
    _fx("geometric_constellation", "Geometrik Burc", "premium", 875, EffectType.geometricConstellation, [Colors.lightGreenAccent, Colors.cyanAccent]),
    EffectCosmeticItem(
      cosmeticId: "custom_rainbow_sweep",
      label: "Özel Gökkuşağı",
      tier: "premium",
      cost: 900,
      effectType: EffectType.colorWaves,
      colors: [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.purple],
      customBuilder: (context, size, colors) {
        return CustomPaint(
          size: Size(size, size),
          painter: CustomRainbowSweepPainter(colors: colors),
        );
      },
    ),
    _fx("mist_purple", "Mor Sis", "premium", 780, EffectType.mist, [Colors.deepPurpleAccent, Colors.lightBlueAccent]),
    _fx("wavy_lines_gold", "Altin Dalga", "premium", 790, EffectType.wavyLines, [Colors.amber]),
    _fx("orbit_dots_pink", "Pembe Yorunge", "premium", 810, EffectType.orbitDots, [Colors.pinkAccent]),
    _fx("rotating_ring_blue", "Mavi Halka", "premium", 820, EffectType.rotatingRing, [Colors.cyan]),
    _fx("abstract_shapes_neon", "Neon Soyut", "premium", 830, EffectType.abstractShapes, [Color(0xFF00E5FF), Colors.pinkAccent]),
    _fx("birds_neon", "Neon Kuslar", "premium", 800, EffectType.birds, [Color(0xFF00E5FF)]),
  ];
}

BackgroundCosmeticItem _bg(
  String id, String label, String tier, int cost, List<Color> colors,
) {
  return BackgroundCosmeticItem(
    cosmeticId: id,
    label: label,
    tier: tier,
    cost: cost,
    colors: colors,
  );
}

EffectCosmeticItem _fx(
  String id, String label, String tier, int cost,
  EffectType type, List<Color> colors,
) {
  return EffectCosmeticItem(
    cosmeticId: id,
    label: label,
    tier: tier,
    cost: cost,
    effectType: type,
    colors: colors,
  );
}

class CustomRainbowSweepPainter extends CustomPainter {
  final List<Color> colors;

  CustomRainbowSweepPainter({required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide * 0.42;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 5; i++) {
      final colorIndex = i % colors.length;
      paint.color = colors[colorIndex].withValues(alpha: 0.35);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - i * 7),
        -pi / 2 + i * 0.25,
        pi * 1.4,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomRainbowSweepPainter oldDelegate) {
    return oldDelegate.colors != colors;
  }
}
