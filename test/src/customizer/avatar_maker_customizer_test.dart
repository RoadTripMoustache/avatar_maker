import 'package:avatar_maker/avatar_maker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Locked Items Feature', () {
    test('isItemLocked callback should determine if an item is locked', () {
      // Test the lock logic itself
      bool isLocked(PropertyCategoryIds category, String itemId) {
        if (category == PropertyCategoryIds.Accessory &&
            itemId.contains("Glasses")) {
          return true;
        }
        return false;
      }

      // Verify the logic works correctly
      expect(
        isLocked(PropertyCategoryIds.Accessory, "Accessories/Glasses"),
        isTrue,
        reason: "Glasses should be locked in Accessory category",
      );

      expect(
        isLocked(PropertyCategoryIds.Accessory, "Accessories/Nothing"),
        isFalse,
        reason: "Non-Glasses accessories should not be locked",
      );

      expect(
        isLocked(PropertyCategoryIds.HairStyle, "Hair/Long"),
        isFalse,
        reason: "Items in other categories should not be locked",
      );
    });

    testWidgets('isItemLocked callback is properly passed to CustomizerBody',
        (WidgetTester tester) async {
      final controller = NonPersistentAvatarMakerController();

      bool lockCallbackCalled = false;
      bool isLocked(PropertyCategoryIds category, String itemId) {
        lockCallbackCalled = true;
        return category == PropertyCategoryIds.Accessory &&
            itemId == "Accessories/Glasses";
      }

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AvatarMakerCustomizer(
              controller: controller,
              isItemLocked: isLocked,
              scaffoldHeight: 600,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // The callback should have been called during rendering
      expect(
        lockCallbackCalled,
        isTrue,
        reason: "isItemLocked callback should be called when rendering items",
      );
    });

    testWidgets('Locked items logic can be verified',
        (WidgetTester tester) async {
      final controller = NonPersistentAvatarMakerController();

      bool isLocked(PropertyCategoryIds category, String itemId) {
        return category == PropertyCategoryIds.Accessory &&
            itemId.contains("Glasses");
      }

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AvatarMakerCustomizer(
              controller: controller,
              isItemLocked: isLocked,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify that locked items from Accessories category can be identified
      final accessoryCategory = controller.displayedPropertyCategories
          .firstWhere((c) => c.id == PropertyCategoryIds.Accessory);

      final glassesItems =
          accessoryCategory.properties!.where((p) => p.id.contains("Glasses"));

      // All glasses should be locked based on our logic
      expect(glassesItems.isNotEmpty, isTrue);

      for (final glassesItem in glassesItems) {
        expect(
          isLocked(PropertyCategoryIds.Accessory, glassesItem.id),
          isTrue,
          reason: "${glassesItem.id} should be locked",
        );
      }
    });

    testWidgets('Unlocked items should not show lock icon',
        (WidgetTester tester) async {
      final controller = NonPersistentAvatarMakerController();

      // Nothing is locked
      bool isLocked(PropertyCategoryIds category, String itemId) {
        return false;
      }

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AvatarMakerCustomizer(
              controller: controller,
              isItemLocked: isLocked,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // No lock icons should be present
      expect(find.byIcon(Icons.lock), findsNothing);
    });

    test('Controller should work without isItemLocked callback', () {
      // Test that the feature is optional
      final controller = NonPersistentAvatarMakerController();

      expect(
        () => controller.selectedOptions,
        returnsNormally,
        reason: "Controller should work without lock callback",
      );
    });
  });

  group('Custom Lock Widget and Callback', () {
    testWidgets('lockWidget should be displayed for locked items',
        (WidgetTester tester) async {
      final controller = NonPersistentAvatarMakerController();

      // Lock everything
      bool isLocked(PropertyCategoryIds category, String itemId) => true;

      final customLockIcon = Key('customLockIcon');

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AvatarMakerCustomizer(
              controller: controller,
              isItemLocked: isLocked,
              lockWidget: Container(
                key: customLockIcon,
                child: Icon(Icons.lock_clock),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Should find our custom widget
      expect(find.byKey(customLockIcon), findsWidgets);
      // Should NOT find the default lock icon (unless it's the same icon, but we used lock_clock)
      expect(find.byIcon(Icons.lock), findsNothing);
    });

    testWidgets('onTapLockedItem should be called when tapping a locked item',
        (WidgetTester tester) async {
      final controller = NonPersistentAvatarMakerController();

      // Lock everything
      bool isLocked(PropertyCategoryIds category, String itemId) => true;

      bool tapCallbackCalled = false;
      void onTapLocked(PropertyCategoryIds category, String itemId) {
        tapCallbackCalled = true;
      }

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AvatarMakerCustomizer(
              controller: controller,
              isItemLocked: isLocked,
              onTapLockedItem: onTapLocked,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Find any locked item (they are all locked) and tap it
      // We need to find a tappable area. The InkWell is inside the GridView.
      // Let's find the first item in the grid.
      final firstItem = find.byType(InkWell).first;
      await tester.tap(firstItem);
      await tester.pump();

      expect(tapCallbackCalled, isTrue,
          reason: "onTapLockedItem should be called");
    });
  });
}
