import "package:avatar_maker/avatar_maker.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("EffectThumbnailPainter.shouldRepaint", () {
    test("ignores color list identity when the content is equal", () {
      // `buildThumbnail` maps the item colors into a fresh list on every
      // build, so an identity check repainted every visible thumbnail (and
      // dropped its raster cache entry) on every customizer rebuild.
      final first = EffectThumbnailPainter(
        effectType: EffectType.stars,
        colors: const [Color(0xFF00E5FF)],
      );
      final second = EffectThumbnailPainter(
        effectType: EffectType.stars,
        colors: [const Color(0xFF00E5FF)],
      );

      expect(identical(first.colors, second.colors), isFalse);
      expect(second.shouldRepaint(first), isFalse);
      expect(
        EffectThumbnailPainter(
          effectType: EffectType.hearts,
          colors: const [Color(0xFF00E5FF)],
        ).shouldRepaint(first),
        isTrue,
      );
    });
  });

  group("CosmeticEffectGlowPainter.shouldRepaint", () {
    test("ignores color list identity when the content is equal", () {
      final first = CosmeticEffectGlowPainter(
        effectType: EffectType.stars,
        colors: const [Color(0xFF00E5FF)],
      );
      // `EffectCosmeticItemWithColor` hands the effect a freshly allocated
      // `[color]` list on every build. With an identity check the (large,
      // blurred) glow was re-rasterized on every avatar rebuild.
      final second = CosmeticEffectGlowPainter(
        effectType: EffectType.stars,
        colors: [const Color(0xFF00E5FF)],
      );

      expect(identical(first.colors, second.colors), isFalse,
          reason: "the lists must be distinct instances for this test to "
              "be meaningful");
      expect(second.shouldRepaint(first), isFalse);
    });

    test("repaints when the color content or the effect type changes", () {
      final base = CosmeticEffectGlowPainter(
        effectType: EffectType.stars,
        colors: const [Color(0xFF00E5FF)],
      );

      expect(
        CosmeticEffectGlowPainter(
          effectType: EffectType.stars,
          colors: const [Color(0xFFFF0000)],
        ).shouldRepaint(base),
        isTrue,
      );
      expect(
        CosmeticEffectGlowPainter(
          effectType: EffectType.hearts,
          colors: const [Color(0xFF00E5FF)],
        ).shouldRepaint(base),
        isTrue,
      );
    });
  });

  group("CosmeticEffectPainter", () {
    test("reads the live phase straight from the animation", () {
      final animation = AnimationController(
        vsync: const TestVSync(),
        duration: const Duration(seconds: 1),
      );
      addTearDown(animation.dispose);

      final painter = CosmeticEffectPainter(
        effectType: EffectType.stars,
        phase: 0,
        colors: const [],
        animation: animation,
      );

      expect(painter.phase, 0);
      animation.value = 0.42;
      expect(painter.phase, closeTo(0.42, 1e-9),
          reason: "the painter must follow the controller so a tick repaints "
              "without rebuilding the widget");
    });

    test("falls back to the constructor phase when no animation is given", () {
      final painter = CosmeticEffectPainter(
        effectType: EffectType.stars,
        phase: 0.25,
        colors: const [],
      );

      expect(painter.phase, 0.25,
          reason: "the previous constructor-only usage must keep working");
    });

    test("does not repaint for an equal color list with a new identity", () {
      final first = CosmeticEffectPainter(
        effectType: EffectType.stars,
        phase: 0,
        colors: const [Color(0xFF00E5FF)],
      );

      expect(
        CosmeticEffectPainter(
          effectType: EffectType.stars,
          phase: 0,
          colors: [const Color(0xFF00E5FF)],
        ).shouldRepaint(first),
        isFalse,
      );
      expect(
        CosmeticEffectPainter(
          effectType: EffectType.stars,
          phase: 0.5,
          colors: const [Color(0xFF00E5FF)],
        ).shouldRepaint(first),
        isTrue,
      );
      expect(
        CosmeticEffectPainter(
          effectType: EffectType.hearts,
          phase: 0,
          colors: const [Color(0xFF00E5FF)],
        ).shouldRepaint(first),
        isTrue,
      );
    });
  });
}
