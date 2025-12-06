import 'package:avatar_maker/src/core/services/accessory_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AccessoryService', () {
    group('drawSVG', () {
      test(
          'should wrap the provided accessory string inside a standard SVG template',
          () {
        // Arrange
        const String tAccessoryContent =
            '<circle cx="50" cy="50" r="40" fill="red"/>';

        // Act
        final String result =
            AccessoryService.drawSVG(accessory: tAccessoryContent);

        // Assert
        expect(
            result.trim(),
            startsWith(
                '<svg width="20px" height="20px" viewBox="-3 -50 120 170" >'));
        expect(result.trim(), contains(tAccessoryContent));
        expect(result.trim(), endsWith('</svg>'));

        const String expectedSVG =
            """<svg width="20px" height="20px" viewBox="-3 -50 120 170" >
        <circle cx="50" cy="50" r="40" fill="red"/>
      </svg>
    """;
        expect(result.trim(), equals(expectedSVG.trim()));
      });

      test(
          'should return the standard SVG template when an empty accessory string is provided',
          () {
        // Arrange
        const String tAccessoryContent = '';

        // Act
        final String result =
            AccessoryService.drawSVG(accessory: tAccessoryContent);

        // Assert
        const String expectedSVG = """
      <svg width="20px" height="20px" viewBox="-3 -50 120 170" >
        
      </svg>
    """;
        expect(result.trim(), equals(expectedSVG.trim()));
      });
    });
  });
}
