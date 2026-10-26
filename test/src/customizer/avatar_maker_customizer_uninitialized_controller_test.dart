import "dart:async";

import "package:avatar_maker/avatar_maker.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

/// Controller whose initialisation can be released on demand.
///
/// It reproduces the situation of an application which creates the controller
/// before the customizer is mounted: the customizer is built and rendered
/// while the controller is still initialising.
class _DeferredInitController extends NonPersistentAvatarMakerController {
  final Completer<void> gate = Completer<void>();

  @override
  Future<Map<PropertyCategoryIds, PropertyItem>> getSelectedOptions() async {
    await gate.future;
    return selectedOptions;
  }
}

void main() {
  group("Customizer with a controller that is not initialised yet", () {
    testWidgets("does not crash", (WidgetTester tester) async {
      final controller = _DeferredInitController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AvatarMakerCustomizer(
              controller: controller,
              scaffoldHeight: 600,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(
        tester.takeException(),
        isNull,
        reason: "the customizer must survive a controller which is still "
            "initialising",
      );

      controller.gate.complete();
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });

    testWidgets("renders the options once the controller is initialised",
        (WidgetTester tester) async {
      final controller = _DeferredInitController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AvatarMakerCustomizer(
              controller: controller,
              scaffoldHeight: 600,
            ),
          ),
        ),
      );
      await tester.pump();

      controller.gate.complete();
      await tester.pumpAndSettle();

      expect(
        tester.takeException(),
        isNull,
        reason: "the grid must be rendered with the initialised options",
      );
      expect(find.byType(InkWell), findsWidgets);
    });
  });
}
