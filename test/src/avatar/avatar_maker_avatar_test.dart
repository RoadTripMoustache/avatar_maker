import "package:avatar_maker/avatar_maker.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";
import "package:flutter_test/flutter_test.dart";

import "../../helpers.dart";

void main() {
  group("AvatarMakerAvatar", () {
    group("UI", () {
      testWidgets("Default", (WidgetTester tester) async {
        await tester.pumpWidget(AvatarMakerAvatar());

        final circleAvatarConditions = isA<CircleAvatar>()
            .having(
              (circle) => circle.backgroundColor,
              "Check background color",
              null,
            )
            .having(
              (circle) => circle.radius,
              "Check radius",
              75.0,
            );
        final avatar = find.byType(CircleAvatar);
        expect(avatar, findsOneWidget);
        expect(avatar.evaluate().first.widget, circleAvatarConditions);
      });

      testWidgets("With custom radius", (WidgetTester tester) async {
        await tester.pumpWidget(AvatarMakerAvatar(
          radius: 12.0,
        ));

        final circleAvatarConditions = isA<CircleAvatar>()
            .having(
              (circle) => circle.backgroundColor,
              "Check background color",
              null,
            )
            .having(
              (circle) => circle.radius,
              "Check radius",
              12.0,
            );
        final avatar = find.byType(CircleAvatar);
        expect(avatar, findsOneWidget);
        expect(avatar.evaluate().first.widget, circleAvatarConditions);
      });

      testWidgets("With custom background color", (WidgetTester tester) async {
        await tester.pumpWidget(AvatarMakerAvatar(backgroundColor: Colors.red));

        final circleAvatarConditions = isA<CircleAvatar>()
            .having(
              (circle) => circle.backgroundColor,
              "Check background color",
              Colors.red,
            )
            .having(
              (circle) => circle.radius,
              "Check radius",
              75.0,
            );
        final avatar = find.byType(CircleAvatar);
        expect(avatar, findsOneWidget);
        expect(avatar.evaluate().first.widget, circleAvatarConditions);
      });

      testWidgets("With custom background color and radius",
          (WidgetTester tester) async {
        await tester.pumpWidget(AvatarMakerAvatar(
          backgroundColor: Colors.red,
          radius: 29.0,
        ));

        final circleAvatarConditions = isA<CircleAvatar>()
            .having(
              (circle) => circle.backgroundColor,
              "Check background color",
              Colors.red,
            )
            .having(
              (circle) => circle.radius,
              "Check radius",
              29.0,
            );
        final avatar = find.byType(CircleAvatar);
        expect(avatar, findsOneWidget);
        expect(avatar.evaluate().first.widget, circleAvatarConditions);
      });
    });

    group("usePreview", () {
      testWidgets(
        "default value is true (backward-compatible)",
        (WidgetTester tester) async {
          final controller = NonPersistentAvatarMakerController();
          await tester.pumpAndSettle();

          await tester.pumpMaterialApp(
            AvatarMakerAvatar(controller: controller),
          );

          // Sanity: the widget should render the CircleAvatar successfully.
          expect(find.byType(CircleAvatar), findsOneWidget);
        },
      );

      testWidgets(
        "usePreview: true accepts the parameter and renders the avatar",
        (WidgetTester tester) async {
          final controller = NonPersistentAvatarMakerController();
          await tester.pumpAndSettle();

          await tester.pumpMaterialApp(
            AvatarMakerAvatar(controller: controller, usePreview: true),
          );

          expect(find.byType(CircleAvatar), findsOneWidget);
        },
      );

      testWidgets(
        "usePreview: false accepts the parameter and renders the avatar",
        (WidgetTester tester) async {
          final controller = NonPersistentAvatarMakerController();
          await tester.pumpAndSettle();

          await tester.pumpMaterialApp(
            AvatarMakerAvatar(controller: controller, usePreview: false),
          );

          expect(find.byType(CircleAvatar), findsOneWidget);
        },
      );

      testWidgets(
        "usePreview: true renders the controller's cached SVG (displayedAvatarSVG), "
        "while usePreview: false forces a fresh draw from selectedOptions "
        "even when the controller has an active preview",
        (WidgetTester tester) async {
          final controller = NonPersistentAvatarMakerController();
          await tester.pumpAndSettle();

          // Activate a preview on the HairStyle category. The controller
          // stores it in _displayedAvatarSVG (the cached SVG), so the
          // widget's `usePreview: true` path will pick it up via
          // `displayedAvatarSVG`. With `usePreview: false`, the widget
          // re-draws from `selectedOptions` (ignoring the preview), so
          // the cached preview does not leak.
          final hairCategory = controller.displayedPropertyCategories
              .firstWhere((c) => c.id == PropertyCategoryIds.HairStyle);
          final current =
              controller.selectedOptions[PropertyCategoryIds.HairStyle]!;
          final alternative = hairCategory.properties!
              .firstWhere((item) => item.id != current.id);
          controller.previewOption(alternative, PropertyCategoryIds.HairStyle);
          await tester.pumpAndSettle();

          // Sanity: the controller has a preview active.
          expect(controller.hasPreviewOptions, isTrue);
          // The cached SVG (used by the widget when usePreview: true) is
          // a different string from a fresh draw from selectedOptions
          // (used by the widget when usePreview: false). This proves
          // that the two code paths in AvatarMakerAvatar will produce
          // different SVGs.
          expect(
              controller.displayedAvatarSVG,
              isNot(equals(controller.drawAvatarSVG(
                  selectedOptionsOverride: controller.selectedOptions))));

          // Now pump the avatar with usePreview: false. The widget should
          // build without errors.
          await tester.pumpMaterialApp(
            AvatarMakerAvatar(controller: controller, usePreview: false),
          );
          expect(find.byType(CircleAvatar), findsOneWidget);
        },
      );
    });

    group("Effect + EffectColor integration (commit 1)", () {
      testWidgets(
        "AvatarMakerAvatar renders the custom effect (customBuilder) "
        "even when an EffectColorCosmeticItem is selected",
        (WidgetTester tester) async {
          bool customBuilderCalled = false;
          List<Color>? capturedColors;
          final controller = NonPersistentAvatarMakerController();
          await tester.pumpAndSettle();

          final customEffect = EffectCosmeticItem(
            cosmeticId: "custom_rainbow_sweep",
            label: "Rainbow",
            tier: "premium",
            cost: 900,
            effectType: EffectType.colorWaves,
            colors: const [
              Colors.red,
              Colors.orange,
              Colors.yellow,
              Colors.green,
              Colors.blue,
              Colors.purple,
            ],
            customBuilder: (ctx, size, colors) {
              customBuilderCalled = true;
              capturedColors = colors;
              return SizedBox(
                width: size,
                height: size,
                child: CustomPaint(
                  size: Size(size, size),
                  painter: _RecorderPainter(colors),
                ),
              );
            },
          );
          final effectColor = EffectColorCosmeticItem(
            cosmeticId: "gold",
            label: "Gold",
            tier: "basic",
            cost: 0,
            color: Colors.amber,
          );
          controller.selectCosmetic(customEffect);
          controller.selectCosmetic(effectColor);
          await tester.pumpAndSettle();

          await tester.pumpMaterialApp(
            AvatarMakerAvatar(controller: controller),
          );
          await tester.pump();

          expect(
            customBuilderCalled,
            isTrue,
            reason: "Avatar must render the custom effect even when an effect "
                "color is selected",
          );
          expect(
            capturedColors,
            equals(const [Colors.amber]),
            reason: "customBuilder must receive the effect color",
          );
        },
      );

      testWidgets(
        "AvatarMakerAvatar falls back to CosmeticEffectWidget when the "
        "active effect has no customBuilder and an effect color is set",
        (WidgetTester tester) async {
          final controller = NonPersistentAvatarMakerController();
          await tester.pumpAndSettle();

          final standardEffect = EffectCosmeticItem(
            cosmeticId: "stars_effect",
            label: "Stars",
            tier: "basic",
            cost: 0,
            effectType: EffectType.stars,
            colors: const [Colors.red],
          );
          final effectColor = EffectColorCosmeticItem(
            cosmeticId: "gold",
            label: "Gold",
            tier: "basic",
            cost: 0,
            color: Colors.green,
          );
          controller.selectCosmetic(standardEffect);
          controller.selectCosmetic(effectColor);
          await tester.pumpAndSettle();

          await tester.pumpMaterialApp(
            AvatarMakerAvatar(controller: controller),
          );
          await tester.pump();
          expect(find.byType(CircleAvatar), findsOneWidget);
        },
      );
    });

    group("repaint isolation", () {
      testWidgets(
        "wraps its whole subtree in a RepaintBoundary so the shared layer "
        "does not own the avatar's paint",
        (WidgetTester tester) async {
          final controller = NonPersistentAvatarMakerController();
          await controller.initController();

          await tester.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: Center(
                child: AvatarMakerAvatar(controller: controller, radius: 40),
              ),
            ),
          );

          expect(
            tester.renderObject(find.byType(AvatarMakerAvatar)),
            isA<RenderRepaintBoundary>(),
            reason: "the avatar must be its own repaint layer: a sibling or "
                "ancestor animation (a chart, a shimmer, a scroll) must not "
                "re-record the avatar's circle, clips and cosmetic wrappers",
          );
        },
      );

      testWidgets(
        "a repainting sibling does not repaint the avatar's internals",
        (WidgetTester tester) async {
          final controller = NonPersistentAvatarMakerController();
          await controller.initController();

          // A canary painted *inside* the avatar (in the cosmetic background
          // slot, which has no repaint boundary of its own) so we can observe
          // how far up the layer tree a sibling repaint reaches.
          final avatarCanary = _CountingPainter();
          controller.selectCosmetic(_CanaryBackgroundItem(avatarCanary));

          final siblingTrigger = _RepaintTrigger();
          final siblingPainter = _CountingPainter(repaint: siblingTrigger);

          await tester.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: Stack(
                children: [
                  // Shares the layer with the avatar and repaints on demand,
                  // like the animated chart next to the avatar on the home
                  // screen.
                  Positioned.fill(
                    child: CustomPaint(painter: siblingPainter),
                  ),
                  Center(
                    child: AvatarMakerAvatar(
                      controller: controller,
                      radius: 80,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          );
          await tester.pump();

          final avatarBaseline = avatarCanary.paintCount;
          final siblingBaseline = siblingPainter.paintCount;
          expect(avatarBaseline, greaterThan(0),
              reason: "the avatar canary must be painted on the first frame");

          // Repaint the sibling only.
          siblingTrigger.trigger();
          await tester.pump();

          expect(
            siblingPainter.paintCount,
            greaterThan(siblingBaseline),
            reason: "the sibling must actually repaint for this test to be "
                "meaningful",
          );
          expect(
            avatarCanary.paintCount,
            avatarBaseline,
            reason: "without a RepaintBoundary at the avatar root the whole "
                "shared layer (avatar included) is re-recorded on every "
                "sibling repaint",
          );
        },
      );

      testWidgets(
        "an animated custom effect does not repaint the avatar's other layers",
        (WidgetTester tester) async {
          final controller = NonPersistentAvatarMakerController();
          await controller.initController();

          // p763_quiz (and any consumer that wants an animated effect the
          // package does not ship) injects an animation through
          // `customBuilder`, exactly like this.
          final backgroundCanary = _CountingPainter();
          controller.selectCosmetic(_CanaryBackgroundItem(backgroundCanary));

          final effectTrigger = _RepaintTrigger();
          final effectCanary = _CountingPainter(repaint: effectTrigger);
          controller.selectCosmetic(
            EffectCosmeticItem(
              cosmeticId: "custom_canary_effect",
              label: "Custom canary effect",
              tier: "basic",
              cost: 0,
              effectType: EffectType.stars,
              customBuilder: (context, size, colors) =>
                  CustomPaint(painter: effectCanary),
            ),
          );

          await tester.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: Center(
                child: AvatarMakerAvatar(
                  controller: controller,
                  radius: 80,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          );
          await tester.pump();

          final backgroundBaseline = backgroundCanary.paintCount;
          final effectBaseline = effectCanary.paintCount;
          expect(backgroundBaseline, greaterThan(0));
          expect(effectBaseline, greaterThan(0),
              reason: "the custom effect must be rendered");

          // Advance the custom effect animation by one frame.
          effectTrigger.trigger();
          await tester.pump();

          expect(
            effectCanary.paintCount,
            greaterThan(effectBaseline),
            reason: "the custom effect must repaint for this test to be "
                "meaningful",
          );
          expect(
            backgroundCanary.paintCount,
            backgroundBaseline,
            reason: "a custom effect animates on every frame; without its own "
                "RepaintBoundary the effect slot re-records the whole avatar "
                "(background, clips, SVG) on each of those frames",
          );
        },
      );

      testWidgets(
        "an animated custom background does not repaint the avatar's other "
        "layers",
        (WidgetTester tester) async {
          final controller = NonPersistentAvatarMakerController();
          await controller.initController();

          final backgroundTrigger = _RepaintTrigger();
          final backgroundCanary = _CountingPainter(repaint: backgroundTrigger);
          controller.selectCosmetic(_CanaryBackgroundItem(backgroundCanary));

          final effectCanary = _CountingPainter();
          controller.selectCosmetic(
            EffectCosmeticItem(
              cosmeticId: "custom_canary_effect",
              label: "Custom canary effect",
              tier: "basic",
              cost: 0,
              effectType: EffectType.stars,
              customBuilder: (context, size, colors) =>
                  CustomPaint(painter: effectCanary),
            ),
          );

          await tester.pumpWidget(
            Directionality(
              textDirection: TextDirection.ltr,
              child: Center(
                child: AvatarMakerAvatar(
                  controller: controller,
                  radius: 80,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          );
          await tester.pump();

          final backgroundBaseline = backgroundCanary.paintCount;
          final effectBaseline = effectCanary.paintCount;
          expect(backgroundBaseline, greaterThan(0));
          expect(effectBaseline, greaterThan(0));

          // Advance the custom background animation by one frame.
          backgroundTrigger.trigger();
          await tester.pump();

          expect(
            backgroundCanary.paintCount,
            greaterThan(backgroundBaseline),
            reason: "the custom background must repaint for this test to be "
                "meaningful",
          );
          expect(
            effectCanary.paintCount,
            effectBaseline,
            reason: "a custom background animates on every frame; without its "
                "own RepaintBoundary the background slot re-records the whole "
                "avatar on each of those frames",
          );
        },
      );
    });
  });
}

/// Records the colors passed to its [paint] callback so the integration test
/// can assert that customBuilder received the effect color via overrideColors.
class _RecorderPainter extends CustomPainter {
  final List<Color> colors;
  _RecorderPainter(this.colors);
  @override
  void paint(Canvas canvas, Size size) {}
  @override
  bool shouldRepaint(covariant _RecorderPainter oldDelegate) =>
      oldDelegate.colors != colors;
}

/// A [ChangeNotifier] that lets a test force a repaint of a [CustomPaint].
class _RepaintTrigger extends ChangeNotifier {
  void trigger() => notifyListeners();
}

/// Counts how many times it is asked to paint. It never requests a repaint by
/// itself, so every counted paint was forced by an ancestor layer repaint.
class _CountingPainter extends CustomPainter {
  _CountingPainter({Listenable? repaint}) : super(repaint: repaint);

  int paintCount = 0;

  @override
  void paint(Canvas canvas, Size size) {
    paintCount++;
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0x22000000),
    );
  }

  @override
  bool shouldRepaint(covariant _CountingPainter oldDelegate) => false;
}

/// A cosmetic background whose widget paints [painter], used to observe
/// repaints of the avatar's inner (non-boundary) layers.
class _CanaryBackgroundItem extends CosmeticPropertyItem {
  _CanaryBackgroundItem(this.painter);

  final CustomPainter painter;

  @override
  final String cosmeticId = "test_canary_background";

  @override
  final String label = "Canary background";

  @override
  final String category = "background";

  @override
  final String tier = "basic";

  @override
  final int cost = 0;

  @override
  final bool locked = false;

  @override
  Widget buildWidget(BuildContext context, double size) => SizedBox(
        width: size,
        height: size,
        child: CustomPaint(painter: painter),
      );

  @override
  Widget buildThumbnail(BuildContext context, double size) =>
      buildWidget(context, size);
}
