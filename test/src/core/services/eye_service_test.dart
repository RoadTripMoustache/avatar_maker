import 'package:avatar_maker/src/core/services/eye_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EyeService', () {
    group('drawSVG', () {
      const String svgTemplateStart =
          '<svg width="20px" height="20px" viewBox="-3 -30 120 120">';
      const String svgTemplateEnd = '</svg>';

      test(
          'should wrap the provided eye string inside the standard SVG template',
          () {
        // Arrange
        const String tEyeContent =
            '<circle cx="50" cy="50" r="10" fill="blue"/>';

        // Act
        final String result = EyeService.drawSVG(eye: tEyeContent);

        // Assert
        expect(result.trim(), startsWith(svgTemplateStart));
        expect(result.trim(), endsWith(svgTemplateEnd));

        expect(result.trim(), contains(tEyeContent));

        const String expectedSVG = """
      <svg width="20px" height="20px" viewBox="-3 -30 120 120">
        <circle cx="50" cy="50" r="10" fill="blue"/>
      </svg>
    """;
        expect(result.trim(), equals(expectedSVG.trim()));
      });

      test(
          'should return the standard SVG template when an empty eye string is provided',
          () {
        // Arrange
        const String tEmptyContent = '';

        // Act
        final String result = EyeService.drawSVG(eye: tEmptyContent);

        // Assert
        expect(result.trim(), startsWith(svgTemplateStart));
        expect(result.trim(), endsWith(svgTemplateEnd));

        const String expectedSVG = """
      <svg width="20px" height="20px" viewBox="-3 -30 120 120">
        
      </svg>
    """;
        expect(result.trim(), equals(expectedSVG.trim()));
      });
    });
  });
}
