import "package:avatar_maker/src/core/enums/placeholders.dart";
import "package:avatar_maker/src/core/enums/property_items/hair_colors.dart";
import "package:avatar_maker/src/core/enums/property_items/hair_styles.dart";

class HairService {
  static String generateHairStyle({
    HairStyles style = HairStyles.Eyepatch,
    HairColors color = HairColors.Black,
  }) {
    return style.svg.replaceAll(TO_REPLACE_WITH_HAIRS_COLOR, color.hexCode);
  }

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
