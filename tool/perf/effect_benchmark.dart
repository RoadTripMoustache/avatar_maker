// Performance benchmark for the avatar_maker effect rendering pipeline.
//
// Run with:
//   flutter test tool/perf/effect_benchmark.dart
//
// This is a developer tool, not part of the CI test suite (it lives outside
// `test/`). It measures the two hot paths that the p763_quiz app hits when an
// animated cosmetic effect is equipped:
//
//  1. `AvatarMakerController.drawAvatarSVG()` – the SVG string generation that
//     runs on every rebuild of a non-preview avatar (home screen).
//  2. `CosmeticEffectPainter.paint()` – the per-frame CPU cost of recording the
//     effect, plus the rasterization cost (`Picture.toImage`) that dominates
//     once `MaskFilter.blur` glows are involved.

import "dart:ui" as ui;

import "package:avatar_maker/avatar_maker.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

const int _svgIterations = 2000;
const int _paintIterations = 120;
const double _size = 300;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test("drawAvatarSVG cost", () async {
    final controller = NonPersistentAvatarMakerController();
    await controller.initController();

    // Warm up.
    for (var i = 0; i < 100; i++) {
      controller.drawAvatarSVG();
    }

    final sw = Stopwatch()..start();
    for (var i = 0; i < _svgIterations; i++) {
      controller.drawAvatarSVG();
    }
    sw.stop();

    final perCallUs = sw.elapsedMicroseconds / _svgIterations;
    // ignore: avoid_print
    print(
      "BENCH drawAvatarSVG: ${perCallUs.toStringAsFixed(1)} us/call "
      "(${sw.elapsedMilliseconds} ms for $_svgIterations calls)",
    );
  });

  test("savedAvatarSVG cache hit cost", () async {
    final controller = NonPersistentAvatarMakerController();
    await controller.initController();

    // Prime the cache.
    controller.savedAvatarSVG;
    for (var i = 0; i < 100; i++) {
      controller.savedAvatarSVG;
    }

    const iterations = 200000;
    final sw = Stopwatch()..start();
    for (var i = 0; i < iterations; i++) {
      controller.savedAvatarSVG;
    }
    sw.stop();

    final perCallNs = sw.elapsedMicroseconds * 1000 / iterations;
    // ignore: avoid_print
    print(
      "BENCH savedAvatarSVG (cache hit): ${perCallNs.toStringAsFixed(0)} ns/call",
    );
  });

  test("CosmeticEffectPainter record + raster cost per effect", () async {
    final rows = <String>[];
    for (final type in EffectType.values) {
      final record = await _measureRecord(type);
      final raster = await _measureRaster(type);
      rows.add(
        "${type.name.padRight(24)} record=${record.toStringAsFixed(2)} ms/frame  "
        "raster=${raster.toStringAsFixed(2)} ms/frame",
      );
    }
    // ignore: avoid_print
    print("BENCH effect cost (${_size.toInt()}px, $_paintIterations frames):");
    for (final row in rows) {
      // ignore: avoid_print
      print("  $row");
    }
  });

  testWidgets(
      "frame pipeline: rebuild-per-frame vs repaint-only (ui thread)",
      (tester) async {
    const framesPerPass = 400;
    const passes = 3;

    final rebuild = <double>[];
    final repaint = <double>[];

    for (var pass = 0; pass < passes; pass++) {
      rebuild.add(await _measureFramePipeline(tester, true, framesPerPass));
      repaint.add(await _measureFramePipeline(tester, false, framesPerPass));
    }

    double minOf(List<double> v) => v.reduce((a, b) => a < b ? a : b);
    double meanOf(List<double> v) => v.reduce((a, b) => a + b) / v.length;

    // ignore: avoid_print
    print(
      "BENCH frame ui cost (${_size.toInt()}px) over $passes x $framesPerPass "
      "frames:",
    );
    // ignore: avoid_print
    print(
      "  rebuild-per-frame (old): mean=${meanOf(rebuild).toStringAsFixed(1)} us  "
      "min=${minOf(rebuild).toStringAsFixed(1)} us",
    );
    // ignore: avoid_print
    print(
      "  repaint-only     (new): mean=${meanOf(repaint).toStringAsFixed(1)} us  "
      "min=${minOf(repaint).toStringAsFixed(1)} us",
    );
  });
}

/// Runs [frames] animation frames of the same effect with one of the two
/// wirings and returns the average microseconds per frame.
///
///  * `rebuild: true`  – the previous wiring: `AnimatedBuilder` rebuilds the
///    `CustomPaint` and allocates a fresh painter on every frame.
///  * `rebuild: false` – the current wiring: one painter instance that listens
///    to the controller, so a tick only invalidates the layer's paint.
Future<double> _measureFramePipeline(
  WidgetTester tester,
  bool rebuild,
  int frames,
) async {
  final controller = AnimationController(
    vsync: tester,
    duration: const Duration(seconds: 3),
  )..repeat();

  Widget layer() {
    if (rebuild) {
      return AnimatedBuilder(
        animation: controller,
        builder: (context, child) => CustomPaint(
          painter: CosmeticEffectPainter(
            effectType: EffectType.stars,
            phase: controller.value,
            colors: const [Color(0xFF7C4DFF)],
          ),
        ),
      );
    }
    return CustomPaint(
      painter: CosmeticEffectPainter(
        effectType: EffectType.stars,
        phase: 0,
        colors: const [Color(0xFF7C4DFF)],
        animation: controller,
      ),
    );
  }

  await tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: RepaintBoundary(
          child: SizedBox(
            width: _size,
            height: _size,
            child: layer(),
          ),
        ),
      ),
    ),
  );

  // Warm up.
  for (var i = 0; i < 60; i++) {
    await tester.pump(const Duration(milliseconds: 16));
  }

  final sw = Stopwatch()..start();
  for (var i = 0; i < frames; i++) {
    await tester.pump(const Duration(milliseconds: 16));
  }
  sw.stop();

  controller.dispose();
  return sw.elapsedMicroseconds / frames;
}

Future<double> _measureRecord(EffectType type) async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  final size = const Size(_size, _size);

  // Warm up.
  for (var i = 0; i < 20; i++) {
    CosmeticEffectPainter(
      effectType: type,
      phase: i / 20,
      colors: const [Color(0xFF7C4DFF)],
    ).paint(canvas, size);
  }
  recorder.endRecording().dispose();

  final sw = Stopwatch()..start();
  for (var i = 0; i < _paintIterations; i++) {
    final r = ui.PictureRecorder();
    final c = Canvas(r);
    CosmeticEffectPainter(
      effectType: type,
      phase: (i % _paintIterations) / _paintIterations,
      colors: const [Color(0xFF7C4DFF)],
    ).paint(c, size);
    r.endRecording().dispose();
  }
  sw.stop();
  return sw.elapsedMicroseconds / _paintIterations / 1000;
}

Future<double> _measureRaster(EffectType type) async {
  final size = const Size(_size, _size);

  Future<double> onePass(int iterations) async {
    final sw = Stopwatch()..start();
    for (var i = 0; i < iterations; i++) {
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      CosmeticEffectPainter(
        effectType: type,
        phase: (i % iterations) / iterations,
        colors: const [Color(0xFF7C4DFF)],
      ).paint(canvas, size);
      final picture = recorder.endRecording();
      final image = await picture.toImage(
        size.width.toInt(),
        size.height.toInt(),
      );
      image.dispose();
      picture.dispose();
    }
    sw.stop();
    return sw.elapsedMicroseconds / iterations / 1000;
  }

  await onePass(5); // warm up
  return onePass(_paintIterations ~/ 4);
}
