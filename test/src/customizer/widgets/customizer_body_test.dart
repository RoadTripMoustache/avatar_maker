import "package:avatar_maker/avatar_maker.dart";
import "package:avatar_maker/src/core/enums/property_categories.dart";
import "package:avatar_maker/src/customizer/widgets/customizer_appbar.dart";
import "package:avatar_maker/src/customizer/widgets/customizer_arrow_button.dart";
import "package:avatar_maker/src/customizer/widgets/customizer_body.dart";
import "package:avatar_maker/src/customizer/widgets/customizer_bottom_navbar.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:get/get.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";
import "../../../helpers.dart";
@GenerateNiceMocks([
  MockSpec<AvatarMakerController>(),
  MockSpec<InternalFinalCallback>(),
  MockSpec<TabController>(),
  MockSpec<AnimationController>(),
])
import "customizer_body_test.mocks.dart";

final avatarMakerControllerMock = MockAvatarMakerController();
final internalFinalCallbackMock = MockInternalFinalCallback();
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
    when(avatarMakerControllerMock.onStart)
        .thenAnswer((_) => internalFinalCallbackMock);
    when(avatarMakerControllerMock.onDelete)
        .thenAnswer((_) => internalFinalCallbackMock);
    when(avatarMakerControllerMock.displayedPropertyCategories)
        .thenReturn(propertyCategories);
    when(avatarMakerControllerMock.selectedOptions).thenReturn({
      PropertyCategoryIds.Nose: Noses.Default,
      PropertyCategoryIds.Background: BackgroundStyles.Transparent,
      PropertyCategoryIds.HairStyle: HairStyles.Bald,
      PropertyCategoryIds.SkinColor: SkinColors.Black,
    });
    when(avatarMakerControllerMock.getComponentSVG(any, any)).thenReturn(
        """<svg width="20px" height="20px" viewBox="-3 -50 120 170" >
        </svg>""");

    Get.put<AvatarMakerController>(avatarMakerControllerMock);

    when(tabControllerMock.index).thenReturn(1);
    when(tabControllerMock.length).thenReturn(propertyCategories.length);
    when(tabControllerMock.animation).thenReturn(animationControllerMock);
  });

  tearDownAll(() async {
    Get.delete<AvatarMakerController>();
  });

  group("CustomizerAppbar", () {
    group("UI", () {
      testWidgets("Default", (WidgetTester tester) async {
        await tester.pumpMaterialApp(CustomizerBody(
            avatarMakerController: avatarMakerControllerMock,
            tabController: tabControllerMock,
            scaffoldHeight: 1.0,
            theme: AvatarMakerThemeData.standard,
            onTapOption: (
              PropertyItem newSelectedItem,
              PropertyCategoryIds categoryId,
            ) {},
            onArrowTap: (bool isLeft) {}));

        // Check app bar
        isA<CustomizerAppbar>()
          ..having(
            (appbar) => appbar.propertyCategories,
            "Check propertyCategories",
            propertyCategories,
          )
          ..having(
            (appbar) => appbar.theme,
            "Check theme",
            AvatarMakerThemeData.standard,
          )
          ..having((appbar) => appbar.tabIndex, "Check tabIndex", 2)
          ..having(
            (appbar) => appbar.onArrowTap,
            "Check onArrowTap",
            (bool isLeft) {},
          );

        // Check tab bar
        final tabBarView = find.byType(TabBarView);
        expect(tabBarView, findsOneWidget);

        isA<DefaultTabController>()
          ..having(
            (tabCtrl) => tabCtrl.length,
            "Check tab controller length",
            propertyCategories.length,
          );
        isA<TabBarView>()
          ..having(
            (tabBar) => tabBar.controller,
            "Check tab bar controller",
            tabControllerMock,
          );
        isA<CustomizerBottomNavbar>()
          ..having(
            (navBar) => navBar.tabController,
            "Check nav bar controller",
            tabControllerMock,
          )
          ..having(
            (navBar) => navBar.navbarWidgets,
            "Check nav bar number of widgets",
            propertyCategories.length,
          )
          ..having(
            (navBar) => navBar.theme,
            "Check nav bar theme",
            AvatarMakerThemeData.standard,
          );
      });
    });
  });
}
