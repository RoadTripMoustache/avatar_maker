import 'package:flutter_test/flutter_test.dart';
import 'package:avatar_maker/src/core/enums/placeholders.dart';
import 'package:avatar_maker/src/core/enums/property_items/outfit_colors.dart';
import 'package:avatar_maker/src/core/enums/property_items/outfit_types.dart';
import 'package:avatar_maker/src/core/services/outfit_service.dart';

void main() {
  final OutfitColors tColorLightBlue = OutfitColors.LightBlue;
  final OutfitTypes tTypeHoodie = OutfitTypes.Hoodie;

  group('OutfitService', () {
    group('generateOutfit', () {
      test(
          'should correctly replace both placeholders for Hoodie and LightBlue color',
          () {
        // Arrange
        final String tColorId = tColorLightBlue.id;
        final String tHexCode = tColorLightBlue.hexCode;

        // Act
        final String result = OutfitService.generateOutfit(
          type: tTypeHoodie,
          color: tColorLightBlue,
        );

        // Assert
        expect(result, isNot(contains(TO_REPLACE_WITH_OUTFIT_COLOR_NAME)));
        expect(result, isNot(contains(TO_REPLACE_WITH_OUTFIT_COLOR)));

        expect(result, contains('id="$tColorId"'));
        expect(result, contains('fill="$tHexCode"'));
      });

      test(
          'should use default values (Hoodie, Black) if no parameters are provided',
          () {
        // Arrange
        final OutfitTypes tDefaultType = OutfitTypes.Hoodie;
        final OutfitColors tDefaultColor = OutfitColors.Black;

        // Act
        final String result = OutfitService.generateOutfit(
          type: tDefaultType,
          color: tDefaultColor,
        );

        // ASSERT
        final String tDefaultColorId = tDefaultColor.id;
        final String tDefaultHexCode = tDefaultColor.hexCode;

        expect(result, isNot(contains(TO_REPLACE_WITH_OUTFIT_COLOR_NAME)));
        expect(result, isNot(contains(TO_REPLACE_WITH_OUTFIT_COLOR)));

        expect(result, contains('id="$tDefaultColorId"'));
        expect(result, contains('fill="$tDefaultHexCode"'));
      });
    });

    group('drawSVG', () {
      const String svgTemplateStart =
          '<svg width="100px" height="120px" viewBox="30 100 200 250" >';
      const String svgTemplateEnd = '</svg>';

      test(
          'should wrap the generated content (Hoodie/Black) inside the standard SVG template',
          () {
        // Arrange
        final OutfitTypes tType = OutfitTypes.Hoodie;
        final OutfitColors tColor = OutfitColors.Black;

        // Act
        final String result = OutfitService.drawSVG(
          type: tType,
          color: tColor,
        );

        // Assert
        expect(result.trim(), startsWith(svgTemplateStart));
        expect(result.trim(), endsWith(svgTemplateEnd));

        expect(result, contains('id="${tColor.id}"'));
        expect(result, contains('fill="${tColor.hexCode}"'));

        expect(result, isNot(contains(TO_REPLACE_WITH_OUTFIT_COLOR_NAME)));
      });
    });
  });
}
