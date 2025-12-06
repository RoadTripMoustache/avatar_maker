import 'package:avatar_maker/src/core/services/skin_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SkinService', () {
    group('drawSVG', () {

      const String svgTemplateStart = '<svg width="264px" height="280px" viewBox="0 0 264 280"';
      const String svgTemplateEnd = '</svg>';

      const String insertionMarkerBefore = '<use fill="#D0C6AC" xlink:href="#path-5"></use>';
      const String insertionMarkerAfter = '<path';

      test('should wrap the provided skin color SVG inside the standard template', () {
        // Arrange
        const String tSkinColorContent = '<rect x="0" y="0" width="100%" height="100%" fill="#E0BB99"/>';

        // Act
        final String result = SkinService.drawSVG(skinColor: tSkinColorContent);

        // Assert
        expect(result.trim(), startsWith(svgTemplateStart));
        expect(result.trim(), endsWith(svgTemplateEnd));

        expect(result.trim(), contains(tSkinColorContent));

        final int indexBefore = result.indexOf(insertionMarkerBefore);
        final int indexContent = result.indexOf(tSkinColorContent);

        expect(indexContent, isNonNegative);
        expect(indexContent, greaterThan(indexBefore));
      });

      test('should maintain the SVG template structure when an empty skin color string is provided', () {
        // Arrange
        const String tEmptyContent = '';

        // Act
        final String result = SkinService.drawSVG(skinColor: tEmptyContent);

        // Assert
        expect(result.trim(), startsWith(svgTemplateStart));
        expect(result.trim(), endsWith(svgTemplateEnd));

        expect(result.trim(), contains(insertionMarkerBefore));
        expect(result.trim(), contains(insertionMarkerAfter));
      });
    });
  });
}