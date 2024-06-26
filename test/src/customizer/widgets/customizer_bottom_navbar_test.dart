import "package:avatar_maker/avatar_maker.dart";
import "package:avatar_maker/src/customizer/widgets/customizer_bottom_navbar.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";
import "../../../helpers.dart";
@GenerateNiceMocks([
  MockSpec<TabController>(),
  MockSpec<AnimationController>(),
])
import "customizer_bottom_navbar_test.mocks.dart";

final tabControllerMock = MockTabController();
final animationControllerMock = MockAnimationController();

void main() {
  List<Widget> propertyCategoriesTabs = [
    Text("tab 1"),
    Text("tab 2"),
  ];

  setUpAll(() async {
    when(tabControllerMock.index).thenReturn(1);
    when(tabControllerMock.length).thenReturn(propertyCategoriesTabs.length);
    when(tabControllerMock.animation).thenReturn(animationControllerMock);
  });

  group("CustomizerBottomNavbar", () {
    group("UI", () {
      testWidgets("Default", (WidgetTester tester) async {
        await tester.pumpMaterialApp(CustomizerBottomNavbar(
          navbarWidgets: propertyCategoriesTabs,
          tabController: tabControllerMock,
          theme: AvatarMakerThemeData.defaultTheme,
        ));

        final containerConditions = isA<Container>().having(
          (container) => container.color,
          "Check container color",
          AvatarMakerThemeData.defaultTheme.primaryBgColor,
        );
        final container = find.byType(Container);
        expect(container, findsOneWidget);
        expect(container.evaluate().first.widget, containerConditions);

        final tabBarConditions = isA<TabBar>()
            .having(
              (tabBar) => tabBar.controller,
              "Check controller",
              tabControllerMock,
            )
            .having(
              (tabBar) => tabBar.isScrollable,
              "Check if it's scrollable",
              true,
            )
            .having(
              (tabBar) => tabBar.tabs,
              "Check tabs",
              propertyCategoriesTabs,
            )
            .having(
              (tabBar) => tabBar.indicatorColor,
              "Check indicator color",
              AvatarMakerThemeData.defaultTheme.selectedIconColor,
            );
        final tabBar = find.byType(TabBar);
        expect(tabBar, findsOneWidget);
        expect(tabBar.evaluate().first.widget, tabBarConditions);
      });
    });
  });
}
