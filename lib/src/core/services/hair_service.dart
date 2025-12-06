import "package:avatar_maker/src/core/enums/placeholders.dart";
import "package:avatar_maker/src/core/enums/property_items/hair_colors.dart";
import "package:avatar_maker/src/core/enums/property_items/hair_styles.dart";

/// Contains all the methods related to hairs.
class HairService {
  /// Replace the declarations of the hairs color placeholder with the
  /// selected color.
  static String generateHairStyle({
    HairStyles style = HairStyles.Eyepatch,
    HairColors color = HairColors.Black,
  }) {
    return style.svg
        .replaceAll(TO_REPLACE_WITH_HAIRS_COLOR_NAME, color.id)
        .replaceAll(TO_REPLACE_WITH_HAIRS_COLOR, color.hexCode);
  }

  /// Draw the SVG of an hair with the type and the color given in
  /// parameter.
  static String drawSVG({
    HairStyles style = HairStyles.Eyepatch,
    HairColors color = HairColors.Black,
  }) {
    return """
      <svg width="100px" height="100px" viewBox="10 0 250 250">
        ${generateHairStyle(
      color: color,
      style: style,
    )}
      </svg>
    """;
  }
}
