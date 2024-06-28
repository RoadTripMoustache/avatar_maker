import "package:avatar_maker/avatar_maker.dart";
import "package:avatar_maker/src/customizer/widgets/customizer_appbar.dart";
import "package:avatar_maker/src/customizer/widgets/customizer_arrow_button.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "../../../helpers.dart";

void main() {
  final List<CustomizedPropertyCategory> propertyCategories = [
    CustomizedPropertyCategory(id: PropertyCategoryIds.Nose, name: "nose-name"),
    CustomizedPropertyCategory(
        id: PropertyCategoryIds.Background, name: "background-name"),
    CustomizedPropertyCategory(
        id: PropertyCategoryIds.HairStyle, name: "hairstyle-name"),
    CustomizedPropertyCategory(
        id: PropertyCategoryIds.SkinColor, name: "skin-color-name"),
  ];
  group("CustomizerAppbar", () {
    group("UI", () {
      testWidgets("Default", (WidgetTester tester) async {
        await tester.pumpMaterialApp(CustomizerAppbar(
            nbrCategories: propertyCategories.length,
            title: propertyCategories[2].name!,
            tabIndex: 2,
            theme: AvatarMakerThemeData.defaultTheme,
            onArrowTap: (bool isLeft) => {}));

        final appBarConditions = isA<AppBar>().having(
          (appbar) => appbar.backgroundColor,
          "Check background color",
          AvatarMakerThemeData.defaultTheme.primaryBgColor,
        );
        final appBar = find.byType(AppBar);
        expect(appBar, findsOneWidget);
        expect(appBar.evaluate().first.widget, appBarConditions);

        final title = find.text("hairstyle-name");
        expect(title, findsOneWidget);

        final arrowLeftButtonConditions = isA<CustomizerArrowButton>()
            .having((btn) => btn.isLeft, "Check left button", true);
        final arrowRightButtonConditions = isA<CustomizerArrowButton>()
            .having((btn) => btn.isLeft, "Check right button", false);
        final arrowButtons = find.byType(CustomizerArrowButton);
        expect(arrowButtons, findsNWidgets(2));
        expect(arrowButtons.evaluate().first.widget, arrowLeftButtonConditions);
        expect(arrowButtons.evaluate().last.widget, arrowRightButtonConditions);
      });
    });
    group("Arrow buttons", () {
      testWidgets("Click on left button", (WidgetTester tester) async {
        bool clickLeft = false;
        bool clickRight = false;
        await tester.pumpMaterialApp(CustomizerAppbar(
            nbrCategories: propertyCategories.length,
            title: propertyCategories[2].name!,
            tabIndex: 2,
            theme: AvatarMakerThemeData.defaultTheme,
            onArrowTap: (bool isLeft) {
              if (isLeft) {
                clickLeft = true;
              } else {
                clickRight = true;
              }
            }));

        final arrowButtons = find.byType(CustomizerArrowButton);
        expect(arrowButtons, findsNWidgets(2));
        await tester.tap(arrowButtons.first);

        expect(clickLeft, true);
        expect(clickRight, false);
      });
      testWidgets("Click on right button", (WidgetTester tester) async {
        bool clickLeft = false;
        bool clickRight = false;
        await tester.pumpMaterialApp(CustomizerAppbar(
            nbrCategories: propertyCategories.length,
            title: propertyCategories[2].name!,
            tabIndex: 2,
            theme: AvatarMakerThemeData.defaultTheme,
            onArrowTap: (bool isLeft) {
              if (isLeft) {
                clickLeft = true;
              } else {
                clickRight = true;
              }
            }));
        await tester.pumpAndSettle();

        final arrowButtons = find.byType(CustomizerArrowButton);
        expect(arrowButtons, findsNWidgets(2));
        await tester.tap(arrowButtons.at(1));

        expect(clickLeft, false);
        expect(clickRight, true);
      });
      testWidgets("Only right button available", (WidgetTester tester) async {
        bool clickLeft = false;
        bool clickRight = false;
        await tester.pumpMaterialApp(CustomizerAppbar(
            nbrCategories: propertyCategories.length,
            title: propertyCategories[0].name!,
            tabIndex: 0,
            theme: AvatarMakerThemeData.defaultTheme,
            onArrowTap: (bool isLeft) {
              if (isLeft) {
                clickLeft = true;
              } else {
                clickRight = true;
              }
            }));

        final arrowButtons = find.byType(CustomizerArrowButton);
        expect(arrowButtons, findsNWidgets(2));
        expect(arrowButtons.hitTestable(), findsOneWidget);
        await tester.tap(arrowButtons.hitTestable());

        expect(clickLeft, false);
        expect(clickRight, true);
      });
      testWidgets("Only left button available", (WidgetTester tester) async {
        bool clickLeft = false;
        bool clickRight = false;
        await tester.pumpMaterialApp(CustomizerAppbar(
            nbrCategories: propertyCategories.length,
            title: propertyCategories[3].name!,
            tabIndex: 3,
            theme: AvatarMakerThemeData.defaultTheme,
            onArrowTap: (bool isLeft) {
              if (isLeft) {
                clickLeft = true;
              } else {
                clickRight = true;
              }
            }));

        final arrowButtons = find.byType(CustomizerArrowButton);
        expect(arrowButtons, findsNWidgets(2));
        expect(arrowButtons.hitTestable(), findsOneWidget);
        await tester.tap(arrowButtons.hitTestable());

        expect(clickLeft, true);
        expect(clickRight, false);
      });
    });
    group("App bar", () {
      testWidgets("Title change", (WidgetTester tester) async {
        // Load the widget
        await tester.pumpMaterialApp(CustomizerAppbar(
            nbrCategories: propertyCategories.length,
            title: propertyCategories[0].name!,
            tabIndex: 0,
            theme: AvatarMakerThemeData.defaultTheme,
            onArrowTap: (bool isLeft) {}));

        // Check the first app bar title displayed
        var appBarTitle = find.text("nose-name");
        expect(appBarTitle, findsOneWidget);
        appBarTitle = find.text("hairstyle-name");
        expect(appBarTitle, findsNothing);

        // Simulate actions on the arrow buttons to change tabs
        await tester.pumpMaterialApp(CustomizerAppbar(
            nbrCategories: propertyCategories.length,
            title: propertyCategories[2].name!,
            tabIndex: 2,
            theme: AvatarMakerThemeData.defaultTheme,
            onArrowTap: (bool isLeft) {}));

        // Check the title again, it should take the 3rd element of the list
        appBarTitle = find.text("nose-name");
        expect(appBarTitle, findsNothing);
        appBarTitle = find.text("hairstyle-name");
        expect(appBarTitle, findsOneWidget);
      });
    });
  });
}
