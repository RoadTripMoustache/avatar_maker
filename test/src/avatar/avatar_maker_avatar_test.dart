import "package:avatar_maker/src/avatar/avatar_maker_avatar.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

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
  });
}
