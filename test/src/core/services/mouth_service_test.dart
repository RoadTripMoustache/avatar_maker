import 'package:avatar_maker/src/core/services/mouth_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MouthService', () {
    group('drawSVG', () {
      const String svgTemplateStart =
          '<svg width="20px" height="20px" viewBox="0 10 120 120">';
      const String svgTemplateEnd = '</svg>';

      test(
          'should wrap the provided mouth string inside the standard SVG template',
          () {
        // Arrange
        const String tMouthContent =
            '<path d="M10,60 C40,90 80,90 110,60" stroke="red"/>';

        // Act
        final String result = MouthService.drawSVG(mouth: tMouthContent);

        // Assert
        expect(result.trim(), startsWith(svgTemplateStart));
        expect(result.trim(), endsWith(svgTemplateEnd));
        expect(result.trim(), contains(tMouthContent));

        const String expectedSVG = """
      <svg width="20px" height="20px" viewBox="0 10 120 120">
        <path d="M10,60 C40,90 80,90 110,60" stroke="red"/>
      </svg>
    """;
        expect(result.trim(), equals(expectedSVG.trim()));
      });

      test(
          'should return the standard SVG template when an empty mouth string is provided',
          () {
        // Arrange
        const String tEmptyContent = '';

        // Act
        final String result = MouthService.drawSVG(mouth: tEmptyContent);

        // Assert
        expect(result.trim(), startsWith(svgTemplateStart));
        expect(result.trim(), endsWith(svgTemplateEnd));

        const String expectedSVG = """
      <svg width="20px" height="20px" viewBox="0 10 120 120">
        
      </svg>
    """;
        expect(result.trim(), equals(expectedSVG.trim()));
      });
    });
  });
}
