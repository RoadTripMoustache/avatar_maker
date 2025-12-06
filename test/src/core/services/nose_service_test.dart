import 'package:avatar_maker/src/core/services/nose_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NoseService', () {
    group('drawSVG', () {

      const String svgTemplateStart = '<svg width="20px" height="20px" viewBox="-3 -30 120 120">';
      const String svgTemplateEnd = '</svg>';

      test('should wrap the provided nose string inside the standard SVG template', () {
        // Arrange
        const String tNoseContent = '<path d="M50,40 L60,60 L40,60 Z" fill="brown"/>';

        // Act
        final String result = NoseService.drawSVG(nose: tNoseContent);

        // Assert
        expect(result.trim(), startsWith(svgTemplateStart));
        expect(result.trim(), endsWith(svgTemplateEnd));

        expect(result.trim(), contains(tNoseContent));

        const String expectedSVG = """
      <svg width="20px" height="20px" viewBox="-3 -30 120 120">
        <path d="M50,40 L60,60 L40,60 Z" fill="brown"/>
      </svg>
    """;
        expect(result.trim(), equals(expectedSVG.trim()));
      });

      test('should return the standard SVG template when an empty nose string is provided', () {
        // Arrange
        const String tEmptyContent = '';

        // Act
        final String result = NoseService.drawSVG(nose: tEmptyContent);

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