import "package:avatar_maker/avatar_maker.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:get/get.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";

import "../../helpers.dart";
@GenerateNiceMocks(
    [MockSpec<AvatarMakerController>(), MockSpec<InternalFinalCallback>()])
import "avatar_maker_reset_widget_test.mocks.dart";

final avatarMakerControllerMock = MockAvatarMakerController();
final internalFinalCallbackMock = MockInternalFinalCallback();

void main() {
  setUpAll(() async {
    when(avatarMakerControllerMock.onStart)
        .thenAnswer((_) => internalFinalCallbackMock);
    when(avatarMakerControllerMock.onDelete)
        .thenAnswer((_) => internalFinalCallbackMock);
    when(avatarMakerControllerMock.restoreState()).thenAnswer((_) => null);

    Get.put<AvatarMakerController>(avatarMakerControllerMock);
  });

  tearDownAll(() async {
    Get.delete<AvatarMakerController>();
  });

  group("AvatarMakerResetWidget", () {
    group("UI", () {
      testWidgets("Default", (WidgetTester tester) async {
        await tester.pumpMaterialApp(AvatarMakerResetWidget());

        final inkWellConditions = isA<InkWell>()
            .having((i) => i.radius, "Check radius", null)
            .having((i) => i.splashFactory, "Check splashFactory", null)
            .having((i) => i.splashColor, "Check splashColor", null);
        final inkwell = find.byType(InkWell);
        expect(inkwell, findsOneWidget);
        expect(inkwell.evaluate().first.widget, inkWellConditions);

        final iconConditions = isA<Icon>()
            .having((i) => i.icon, "Check save icon", Icons.replay)
            .having((i) => i.color, "Check save icon color",
                AvatarMakerThemeData.defaultTheme.iconColor);
        final icon = find.byType(Icon);
        expect(icon, findsOneWidget);
        expect(icon.evaluate().first.widget, iconConditions);

        verifyNever(avatarMakerControllerMock.restoreState());
      });
      testWidgets("With radius", (WidgetTester tester) async {
        final double radius = 12.9;
        await tester.pumpMaterialApp(AvatarMakerResetWidget(
          radius: radius,
        ));

        final inkWellConditions = isA<InkWell>()
            .having((i) => i.radius, "Check radius", radius)
            .having((i) => i.splashFactory, "Check splashFactory", null)
            .having((i) => i.splashColor, "Check splashColor", null);
        final inkwell = find.byType(InkWell);
        expect(inkwell, findsOneWidget);
        expect(inkwell.evaluate().first.widget, inkWellConditions);

        final iconConditions = isA<Icon>()
            .having((i) => i.icon, "Check save icon", Icons.replay)
            .having((i) => i.color, "Check save icon color",
                AvatarMakerThemeData.defaultTheme.iconColor);
        final icon = find.byType(Icon);
        expect(icon, findsOneWidget);
        expect(icon.evaluate().first.widget, iconConditions);

        verifyNever(avatarMakerControllerMock.restoreState());
      });
      testWidgets("With splashColor", (WidgetTester tester) async {
        final Color splashColor = Colors.green;
        await tester.pumpMaterialApp(AvatarMakerResetWidget(
          splashColor: splashColor,
        ));

        final inkWellConditions = isA<InkWell>()
            .having((i) => i.radius, "Check radius", null)
            .having((i) => i.splashFactory, "Check splashFactory", null)
            .having((i) => i.splashColor, "Check splashColor", splashColor);
        final inkwell = find.byType(InkWell);
        expect(inkwell, findsOneWidget);
        expect(inkwell.evaluate().first.widget, inkWellConditions);

        final iconConditions = isA<Icon>()
            .having((i) => i.icon, "Check save icon", Icons.replay)
            .having((i) => i.color, "Check save icon color",
                AvatarMakerThemeData.defaultTheme.iconColor);
        final icon = find.byType(Icon);
        expect(icon, findsOneWidget);
        expect(icon.evaluate().first.widget, iconConditions);

        verifyNever(avatarMakerControllerMock.restoreState());
      });
      testWidgets("With custom theme", (WidgetTester tester) async {
        await tester.pumpMaterialApp(AvatarMakerResetWidget(
          theme: AvatarMakerThemeData(
            iconColor: Colors.pink,
          ),
        ));

        final inkWellConditions = isA<InkWell>()
            .having((i) => i.radius, "Check radius", null)
            .having((i) => i.splashFactory, "Check splashFactory", null)
            .having((i) => i.splashColor, "Check splashColor", null);
        final inkwell = find.byType(InkWell);
        expect(inkwell, findsOneWidget);
        expect(inkwell.evaluate().first.widget, inkWellConditions);

        final iconConditions = isA<Icon>()
            .having((i) => i.icon, "Check save icon", Icons.replay)
            .having((i) => i.color, "Check save icon color", Colors.pink);
        final icon = find.byType(Icon);
        expect(icon, findsOneWidget);
        expect(icon.evaluate().first.widget, iconConditions);

        verifyNever(avatarMakerControllerMock.restoreState());
      });
    });
    group("On tap InkWell", () {
      testWidgets("Default", (WidgetTester tester) async {
        await tester.pumpMaterialApp(AvatarMakerResetWidget());

        final inkwell = find.byType(InkWell);
        expect(inkwell, findsOneWidget);
        await tester.tap(inkwell);

        verify(avatarMakerControllerMock.restoreState()).called(1);
      });
    });
  });
}
