import 'package:avatar_maker/src/core/services/eyebrow_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EyebrowService', () {
    group('drawSVG', () {
      const String svgTemplateStart =
          '<svg width="20px" height="20px" viewBox="-3 -50 120 120">';
      const String svgTemplateEnd = '</svg>';

      test(
          'should wrap the provided eyebrow string inside the standard SVG template',
          () {
        // Arrange
        const String tEyebrowContent = '<path d="M0,0 L100,0" stroke="black"/>';

        // Act
        final String result = EyebrowService.drawSVG(eyebrow: tEyebrowContent);

        // Assert
        expect(result.trim(), startsWith(svgTemplateStart));
        expect(result.trim(), endsWith(svgTemplateEnd));

        expect(result.trim(), contains(tEyebrowContent));

        const String expectedSVG = """
      <svg width="20px" height="20px" viewBox="-3 -50 120 120">
        <path d="M0,0 L100,0" stroke="black"/>
      </svg>
    """;
        expect(result.trim(), equals(expectedSVG.trim()));
      });

      test(
          'should return the standard SVG template when an empty eyebrow string is provided',
          () {
        // Arrange
        const String tEmptyContent = '';

        // Act
        final String result = EyebrowService.drawSVG(eyebrow: tEmptyContent);

        // Assert
        expect(result.trim(), startsWith(svgTemplateStart));
        expect(result.trim(), endsWith(svgTemplateEnd));

        const String expectedSVG = """
      <svg width="20px" height="20px" viewBox="-3 -50 120 120">
        
      </svg>
    """;
        expect(result.trim(), equals(expectedSVG.trim()));
      });
    });
  });
}
