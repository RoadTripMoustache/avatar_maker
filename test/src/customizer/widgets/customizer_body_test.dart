import "package:avatar_maker/avatar_maker.dart";
import "package:avatar_maker/src/core/enums/property_categories.dart";
import "package:avatar_maker/src/customizer/widgets/customizer_appbar.dart";
import "package:avatar_maker/src/customizer/widgets/customizer_body.dart";
import "package:avatar_maker/src/customizer/widgets/customizer_bottom_navbar.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";
import "../../../helpers.dart";

@GenerateNiceMocks([
  MockSpec<PersistentAvatarMakerController>(),
  MockSpec<TabController>(),
  MockSpec<AnimationController>(),
])
import "customizer_body_test.mocks.dart";

final avatarMakerControllerMock = MockPersistentAvatarMakerController();
final tabControllerMock = MockTabController();
final animationControllerMock = MockAnimationController();

void main() {
  final List<CustomizedPropertyCategory> propertyCategories = [
    CustomizedPropertyCategory(
        id: PropertyCategoryIds.Nose,
        name: "nose-name",
        iconFile: NoseType.iconFile,
        properties: Noses.values),
    CustomizedPropertyCategory(
        id: PropertyCategoryIds.Background,
        name: "background-name",
        iconFile: Background.iconFile,
        properties: BackgroundStyles.values),
    CustomizedPropertyCategory(
        id: PropertyCategoryIds.HairStyle,
        name: "hairstyle-name",
        iconFile: HairStyle.iconFile,
        properties: HairStyles.values),
    CustomizedPropertyCategory(
        id: PropertyCategoryIds.SkinColor,
        name: "skin-color-name",
        iconFile: SkinColor.iconFile,
        properties: SkinColors.values),
  ];
  setUpAll(() async {
    when(avatarMakerControllerMock.displayedPropertyCategories)
        .thenReturn(propertyCategories);
    when(avatarMakerControllerMock.selectedOptions).thenReturn({
      PropertyCategoryIds.Nose: Noses.Default,
      PropertyCategoryIds.Background: BackgroundStyles.Transparent,
      PropertyCategoryIds.HairStyle: HairStyles.Bald,
      PropertyCategoryIds.SkinColor: SkinColors.Black,
    });
    when(avatarMakerControllerMock.getComponentSVG(any
        , any)).thenReturn(
        """<svg width="20px" height="20px" viewBox="-3 -50 120 170" >
        </svg>""");

    when(tabControllerMock.index).thenReturn(1);
    when(tabControllerMock.length).thenReturn(propertyCategories.length);
    when(tabControllerMock.animation).thenReturn(animationControllerMock);
  });

  group("CustomizerAppbar", () {
    group("UI", () {
      testWidgets("Default", (WidgetTester tester) async {
        await tester.pumpMaterialApp(CustomizerBody(
            avatarMakerController: avatarMakerControllerMock,
            tabController: tabControllerMock,
            scaffoldHeight: 1.0,
            theme: AvatarMakerThemeData.defaultTheme,
            onTapOption: (
              PropertyItem newSelectedItem,
              PropertyCategoryIds categoryId,
            ) {},
            onArrowTap: (bool isLeft) {}));

        // Check app bar
        final appBarConditions = isA<CustomizerAppbar>()
            .having(
              (appbar) => appbar.nbrCategories,
              "Check nbrCategories",
              propertyCategories.length,
            )
            .having(
              (appbar) => appbar.theme,
              "Check theme",
              AvatarMakerThemeData.defaultTheme,
            )
            .having((appbar) => appbar.tabIndex, "Check tabIndex", 1);
        final appBar = find.byType(CustomizerAppbar);
        expect(appBar, findsOneWidget);
        expect(appBar.evaluate().first.widget, appBarConditions);

        // Check tab bar
        final tabControllerConditions = isA<DefaultTabController>().having(
          (tabCtrl) => tabCtrl.length,
          "Check tab controller length",
          propertyCategories.length,
        );
        final tabBarController = find.byType(DefaultTabController);
        expect(tabBarController, findsOneWidget);
        expect(
            tabBarController.evaluate().first.widget, tabControllerConditions);

        final tabBarConditions = isA<TabBarView>().having(
          (tabBar) => tabBar.controller,
          "Check tab bar controller",
          tabControllerMock,
        );
        final tabBarView = find.byType(TabBarView);
        expect(tabBarView, findsOneWidget);
        expect(tabBarView.evaluate().first.widget, tabBarConditions);

        final bottomNavBarConditions = isA<CustomizerBottomNavbar>()
            .having(
              (navBar) => navBar.tabController,
              "Check nav bar controller",
              tabControllerMock,
            )
            .having(
              (navBar) => navBar.navbarWidgets.length,
              "Check nav bar number of widgets",
              propertyCategories.length,
            )
            .having(
              (navBar) => navBar.theme,
              "Check nav bar theme",
              AvatarMakerThemeData.defaultTheme,
            );
        final bottomNavBar = find.byType(CustomizerBottomNavbar);
        expect(bottomNavBar, findsOneWidget);
        expect(bottomNavBar.evaluate().first.widget, bottomNavBarConditions);
      });
    });
  });
}
