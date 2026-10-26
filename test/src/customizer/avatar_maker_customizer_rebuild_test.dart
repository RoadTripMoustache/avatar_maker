import "package:avatar_maker/avatar_maker.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

/// Counts the tiles built by the customizer grid.
///
/// The `isItemLocked` callback is invoked once for every built tile, which
/// makes it the cheapest way to observe how many times the grid is built.
class _TileCounter {
  int count = 0;
}

Widget _customizer(AvatarMakerController controller, _TileCounter counter) {
  return MaterialApp(
    home: Scaffold(
      body: AvatarMakerCustomizer(
        controller: controller,
        scaffoldHeight: 600,
        isItemLocked: (PropertyCategoryIds category, String itemId) {
          counter.count++;
          return false;
        },
      ),
    ),
  );
}

void main() {
  group("Customizer rebuild behaviour", () {
    testWidgets(
        "does not rebuild the grid when the controller notifies without a "
        "visible change", (WidgetTester tester) async {
      final controller = NonPersistentAvatarMakerController();
      final counter = _TileCounter();

      await tester.pumpWidget(_customizer(controller, counter));
      await tester.pumpAndSettle();

      final tilesAfterOpen = counter.count;
      expect(
        tilesAfterOpen,
        greaterThan(0),
        reason: "the grid must have built its tiles when it opened",
      );

      // The controller notifies its listeners on every state change, even the
      // ones the customizer does not render (the avatar SVG, the saved
      // state, ...). Rebuilding the grid for those drops frames.
      controller.updatePreview();
      await tester.pump();

      expect(
        counter.count,
        tilesAfterOpen,
        reason: "a notification without a visible change must not rebuild the "
            "grid",
      );
    });

    testWidgets("rebuilds the grid when the selected option changes",
        (WidgetTester tester) async {
      final controller = NonPersistentAvatarMakerController();
      final counter = _TileCounter();

      await tester.pumpWidget(_customizer(controller, counter));
      await tester.pumpAndSettle();

      final tilesBefore = counter.count;

      controller.selectedOptions[PropertyCategoryIds.HairStyle] =
          HairStyles.values[5];
      controller.updatePreview();
      await tester.pump();

      expect(
        counter.count,
        greaterThan(tilesBefore),
        reason: "the grid must be rebuilt when the selection changes",
      );
    });

    testWidgets("rebuilds the grid when the previewed option changes",
        (WidgetTester tester) async {
      final controller = NonPersistentAvatarMakerController();
      final counter = _TileCounter();

      await tester.pumpWidget(_customizer(controller, counter));
      await tester.pumpAndSettle();

      final tilesBefore = counter.count;

      controller.previewOption(
        HairStyles.values[7],
        PropertyCategoryIds.HairStyle,
      );
      await tester.pump();

      expect(
        counter.count,
        greaterThan(tilesBefore),
        reason: "the grid must be rebuilt when the preview changes",
      );
    });

    testWidgets("rebuilds the grid when the hair color changes",
        (WidgetTester tester) async {
      final controller = NonPersistentAvatarMakerController();
      final counter = _TileCounter();

      await tester.pumpWidget(_customizer(controller, counter));
      await tester.pumpAndSettle();

      final tilesBefore = counter.count;

      // The hair style thumbnails are drawn with the selected hair color, so
      // a color change has to rebuild them.
      controller.selectedOptions[PropertyCategoryIds.HairColor] =
          HairColors.Red;
      controller.updatePreview();
      await tester.pump();

      expect(
        counter.count,
        greaterThan(tilesBefore),
        reason: "the grid must be rebuilt when the hair color changes",
      );
    });
  });
}
