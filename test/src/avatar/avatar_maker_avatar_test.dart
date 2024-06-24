import "package:avatar_maker/src/avatar/avatar_maker_avatar.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("AvatarMakerAvatar", () {
    group("UI", () {
      testWidgets("Default", (WidgetTester tester) async {
        await tester.pumpWidget(AvatarMakerAvatar());

        final avatar = find.byType(CircleAvatar);
        expect(avatar, findsOneWidget);
        isA<CircleAvatar>().having(
          (circle) => circle.backgroundColor,
          "Check background color",
          null,
        );
        isA<CircleAvatar>().having(
          (circle) => circle.radius,
          "Check radius",
          75.0,
        );
      });

      testWidgets("With custom radius", (WidgetTester tester) async {
        await tester.pumpWidget(AvatarMakerAvatar(radius: 12.0,));

        final avatar = find.byType(CircleAvatar);
        expect(avatar, findsOneWidget);
        isA<CircleAvatar>().having(
          (circle) => circle.backgroundColor,
          "Check background color",
          null,
        );
        isA<CircleAvatar>().having(
          (circle) => circle.radius,
          "Check radius",
          12.0,
        );
      });

      testWidgets("With custom background color", (WidgetTester tester) async {
        await tester.pumpWidget(AvatarMakerAvatar(backgroundColor: Colors.red));

        final avatar = find.byType(CircleAvatar);
        expect(avatar, findsOneWidget);
        isA<CircleAvatar>().having(
          (circle) => circle.backgroundColor,
          "Check background color",
          Colors.red,
        );
        isA<CircleAvatar>().having(
          (circle) => circle.radius,
          "Check radius",
          75.0,
        );
      });

      testWidgets("With custom background color and radius", (WidgetTester tester) async {
        await tester.pumpWidget(AvatarMakerAvatar(
            backgroundColor: Colors.red, radius: 29.0,));

        final avatar = find.byType(CircleAvatar);
        expect(avatar, findsOneWidget);
        isA<CircleAvatar>().having(
          (circle) => circle.backgroundColor,
          "Check background color",
          Colors.red,
        );
        isA<CircleAvatar>().having(
          (circle) => circle.radius,
          "Check radius",
          29.0,
        );
      });
    });
  });
}
