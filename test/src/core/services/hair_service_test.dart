import 'package:avatar_maker/src/core/enums/property_categories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:avatar_maker/src/core/enums/placeholders.dart';
import 'package:avatar_maker/src/core/enums/property_items/hair_colors.dart';
import 'package:avatar_maker/src/core/enums/property_items/hair_styles.dart';
import 'package:avatar_maker/src/core/services/hair_service.dart';

void main() {
  const HairStyles tStyle = HairStyles.BobCut;
  const HairColors tColor = HairColors.Blue;

  final String tColorId = HairColors.Blue.id;
  final String tHexCode = HairColors.Blue.value;

  group('HairService', () {
    group('generateHairStyle', () {
      test('should correctly replace both placeholders for LongHair and Blue color', () {
        // Act
        final String result = HairService.generateHairStyle(
          style: tStyle,
          color: tColor,
        );

        // Assert
        expect(result.trim(), equals("""
        <g id="Top" stroke-width="1" fill-rule="evenodd">
						<defs>
							<rect id="react-path-5910" x="0" y="0" width="264" height="280"></rect>
							<path d="M38,79.3595521 L38,111 C38,133.339168 51.0804213,152.623239 70,161.610951 L70,174.74565 C50.3625813,177.434228 34.6409914,182.163507 23.3845374,181.000327 C9.16164761,179.530612 1.49623627,150.795665 1,126 C0.382878875,95.1640258 29.3189583,30.7950013 40,18 C47.9231015,8.50878211 69.6952966,0.550643437 94.0001685,1 C118.30504,1.44935656 140.861928,6.81215989 149.000169,17 C161.324059,32.4276364 186.868727,91.0786423 187.000169,126 C187.093514,150.800049 177.46255,175.65995 164.000169,177 C152.920532,178.102871 137.475571,175.511343 118,173.997342 L118,161.610951 C136.919579,152.623239 150,133.339168 150,111 L150,82.9882378 C140.478735,78.1305678 131.863294,72.248172 124.153679,65.3410505 C127.362309,70.6368571 130.848786,75.1475352 134.61311,78.8730846 C107.596314,71.2928169 86.1055278,58.4501118 70.1407506,40.3449693 C62.1597317,56.8095313 51.4461487,69.8143919 38.0000014,79.3595511 Z" id="react-path-5911"></path>
						</defs>
						<mask id="react-mask-5908" fill="white">
							<use xlink:href="#react-path-5910"></use>
						</mask>
						<g id="Mask"></g>
						<g id="HairStyles/BobCut" mask="url(#react-mask-5908)">
							<g transform="translate(-1.000000, 0.000000)">
								<g id="Hair" stroke-width="1" fill-rule="evenodd" transform="translate(39.000000, 19.000000)">
									<mask id="react-mask-5909" fill="white">
										<use xlink:href="#react-path-5911"></use>
									</mask>
									<use id="Combined-Shape" fill="#E6E6E6" xlink:href="#react-path-5911"></use>
									<g id="HairColor/Blue" mask="url(#react-mask-5909)" fill="#0277BD">
										<g transform="translate(0.000000, 0.000000) " id="Color">
											<rect x="0" y="0" width="264" height="280"></rect>
										</g>
									</g>
								</g>
							</g>
						</g>
					</g>
        """.trim()));

        expect(result, isNot(contains(TO_REPLACE_WITH_HAIRS_COLOR_NAME)));
        expect(result, contains('id="$tColorId"')); // Ex: id="Blue"
        expect(result, contains('fill="$tHexCode"')); // Ex: fill="#0000FF"
      });

      test('should use default color value', () {
        // Arrange
        final HairColors tDefaultColor = HairColors.Black;

        // Act
        final String result = HairService.generateHairStyle(
          style: HairStyles.BobCut,
        );

        // ASSERT
        expect(result, isNot(contains(TO_REPLACE_WITH_HAIRS_COLOR_NAME)));
        expect(result, isNot(contains(TO_REPLACE_WITH_HAIRS_COLOR)));

        expect(result, contains(tDefaultColor.id));
        expect(result, contains(tDefaultColor.hexCode));
      });

      test('should use default style value', () {
        // Arrange
        final HairColors tDefaultColor = HairColors.Black;

        // Act
        final String result = HairService.generateHairStyle();

        // ASSERT
        expect(result, isNot(contains(TO_REPLACE_WITH_HAIRS_COLOR_NAME)));
        expect(result, isNot(contains(TO_REPLACE_WITH_HAIRS_COLOR)));

        expect(result, isNot(contains(tDefaultColor.id)));
        expect(result, isNot(contains(tDefaultColor.hexCode)));
        expect(result, contains(HairStyles.Eyepatch.value));
      });
    });

    group('drawSVG', () {

      const String svgTemplateStart = '<svg width="100px" height="100px" viewBox="10 0 250 250">';
      const String svgTemplateEnd = '</svg>';

      test('should wrap the generated content (BobCut/Blue) inside the standard SVG template', () {
        // Arrange
        final HairStyles tType = HairStyles.BobCut;
        final HairColors tColor = HairColors.Blue;

        // Act
        final String result = HairService.drawSVG(
          style: tType,
          color: tColor,
        );

        // Assert
        expect(result.trim(), startsWith(svgTemplateStart));
        expect(result.trim(), endsWith(svgTemplateEnd));

        expect(result, contains('id="$tColorId"'));
        expect(result, contains('fill="$tHexCode"'));

        expect(result, isNot(contains(TO_REPLACE_WITH_HAIRS_COLOR_NAME)));
      });
    });
  });
}