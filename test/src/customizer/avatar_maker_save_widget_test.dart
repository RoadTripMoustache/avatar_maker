import "package:avatar_maker/avatar_maker.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";
import "package:provider/provider.dart";

// Generate mocks for the controller
@GenerateNiceMocks([MockSpec<PersistentAvatarMakerController>()])
import "avatar_maker_save_widget_test.mocks.dart";

void main() {
  late MockPersistentAvatarMakerController mockController;

  setUp(() {
    mockController = MockPersistentAvatarMakerController();
    when(mockController.saveAvatarSVG()).thenAnswer((_) => Future.value());
    when(mockController.drawAvatarSVG()).thenReturn("test-svg");
    when(mockController.isPersistentController()).thenReturn(true);
  });

  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      home: Scaffold(
        body: ChangeNotifierProvider<AvatarMakerController>.value(
          value: mockController,
          child: child,
        ),
      ),
    );
  }

  group("AvatarMakerSaveWidget", () {
    group("UI", () {
      testWidgets("Default", (WidgetTester tester) async {
        await tester.pumpWidget(buildTestWidget(AvatarMakerSaveWidget(
          controller: mockController,
        )));

        final inkWellConditions = isA<InkWell>()
            .having((i) => i.radius, "Check radius", null)
            .having((i) => i.splashFactory, "Check splashFactory", null)
            .having((i) => i.splashColor, "Check splashColor", null);
        final inkwell = find.byType(InkWell);
        expect(inkwell, findsOneWidget);
        expect(inkwell.evaluate().first.widget, inkWellConditions);

        final iconConditions = isA<Icon>()
            .having((i) => i.icon, "Check save icon", Icons.save)
            .having((i) => i.color, "Check save icon color",
                AvatarMakerThemeData.defaultTheme.iconColor);
        final icon = find.byType(Icon);
        expect(icon, findsOneWidget);
        expect(icon.evaluate().first.widget, iconConditions);

        verifyNever(mockController.saveAvatarSVG());
      });

      testWidgets("With radius", (WidgetTester tester) async {
        final double radius = 12.9;
        await tester.pumpWidget(buildTestWidget(AvatarMakerSaveWidget(
          radius: radius,
          controller: mockController,
        )));

        final inkWellConditions = isA<InkWell>()
            .having((i) => i.radius, "Check radius", radius)
            .having((i) => i.splashFactory, "Check splashFactory", null)
            .having((i) => i.splashColor, "Check splashColor", null);
        final inkwell = find.byType(InkWell);
        expect(inkwell, findsOneWidget);
        expect(inkwell.evaluate().first.widget, inkWellConditions);

        final iconConditions = isA<Icon>()
            .having((i) => i.icon, "Check save icon", Icons.save)
            .having((i) => i.color, "Check save icon color",
                AvatarMakerThemeData.defaultTheme.iconColor);
        final icon = find.byType(Icon);
        expect(icon, findsOneWidget);
        expect(icon.evaluate().first.widget, iconConditions);

        verifyNever(mockController.saveAvatarSVG());
      });

      testWidgets("With splashColor", (WidgetTester tester) async {
        final Color splashColor = Colors.green;
        await tester.pumpWidget(buildTestWidget(AvatarMakerSaveWidget(
          splashColor: splashColor,
          controller: mockController,
        )));

        final inkWellConditions = isA<InkWell>()
            .having((i) => i.radius, "Check radius", null)
            .having((i) => i.splashFactory, "Check splashFactory", null)
            .having((i) => i.splashColor, "Check splashColor", splashColor);
        final inkwell = find.byType(InkWell);
        expect(inkwell, findsOneWidget);
        expect(inkwell.evaluate().first.widget, inkWellConditions);

        final iconConditions = isA<Icon>()
            .having((i) => i.icon, "Check save icon", Icons.save)
            .having((i) => i.color, "Check save icon color",
                AvatarMakerThemeData.defaultTheme.iconColor);
        final icon = find.byType(Icon);
        expect(icon, findsOneWidget);
        expect(icon.evaluate().first.widget, iconConditions);

        verifyNever(mockController.saveAvatarSVG());
      });

      testWidgets("With custom theme", (WidgetTester tester) async {
        await tester.pumpWidget(buildTestWidget(AvatarMakerSaveWidget(
          controller: mockController,
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
            .having((i) => i.icon, "Check save icon", Icons.save)
            .having((i) => i.color, "Check save icon color", Colors.pink);
        final icon = find.byType(Icon);
        expect(icon, findsOneWidget);
        expect(icon.evaluate().first.widget, iconConditions);

        verifyNever(mockController.saveAvatarSVG());
      });

      testWidgets("With custom child", (WidgetTester tester) async {
        final customChild = Text("Custom Child");
        await tester.pumpWidget(buildTestWidget(AvatarMakerSaveWidget(
          child: customChild,
          controller: mockController,
        )));

        expect(find.text("Custom Child"), findsOneWidget);
        expect(find.byType(Icon), findsNothing);

        verifyNever(mockController.saveAvatarSVG());
      });

      testWidgets("With persistant controller", (WidgetTester tester) async {
        final controller =
            PersistentAvatarMakerController(customizedPropertyCategories: []);
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AvatarMakerSaveWidget(
                controller: controller,
              ),
            ),
          ),
        );

        expect(find.byType(Icon), findsOneWidget);

        verifyNever(mockController.saveAvatarSVG());
      });

      testWidgets("With non persistant controller",
          (WidgetTester tester) async {
        final controller = NonPersistentAvatarMakerController(
            customizedPropertyCategories: []);
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AvatarMakerSaveWidget(
                controller: controller,
              ),
            ),
          ),
        );

        expect(find.byType(Icon), findsNothing);

        verifyNever(mockController.saveAvatarSVG());
      });
    });

    group("On tap InkWell", () {
      testWidgets("Default", (WidgetTester tester) async {
        await tester.pumpWidget(buildTestWidget(AvatarMakerSaveWidget(
          controller: mockController,
        )));

        final inkwell = find.byType(InkWell);
        expect(inkwell, findsOneWidget);
        await tester.tap(inkwell);
        await tester.pump();

        verify(mockController.saveAvatarSVG()).called(1);
      });

      testWidgets("With onTap callback", (WidgetTester tester) async {
        String? savedAvatarSvg;
        await tester.pumpWidget(buildTestWidget(AvatarMakerSaveWidget(
          controller: mockController,
          onTap: (svg) {
            savedAvatarSvg = svg;
          },
        )));

        final inkwell = find.byType(InkWell);
        expect(inkwell, findsOneWidget);
        await tester.tap(inkwell);
        await tester.pump();

        verify(mockController.saveAvatarSVG()).called(1);
        verify(mockController.drawAvatarSVG()).called(1);
        expect(savedAvatarSvg, "test-svg");
      });

      testWidgets("With provided controller", (WidgetTester tester) async {
        final customController = MockPersistentAvatarMakerController();
        when(customController.saveAvatarSVG())
            .thenAnswer((_) => Future.value());
        when(customController.drawAvatarSVG()).thenReturn("custom-svg");
        when(customController.isPersistentController()).thenReturn(true);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AvatarMakerSaveWidget(
                controller: customController,
              ),
            ),
          ),
        );

        final inkwell = find.byType(InkWell);
        expect(inkwell, findsOneWidget);
        await tester.tap(inkwell);
        await tester.pump();

        verify(customController.saveAvatarSVG()).called(1);
        verifyNever(mockController.saveAvatarSVG());
      });
    });
  });
}
