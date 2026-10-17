import "package:avatar_maker/avatar_maker.dart";
import "package:flutter_test/flutter_test.dart";

/// Counts how many times the (expensive) SVG string is generated.
class _CountingController extends NonPersistentAvatarMakerController {
  int drawCalls = 0;

  @override
  String drawAvatarSVG({
    Map<PropertyCategoryIds, PropertyItem>? selectedOptionsOverride,
  }) {
    drawCalls++;
    return super.drawAvatarSVG(
      selectedOptionsOverride: selectedOptionsOverride,
    );
  }
}

void main() {
  group("AvatarMakerController.savedAvatarSVG", () {
    test("matches drawAvatarSVG(selectedOptionsOverride: selectedOptions)",
        () async {
      final controller = _CountingController();
      await controller.initController();

      expect(
        controller.savedAvatarSVG,
        equals(
          controller.drawAvatarSVG(
            selectedOptionsOverride: controller.selectedOptions,
          ),
        ),
      );
    });

    test("is memoized across repeated reads", () async {
      final controller = _CountingController();
      await controller.initController();
      controller.drawCalls = 0;

      final first = controller.savedAvatarSVG;
      final second = controller.savedAvatarSVG;
      final third = controller.savedAvatarSVG;

      expect(controller.drawCalls, 1,
          reason: "the SVG must only be generated once while the selected "
              "options are unchanged");
      expect(second, same(first));
      expect(third, same(first));
    });

    test("is invalidated when selectedOptions changes", () async {
      final controller = _CountingController();
      await controller.initController();
      final before = controller.savedAvatarSVG;

      final skinCategory = controller.propertyCategories
          .firstWhere((c) => c.id == PropertyCategoryIds.SkinColor);
      final otherSkin = skinCategory.properties!
          .firstWhere((item) => item != controller.selectedOptions[
              PropertyCategoryIds.SkinColor]);

      controller.drawCalls = 0;
      controller.selectedOptions[PropertyCategoryIds.SkinColor] = otherSkin;

      final after = controller.savedAvatarSVG;
      expect(controller.drawCalls, 1);
      expect(after, isNot(equals(before)));
      expect(controller.savedAvatarSVG, same(after));
    });

    test("ignores an active preview", () async {
      final controller = _CountingController();
      await controller.initController();
      final savedBeforePreview = controller.savedAvatarSVG;

      final hairCategory = controller.displayedPropertyCategories
          .firstWhere((c) => c.id == PropertyCategoryIds.HairStyle);
      final current = controller.selectedOptions[PropertyCategoryIds.HairStyle]!;
      final alternative =
          hairCategory.properties!.firstWhere((item) => item.id != current.id);

      controller.previewOption(alternative, PropertyCategoryIds.HairStyle);

      // The preview is reflected in displayedAvatarSVG ...
      expect(controller.displayedAvatarSVG,
          isNot(equals(savedBeforePreview)));
      // ... but savedAvatarSVG keeps rendering the saved state.
      expect(controller.savedAvatarSVG, equals(savedBeforePreview));
    });
  });
}
