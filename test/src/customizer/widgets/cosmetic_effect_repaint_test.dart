import "dart:ui" as ui;

import "package:avatar_maker/avatar_maker.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter_test/flutter_test.dart";

/// Counts how many times a painter is asked to paint. Used as a "canary" to
/// detect how far up the layer tree an animated effect forces repaints.
class _CountingPainter extends CustomPainter {
  int paintCount = 0;

  @override
  void paint(Canvas canvas, Size size) {
    paintCount++;
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0x22000000),
    );
  }

  // Never request a repaint by itself – any repaint must be forced by an
  // ancestor layer being repainted.
  @override
  bool shouldRepaint(covariant _CountingPainter oldDelegate) => false;
}

void main() {
  testWidgets(
      "CosmeticEffectWidget splits the static glow from the animated particles "
      "into isolated repaint layers", (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: CosmeticEffectWidget(
            effectType: EffectType.stars,
            size: 120,
            colors: const [Colors.purple],
          ),
        ),
      ),
    );

    final painters = tester
        .widgetList<CustomPaint>(find.byType(CustomPaint))
        .map((paint) => paint.painter)
        .whereType<CustomPainter>()
        .toList();

    expect(painters.whereType<CosmeticEffectGlowPainter>(), hasLength(1),
        reason: "the static glow must be painted by its own painter");
    expect(painters.whereType<CosmeticEffectPainter>(), hasLength(1),
        reason: "the animated particles must be painted by their own painter");
    // One boundary for the glow, one for the animated particles.
    expect(find.byType(RepaintBoundary), findsNWidgets(2));
  });

  testWidgets(
      "animated effect repaints are isolated to the effect layer "
      "(sibling widgets do not repaint every frame)", (tester) async {
    final controller = NonPersistentAvatarMakerController();
    await controller.initController();
    controller.selectCosmetic(
      EffectCosmeticItem(
        cosmeticId: "bench_stars",
        label: "Stars",
        tier: "basic",
        cost: 0,
        effectType: EffectType.stars,
      ),
    );

    final siblingPainter = _CountingPainter();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          children: [
            // A static sibling that lives in the same layer as the avatar.
            Positioned.fill(
              child: CustomPaint(painter: siblingPainter),
            ),
            Center(
              child: AvatarMakerAvatar(
                controller: controller,
                radius: 100,
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );

    // First frame paints everything.
    final baseline = siblingPainter.paintCount;
    expect(baseline, greaterThan(0));

    // Advance the cosmetic effect animation across several frames.
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 16));
    }

    final delta = siblingPainter.paintCount - baseline;

    // Without repaint isolation the effect's per-frame repaint bubbles up to
    // the shared layer, repainting the sibling on every frame (delta == 10).
    // With a RepaintBoundary around the animated effect only its own layer is
    // repainted, so the sibling stays untouched (delta == 0).
    expect(
      delta,
      0,
      reason: "Static siblings must not repaint on every effect animation "
          "frame – the animated effect needs its own RepaintBoundary.",
    );
  });

  testWidgets(
      "animation ticks repaint the effect without rebuilding its widget subtree",
      (tester) async {
    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: CosmeticEffectWidget(
            effectType: EffectType.stars,
            size: 120,
            colors: const [Colors.purple],
          ),
        ),
      ),
    );

    // The animated (particle) layer is the second CustomPaint: the glow is
    // painted first, the particles on top.
    CustomPaint animatedLayer() =>
        tester.widgetList<CustomPaint>(find.byType(CustomPaint)).last;

    final firstWidget = animatedLayer();
    final firstPainter = firstWidget.painter!;
    expect(firstPainter, isA<CosmeticEffectPainter>());

    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    expect(identical(animatedLayer(), firstWidget), isTrue,
        reason: "a frame of the effect animation must not rebuild the effect "
            "subtree (the painter listens to the controller and repaints)");
    expect(identical(animatedLayer().painter, firstPainter), isTrue,
        reason: "the painter must be created once, not per frame");
    expect(
      (firstPainter as CosmeticEffectPainter).phase,
      greaterThan(0),
      reason: "the painter must still be driven by the live animation",
    );
  });

  testWidgets(
      "the effect layer keeps repainting as the animation advances "
      "(repaint wiring is live)", (tester) async {
    final key = GlobalKey();

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: RepaintBoundary(
            key: key,
            child: const CosmeticEffectWidget(
              effectType: EffectType.stars,
              size: 120,
              colors: [Colors.purple],
            ),
          ),
        ),
      ),
    );

    Future<Uint8List> snapshot() async {
      final boundary = key.currentContext!.findRenderObject()!
          as RenderRepaintBoundary;
      late Uint8List bytes;
      await tester.runAsync(() async {
        final image = await boundary.toImage();
        final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
        image.dispose();
        bytes = data!.buffer.asUint8List();
      });
      return bytes;
    }

    final firstFrame = await snapshot();
    await tester.pump(const Duration(milliseconds: 750));
    final secondFrame = await snapshot();

    expect(
      listEquals(firstFrame, secondFrame),
      isFalse,
      reason: "if the painter were not repainting (e.g. missing "
          "`super(repaint: animation)`) the two frames would be identical",
    );
  });
}
