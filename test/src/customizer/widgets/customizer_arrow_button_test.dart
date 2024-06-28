import "package:avatar_maker/avatar_maker.dart";
import "package:avatar_maker/src/customizer/widgets/customizer_arrow_button.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "../../../helpers.dart";

void main() {
  group("CustomizerArrowButton", () {
    group("UI", () {
      const groupsTestCases = [
        {
          "isLeft": true,
          "cases": [
            {
              "tabIndex": 0,
              "visibility": false,
              "expectedFinder": findsNothing
            },
            {
              "tabIndex": 1,
              "visibility": true,
              "expectedFinder": findsOneWidget
            },
            {
              "tabIndex": 4,
              "visibility": true,
              "expectedFinder": findsOneWidget
            }
          ]
        },
        {
          "isLeft": false,
          "cases": [
            {
              "tabIndex": 0,
              "visibility": true,
              "expectedFinder": findsOneWidget
            },
            {
              "tabIndex": 1,
              "visibility": true,
              "expectedFinder": findsOneWidget
            },
            {"tabIndex": 4, "visibility": false, "expectedFinder": findsNothing}
          ],
        },
      ];

      for (final Map<String, dynamic> groupTestCases in groupsTestCases) {
        group("${groupTestCases["isLeft"] ? "Left" : "Right"} arrow", () {
          for (final Map<String, dynamic> testCase in groupTestCases["cases"]) {
            testWidgets("Tab ${testCase["tabIndex"]}",
                (WidgetTester tester) async {
              await tester.pumpMaterialApp(CustomizerArrowButton(
                  nbrTabs: 5,
                  tabIndex: testCase["tabIndex"],
                  isLeft: groupTestCases["isLeft"],
                  theme: AvatarMakerThemeData.standard,
                  onArrowTap: (bool isLeft) => {}));

              // Check the visibility of the widget
              final visibilityConditions = isA<Visibility>().having(
                  (v) => v.visible, "Check visibility", testCase["visibility"]);
              final visibility = find.byType(Visibility);
              expect(visibility, findsOneWidget);
              expect(visibility.evaluate().first.widget, visibilityConditions);

              // Check the button
              final button = find.byType(IconButton);
              expect(button, testCase["expectedFinder"]);

              // Check the icon
              if (testCase["visibility"]) {
                final iconConditions = isA<Icon>().having(
                    (i) => i.icon,
                    "Check icon",
                    groupTestCases["isLeft"]
                        ? Icons.arrow_back_ios_new_rounded
                        : Icons.arrow_forward_ios_rounded);
                final icon = find.byType(Icon);
                expect(icon, findsOneWidget);
                expect(icon.evaluate().first.widget, iconConditions);
              }
            });
          }
        });
      }
    });
    group("OnPressed actions", () {
      const testCases = [
        {"isLeft": true},
        {"isLeft": false},
      ];

      for (final Map<String, dynamic> testCase in testCases) {
        testWidgets("${testCase["isLeft"] ? "Left" : "Right"} arrow",
            (WidgetTester tester) async {
          bool isTapped = false;
          bool? isLeftParam;
          await tester.pumpMaterialApp(CustomizerArrowButton(
              nbrTabs: 5,
              tabIndex: 2,
              isLeft: testCase["isLeft"],
              theme: AvatarMakerThemeData.standard,
              onArrowTap: (bool isLeft) {
                isLeftParam = isLeft;
                isTapped = true;
              }));

          final button = find.byType(IconButton);
          await tester.tap(button);

          expect(isLeftParam, testCase["isLeft"]);
          expect(isTapped, true);
        });
      }
    });
  });
}
