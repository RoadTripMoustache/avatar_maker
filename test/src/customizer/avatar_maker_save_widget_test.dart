import "package:avatar_maker/avatar_maker.dart";
import "package:avatar_maker/src/avatar/avatar_maker_avatar.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:get/get.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";

import "../../helpers.dart";
@GenerateNiceMocks(
    [MockSpec<AvatarMakerController>(), MockSpec<InternalFinalCallback>()])
import "avatar_maker_save_widget_test.mocks.dart";

final avatarMakerControllerMock = MockAvatarMakerController();
final internalFinalCallbackMock = MockInternalFinalCallback();

void main() {
  setUpAll(() async {
    when(avatarMakerControllerMock.onStart)
        .thenAnswer((_) => internalFinalCallbackMock);
    when(avatarMakerControllerMock.onDelete)
        .thenAnswer((_) => internalFinalCallbackMock);
    when(avatarMakerControllerMock.saveAvatarSVG())
        .thenAnswer((_) => Future.value());

    Get.put<AvatarMakerController>(avatarMakerControllerMock);
  });

  tearDownAll(() async {
    Get.delete<AvatarMakerController>();
  });

  group("AvatarMakerSaveWidget", () {
    group("UI", () {
      testWidgets("Default", (WidgetTester tester) async {
        await tester.pumpMaterialApp(AvatarMakerSaveWidget());

        final inkwell = find.byType(InkWell);
        expect(inkwell, findsOneWidget);

        isA<InkWell>()
          ..having((i) => i.radius, "Check radius", null)
          ..having((i) => i.splashFactory, "Check splashFactory", null)
          ..having((i) => i.splashColor, "Check splashColor", null);
        isA<Icon>()
          ..having((i) => i.icon, "Check save icon", Icons.save)
          ..having((i) => i.color, "Check save icon color",
              AvatarMakerThemeData.standard.iconColor);

        verifyNever(avatarMakerControllerMock.saveAvatarSVG());
      });
      testWidgets("With radius", (WidgetTester tester) async {
        final double radius = 12.9;
        await tester.pumpMaterialApp(AvatarMakerSaveWidget(
          radius: radius,
        ));

        final inkwell = find.byType(InkWell);
        expect(inkwell, findsOneWidget);

        isA<InkWell>()
          ..having((i) => i.radius, "Check radius", radius)
          ..having((i) => i.splashFactory, "Check splashFactory", null)
          ..having((i) => i.splashColor, "Check splashColor", null);
        isA<Icon>()
          ..having((i) => i.icon, "Check save icon", Icons.save)
          ..having((i) => i.color, "Check save icon color",
              AvatarMakerThemeData.standard.iconColor);

        verifyNever(avatarMakerControllerMock.saveAvatarSVG());
      });
      testWidgets("With splashColor", (WidgetTester tester) async {
        final Color splashColor = Colors.green;
        await tester.pumpMaterialApp(AvatarMakerSaveWidget(
          splashColor: splashColor,
        ));

        final inkwell = find.byType(InkWell);
        expect(inkwell, findsOneWidget);

        isA<InkWell>()
          ..having((i) => i.radius, "Check radius", null)
          ..having((i) => i.splashFactory, "Check splashFactory", null)
          ..having((i) => i.splashColor, "Check splashColor", splashColor);
        isA<Icon>()
          ..having((i) => i.icon, "Check save icon", Icons.save)
          ..having((i) => i.color, "Check save icon color",
              AvatarMakerThemeData.standard.iconColor);

        verifyNever(avatarMakerControllerMock.saveAvatarSVG());
      });
      testWidgets("With custom theme", (WidgetTester tester) async {
        final Color splashColor = Colors.green;
        await tester.pumpMaterialApp(AvatarMakerSaveWidget(
          theme: AvatarMakerThemeData(
            iconColor: Colors.pink,
          ),
        ));

        final inkwell = find.byType(InkWell);
        expect(inkwell, findsOneWidget);

        isA<InkWell>()
          ..having((i) => i.radius, "Check radius", null)
          ..having((i) => i.splashFactory, "Check splashFactory", null)
          ..having((i) => i.splashColor, "Check splashColor", splashColor);
        isA<Icon>()
          ..having((i) => i.icon, "Check save icon", Icons.save)
          ..having((i) => i.color, "Check save icon color", Colors.pink);

        verifyNever(avatarMakerControllerMock.saveAvatarSVG());
      });
    });
    group("On tap InkWell", () {
      testWidgets("Default", (WidgetTester tester) async {
        await tester.pumpMaterialApp(AvatarMakerSaveWidget());

        final inkwell = find.byType(InkWell);
        expect(inkwell, findsOneWidget);
        await tester.tap(inkwell);

        verify(avatarMakerControllerMock.saveAvatarSVG()).called(1);
      });
    });
  });
}
