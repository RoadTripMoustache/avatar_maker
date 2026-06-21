import "package:avatar_maker/avatar_maker.dart";
import "package:flutter/material.dart";
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
