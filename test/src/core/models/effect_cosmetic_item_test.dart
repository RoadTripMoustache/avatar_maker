import "package:avatar_maker/avatar_maker.dart";
import "package:avatar_maker/src/customizer/widgets/cosmetic_effect_widget.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

import "../../../helpers.dart";

EffectCosmeticItem _customEffect({
  List<Color> colors = const [Colors.red, Colors.blue],
  Widget Function(BuildContext, double, List<Color>)? customBuilder,
}) {
  return EffectCosmeticItem(
    cosmeticId: "test_effect",
    label: "Test Effect",
    tier: "basic",
    cost: 0,
    effectType: EffectType.stars,
    colors: colors,
    customBuilder: customBuilder,
  );
}

void main() {
  group("EffectCosmeticItem.buildWidget", () {
    testWidgets(
      "calls customBuilder with the effect's own colors when no override "
      "is provided (backward compat)",
      (WidgetTester tester) async {
        bool customBuilderCalled = false;
        List<Color>? capturedColors;
        final effect = _customEffect(
          colors: const [Colors.red, Colors.blue],
          customBuilder: (ctx, size, colors) {
            customBuilderCalled = true;
            capturedColors = colors;
            return const SizedBox.shrink();
          },
        );
        await tester.pumpMaterialApp(
          Builder(
            builder: (ctx) => effect.buildWidget(ctx, 100),
          ),
        );
        expect(customBuilderCalled, isTrue);
        expect(capturedColors, equals(const [Colors.red, Colors.blue]));
      },
    );

    testWidgets(
      "forwards overrideColors to customBuilder when provided",
      (WidgetTester tester) async {
        List<Color>? capturedColors;
        final effect = _customEffect(
          colors: const [Colors.red, Colors.blue],
          customBuilder: (ctx, size, colors) {
            capturedColors = colors;
            return const SizedBox.shrink();
          },
        );
        await tester.pumpMaterialApp(
          Builder(
            builder: (ctx) => effect.buildWidget(
              ctx,
              100,
              overrideColors: const [Colors.purple, Colors.yellow],
            ),
          ),
        );
        expect(capturedColors, equals(const [Colors.purple, Colors.yellow]));
      },
    );

    testWidgets(
      "accepts an empty overrideColors list",
      (WidgetTester tester) async {
        List<Color>? capturedColors;
        final effect = _customEffect(
          colors: const [Colors.red],
          customBuilder: (ctx, size, colors) {
            capturedColors = colors;
            return const SizedBox.shrink();
          },
        );
        await tester.pumpMaterialApp(
          Builder(
            builder: (ctx) =>
                effect.buildWidget(ctx, 100, overrideColors: const []),
          ),
        );
        expect(capturedColors, isEmpty);
      },
    );

    testWidgets(
      "uses CosmeticEffectWidget for standard effects (no customBuilder)",
      (WidgetTester tester) async {
        final effect = _customEffect();
        await tester.pumpMaterialApp(
          Builder(
            builder: (ctx) => effect.buildWidget(ctx, 100),
          ),
        );
        expect(find.byType(CosmeticEffectWidget), findsOneWidget);
      },
    );

    testWidgets(
      "forwards overrideColors to CosmeticEffectWidget for standard effects",
      (WidgetTester tester) async {
        final effect = _customEffect(colors: const [Colors.red]);
        Widget? captured;
        await tester.pumpMaterialApp(
          Builder(
            builder: (ctx) {
              captured = effect.buildWidget(
                ctx,
                100,
                overrideColors: const [Colors.green],
              );
              return captured!;
            },
          ),
        );
        expect(captured, isA<CosmeticEffectWidget>());
        final widget = captured! as CosmeticEffectWidget;
        expect(widget.colors, equals(const [Colors.green]));
      },
    );
  });

  group("EffectCosmeticItemWithColor", () {
    testWidgets(
      "delegates to customBuilder and forwards the effect color (bug fix)",
      (WidgetTester tester) async {
        bool customBuilderCalled = false;
        List<Color>? capturedColors;
        final effect = _customEffect(
          colors: const [Colors.red, Colors.blue],
          customBuilder: (ctx, size, colors) {
            customBuilderCalled = true;
            capturedColors = colors;
            return const SizedBox.shrink();
          },
        );
        await tester.pumpMaterialApp(
          EffectCosmeticItemWithColor(
            effect: effect,
            color: Colors.green,
            size: 100,
          ),
        );
        expect(
          customBuilderCalled,
          isTrue,
          reason: "Bug fix: customBuilder must be invoked even when an effect "
              "color is selected",
        );
        expect(
          capturedColors,
          equals(const [Colors.green]),
          reason:
              "overrideColors must override the effect's own colors when an "
              "EffectColorCosmeticItem is active",
        );
      },
    );

    testWidgets(
      "uses CosmeticEffectWidget for standard effects (no customBuilder) "
      "— regression guard",
      (WidgetTester tester) async {
        final effect = _customEffect(colors: const [Colors.red]);
        await tester.pumpMaterialApp(
          EffectCosmeticItemWithColor(
            effect: effect,
            color: Colors.amber,
            size: 100,
          ),
        );
        expect(find.byType(CosmeticEffectWidget), findsOneWidget);
      },
    );
  });
}
