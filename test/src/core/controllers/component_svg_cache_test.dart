import "package:avatar_maker/avatar_maker.dart";
import "package:avatar_maker/src/core/services/hair_service.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  // "Long" is a hair style drawn with the selected hair color, so its
  // thumbnail changes when the color changes. ("Bald", the first style, has
  // no thumbnail of its own.)
  const int coloredHairStyle = 4;

  group("getComponentSVG memoization", () {
    test("returns the very same string for repeated calls", () {
      final controller = NonPersistentAvatarMakerController();

      final first = controller.getComponentSVG(
          PropertyCategoryIds.HairStyle, coloredHairStyle);
      final second = controller.getComponentSVG(
          PropertyCategoryIds.HairStyle, coloredHairStyle);

      expect(
        identical(first, second),
        isTrue,
        reason: "the generated SVG must be reused instead of being generated "
            "again for every tile of every rebuild",
      );
    });

    test("generates a different SVG when the hair color changes", () {
      final controller = NonPersistentAvatarMakerController();

      final black = controller.getComponentSVG(
          PropertyCategoryIds.HairStyle, coloredHairStyle);

      controller.selectedOptions[PropertyCategoryIds.HairColor] =
          HairColors.Red;
      final red = controller.getComponentSVG(
          PropertyCategoryIds.HairStyle, coloredHairStyle);

      expect(identical(black, red), isFalse);
      expect(red, contains(HairColors.Red.hexCode));
      expect(black, isNot(contains(HairColors.Red.hexCode)));
    });

    test("keeps the cache of the other categories untouched", () {
      final controller = NonPersistentAvatarMakerController();

      final hair = controller.getComponentSVG(
          PropertyCategoryIds.HairStyle, coloredHairStyle);
      final nose = controller.getComponentSVG(PropertyCategoryIds.Nose, 0);

      controller.selectedOptions[PropertyCategoryIds.HairColor] =
          HairColors.Red;
      controller.getComponentSVG(
          PropertyCategoryIds.HairStyle, coloredHairStyle);

      expect(
        identical(
            controller.getComponentSVG(PropertyCategoryIds.Nose, 0), nose),
        isTrue,
        reason: "only the category depending on the color must be invalidated",
      );
      expect(
        identical(
          controller.getComponentSVG(
              PropertyCategoryIds.HairStyle, coloredHairStyle),
          hair,
        ),
        isFalse,
      );
    });

    test("the memoized SVG is identical to a freshly generated one", () {
      final controller = NonPersistentAvatarMakerController();

      final memoized = controller.getComponentSVG(
          PropertyCategoryIds.HairStyle, coloredHairStyle);
      final fresh = HairService.drawSVG(
        color: HairColors.Black,
        style: HairStyles.values[coloredHairStyle],
      );

      expect(memoized, fresh);
    });

    test("the memoized SVG is regenerated with the new hair color", () {
      final controller = NonPersistentAvatarMakerController();

      controller.getComponentSVG(
          PropertyCategoryIds.HairStyle, coloredHairStyle);

      controller.selectedOptions[PropertyCategoryIds.HairColor] =
          HairColors.Blue;
      final memoized = controller.getComponentSVG(
          PropertyCategoryIds.HairStyle, coloredHairStyle);
      final fresh = HairService.drawSVG(
        color: HairColors.Blue,
        style: HairStyles.values[coloredHairStyle],
      );

      expect(memoized, fresh);
    });
  });
}
