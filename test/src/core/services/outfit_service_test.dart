import 'package:flutter_test/flutter_test.dart';
import 'package:avatar_maker/src/core/enums/placeholders.dart';
import 'package:avatar_maker/src/core/enums/property_items/outfit_colors.dart';
import 'package:avatar_maker/src/core/enums/property_items/outfit_types.dart';
import 'package:avatar_maker/src/core/services/outfit_service.dart';

void main() {
  const String tHoodieSvgTemplate = """
<g id=" OutfitTypes/Hoodie" transform="translate(0.000000, 170.000000)">
       <defs>
        <path d="M108,13.0708856 C90.0813006,15.075938 76.2798424,20.5518341 76.004203,34.6449676 C50.1464329,45.5680933 32,71.1646257 32,100.999485 L32,100.999485 L32,110 L232,110 L232,100.999485 C232,71.1646257 213.853567,45.5680933 187.995797,34.6449832 C187.720158,20.5518341 173.918699,15.075938 156,13.0708856 L156,32 L156,32 C156,45.254834 145.254834,56 132,56 L132,56 C118.745166,56 108,45.254834 108,32 L108,13.0708856 Z" id="react-path-35937"></path>
       </defs>
       <mask id="react-mask-35938" fill="white">
        <use xlink:href="#react-path-35937"></use>
       </mask>
       <use id="Hoodie" fill="#B7C1DB" fill-rule="evenodd" xlink:href="#react-path-35937"></use>
       <g id="$TO_REPLACE_WITH_OUTFIT_COLOR_NAME" mask="url(#react-mask-35938)" fill-rule="evenodd" fill="$TO_REPLACE_WITH_OUTFIT_COLOR">
        <rect id="🖍Color" x="0" y="0" width="264" height="110"></rect>
       </g>
       <path d="M102,61.7390531 L102,110 L95,110 L95,58.1502625 C97.2037542,59.4600576 99.5467694,60.6607878 102,61.7390531 Z M169,58.1502625 L169,98.5 C169,100.432997 167.432997,102 165.5,102 C163.567003,102 162,100.432997 162,98.5 L162,61.7390531 C164.453231,60.6607878 166.796246,59.4600576 169,58.1502625 Z" id="Straps" fill="#F4F4F4" fill-rule="evenodd" mask="url(#react-mask-35938)"></path>
       <path d="M90.9601329,12.7243537 C75.9093095,15.5711782 65.5,21.2428847 65.5,32.3076923 C65.5,52.0200095 98.5376807,68 132,68 C165.462319,68 198.5,52.0200095 198.5,32.3076923 C198.5,21.2428847 188.09069,15.5711782 173.039867,12.7243537 C182.124921,16.0744598 188,21.7060546 188,31.0769231 C188,51.4689754 160.178795,68 132,68 C103.821205,68 76,51.4689754 76,31.0769231 C76,21.7060546 81.8750795,16.0744598 90.9601329,12.7243537 Z" id="Shadow" fill-opacity="0.16" fill="#000000" fill-rule="evenodd" mask="url(#react-mask-35938)"></path>
      </g>
        """;

  final OutfitColors tColorLightBlue = OutfitColors.LightBlue;
  final OutfitTypes tTypeHoodie = OutfitTypes.Hoodie;

  group('OutfitService', () {
    // -------------------------------------------------------------------------
    // generateOutfit TESTS
    // -------------------------------------------------------------------------
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
