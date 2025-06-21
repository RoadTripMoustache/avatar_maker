import "package:avatar_maker/avatar_maker.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";
import "package:provider/provider.dart";

import "../../helpers.dart";

// Generate mocks for the controller
@GenerateNiceMocks([MockSpec<PersistentAvatarMakerController>()])
import "avatar_maker_reset_widget_test.mocks.dart";

void main() {
  late MockPersistentAvatarMakerController mockController;

  setUp(() {
    mockController = MockPersistentAvatarMakerController();
  });

  Widget buildTestWidget(Widget child) {
    return ChangeNotifierProvider<AvatarMakerController>.value(
          value: mockController,
          child: child,
    );
  }

  group("AvatarMakerResetWidget", () {
    group("UI", () {
      testWidgets("Default", (WidgetTester tester) async {
        await tester.pumpMaterialApp(buildTestWidget(AvatarMakerResetWidget()));

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

        verifyNever(mockController.restoreState());
      });
      
      testWidgets("With radius", (WidgetTester tester) async {
        final double radius = 12.9;
        await tester.pumpMaterialApp(buildTestWidget(AvatarMakerResetWidget(
          radius: radius,
        )));

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

        verifyNever(mockController.restoreState());
      });
      
      testWidgets("With splashColor", (WidgetTester tester) async {
        final Color splashColor = Colors.green;
        await tester.pumpMaterialApp(buildTestWidget(AvatarMakerResetWidget(
          splashColor: splashColor,
        )));

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

        verifyNever(mockController.restoreState());
      });
      
      testWidgets("With custom theme", (WidgetTester tester) async {
        await tester.pumpMaterialApp(buildTestWidget(AvatarMakerResetWidget(
          theme: AvatarMakerThemeData(
            iconColor: Colors.pink,
          ),
        )));

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

        verifyNever(mockController.restoreState());
      });
      
      testWidgets("With custom child", (WidgetTester tester) async {
        final customChild = Text("Custom Child");
        await tester.pumpMaterialApp(buildTestWidget(AvatarMakerResetWidget(
          child: customChild,
        )));

        expect(find.text("Custom Child"), findsOneWidget);
        expect(find.byType(Icon), findsNothing);
        
        verifyNever(mockController.restoreState());
      });
      
      testWidgets("With controller", (WidgetTester tester) async {
        final controller = PersistentAvatarMakerController(customizedPropertyCategories: []);
        await tester.pumpMaterialApp(
          MaterialApp(
            home: Scaffold(
              body: AvatarMakerResetWidget(
                controller: controller,
              ),
            ),
          ),
        );

        expect(find.byType(Icon), findsOneWidget);
        
        verifyNever(mockController.restoreState());
      });
    });
    
    group("On tap InkWell", () {
      testWidgets("Default", (WidgetTester tester) async {
        await tester.pumpMaterialApp(buildTestWidget(AvatarMakerResetWidget()));

        final inkwell = find.byType(InkWell);
        expect(inkwell, findsOneWidget);
        await tester.tap(inkwell);

        verify(mockController.restoreState()).called(1);
      });
      
      testWidgets("With onTap callback", (WidgetTester tester) async {
        bool callbackCalled = false;
        await tester.pumpMaterialApp(buildTestWidget(AvatarMakerResetWidget(
          onTap: () {
            callbackCalled = true;
          },
        )));

        final inkwell = find.byType(InkWell);
        expect(inkwell, findsOneWidget);
        await tester.tap(inkwell);

        verify(mockController.restoreState()).called(1);
        expect(callbackCalled, isTrue);
      });
    });
  });
}