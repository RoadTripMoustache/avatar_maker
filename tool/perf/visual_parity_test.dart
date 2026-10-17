// Visual-parity harness for the effect rendering refactor.
//
// It renders every effect at several animation phases into raw RGBA files so
// that a "before" run (pristine lib, PARITY_MODE=legacy) and an "after" run
// (PARITY_MODE=new) can be compared byte-for-byte:
//
//   PARITY_MODE=new PARITY_OUT=<dir> flutter test tool/perf/visual_parity_test.dart
//
// Environment:
//   PARITY_MODE = legacy | new   (which composition to render)
//   PARITY_OUT  = output directory for the .rgba dumps
//
// `legacy` renders the pristine single-painter composition (glow + particles
// in one CustomPaint). `new` renders the refactored two-layer composition
// (static glow layer + animated particle layer), which is what
// CosmeticEffectWidget now builds.
//
// A second dump renders the full `AvatarMakerAvatar` (gradient background +
// SVG + effect at phase 0) so the end-to-end composition can be compared too.

import "dart:io";
import "dart:ui" as ui;

import "package:avatar_maker/avatar_maker.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter_test/flutter_test.dart";

const double kSize = 240;
const List<double> kPhases = [0.0, 0.13, 0.5, 0.87];
const List<Color> kColors = [
  Color(0xFF7C4DFF),
  Color(0xFF00E5FF),
  Color(0xFFFFC107),
];

Future<void> _dump(
  WidgetTester tester,
  GlobalKey key,
  String path,
) async {
  final boundary = key.currentContext!.findRenderObject()!;
  await tester.runAsync(() async {
    final image = await (boundary as RenderRepaintBoundary)
        .toImage(pixelRatio: 1);
    final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    image.dispose();
    File(path).writeAsBytesSync(data!.buffer.asUint8List());
  });
}

void main() {
  final mode = Platform.environment["PARITY_MODE"] ?? "new";
  final outDir = Platform.environment["PARITY_OUT"] ?? "build/parity/$mode";

  testWidgets("dump effect frames ($mode)", (tester) async {
    const key = ValueKey("capture");
    Directory(outDir).createSync(recursive: true);

    for (final type in EffectType.values) {
      for (final phase in kPhases) {
        await tester.pumpWidget(
          Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: RepaintBoundary(
                key: key,
                child: SizedBox(
                  width: kSize,
                  height: kSize,
                  child: mode == "legacy"
                      ? CustomPaint(
                          size: const Size(kSize, kSize),
                          painter: CosmeticEffectPainter(
                            effectType: type,
                            phase: phase,
                            colors: kColors,
                          ),
                        )
                      : Stack(
                          fit: StackFit.expand,
                          children: [
                            RepaintBoundary(
                              child: CustomPaint(
                                painter: CosmeticEffectGlowPainter(
                                  effectType: type,
                                  colors: kColors,
                                ),
                              ),
                            ),
                            RepaintBoundary(
                              child: CustomPaint(
                                willChange: true,
                                painter: CosmeticEffectPainter(
                                  effectType: type,
                                  phase: phase,
                                  colors: kColors,
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
        );
        await tester.pump();

        final boundary =
            tester.renderObject<RenderRepaintBoundary>(find.byKey(key));
        await tester.runAsync(() async {
          final image = await boundary.toImage(pixelRatio: 1);
          final data =
              await image.toByteData(format: ui.ImageByteFormat.rawRgba);
          image.dispose();
          File("$outDir/${type.name}_${(phase * 100).round()}.rgba")
              .writeAsBytesSync(data!.buffer.asUint8List());
        });
      }
    }
    // ignore: avoid_print
    print("PARITY dumped ${EffectType.values.length * kPhases.length} frames "
        "to $outDir");
  });

  testWidgets("dump full avatar ($mode)", (tester) async {
    final key = GlobalKey();
    Directory(outDir).createSync(recursive: true);

    final controller = NonPersistentAvatarMakerController();
    await controller.initController();
    controller.selectCosmetic(
      BackgroundCosmeticItem(
        cosmeticId: "parity_bg",
        label: "Parity BG",
        tier: "basic",
        cost: 0,
        colors: const [Color(0xFF2196F3), Color(0xFF9C27B0)],
      ),
    );
    controller.selectCosmetic(
      EffectCosmeticItem(
        cosmeticId: "parity_effect",
        label: "Parity Effect",
        tier: "basic",
        cost: 0,
        effectType: EffectType.stars,
        colors: kColors,
      ),
    );

    await tester.pumpWidget(
      Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: RepaintBoundary(
            key: key,
            child: AvatarMakerAvatar(
              controller: controller,
              radius: 100,
              backgroundColor: const Color(0x22333333),
            ),
          ),
        ),
      ),
    );
    // A single frame: the effect animation is still at phase 0, so the render
    // is deterministic and comparable between the two runs.
    await tester.pump();

    await _dump(tester, key, "$outDir/avatar.rgba");
    // ignore: avoid_print
    print("PARITY dumped full avatar to $outDir");
  });
}
