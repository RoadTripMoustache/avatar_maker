import 'package:avatar_maker/src/core/services/background_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BackgroundService', () {
    group('drawSVG', () {

      // Contenu SVG de base pour le test.
      const String svgTemplateStart = '<svg width="264px" height="280px" viewBox="0 0 264 280"';
      const String svgTemplateEnd = '</svg>';

      test('should wrap the provided background string inside the standard SVG template', () {
        // Arrange
        const String tBackgroundContent = '<rect x="0" y="0" width="100%" height="100%" fill="#FF5733"/>';

        // Act
        final String result = BackgroundService.drawSVG(background: tBackgroundContent);

        // Assert
        expect(result.trim(), startsWith(svgTemplateStart));
        expect(result.trim(), contains(tBackgroundContent));
        expect(result.trim(), endsWith(svgTemplateEnd));
      });

      test('should maintain the SVG template structure when an empty background string is provided', () {
        // Arrange
        const String tBackgroundContent = '';

        // Act
        final String result = BackgroundService.drawSVG(background: tBackgroundContent);

        // Assert
        expect(result.trim(), startsWith(svgTemplateStart));
        expect(result.trim(), contains('<g transform="translate(825.000000, 1100.000000)">'));
        expect(result.trim(), endsWith(svgTemplateEnd));
      });

      test('should correctly place the background content within the specified SVG group', () {
        // Arrange
        const String tBackgroundContent = '<circle cx="132" cy="140" r="50" fill="blue"/>';

        // Act
        final String result = BackgroundService.drawSVG(background: tBackgroundContent);

        // Assert
        expect(result.trim(), contains(
            '<g transform="translate(825.000000, 1100.000000)">'
                '$tBackgroundContent'
                '\n                      <g id="Mask"></g>'
        ));
      });
    });
  });
}