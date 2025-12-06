import 'package:avatar_maker/src/core/services/color_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ColorService', () {
    group('drawSVG', () {
      test(
          'should correctly embed the provided hex color code into the SVG circle fill attribute',
          () {
        // Arrange
        const String tHexColorCode = '#FF0000'; // Rouge

        // Act
        final String result = ColorService.drawSVG(hexColorCode: tHexColorCode);

        // Assert
        expect(
            result.trim(), startsWith('<svg width="120px" height="120px" >'));
        expect(result.trim(), contains('fill="${tHexColorCode}"'));

        const String expectedSVG = """
      <svg width="120px" height="120px" > 
        <circle cx="60" cy="60" r="35" stroke="black" stroke-width="1" fill="#FF0000"/>
      </svg>
    """;
        expect(result.trim(), equals(expectedSVG.trim()));
      });

      test(
          'should correctly embed a different hex color code (e.g., Green) into the SVG',
          () {
        // Arrange
        const String tHexColorCode = '#00FF00'; // Vert

        // Act
        final String result = ColorService.drawSVG(hexColorCode: tHexColorCode);

        // Assert
        expect(result.trim(), contains('fill="#00FF00"'));
      });

      test(
          'should handle empty or malformed input by embedding it directly as fill attribute value',
          () {
        // Arrange
        const String tInvalidInput = 'notAColor';

        // Act
        final String result = ColorService.drawSVG(hexColorCode: tInvalidInput);

        // Assert
        expect(result.trim(), contains('fill="notAColor"'));
      });
    });
  });
}
