import "package:avatar_maker/src/core/enums/placeholders.dart";
import "package:avatar_maker/src/core/enums/property_items/facial_hair_colors.dart";
import "package:avatar_maker/src/core/enums/property_items/facial_hair_types.dart";

class FacialHairsService {
  static String generateFacialHair({
    FacialHairTypes type = FacialHairTypes.Nothing,
    FacialHairColors color = FacialHairColors.Black,
  }) {
    return type.svg
        .replaceAll(TO_REPLACE_WITH_FACIAL_HAIRS_COLOR, color.hexCode);
  }

  static String drawSVG({
    FacialHairTypes type = FacialHairTypes.Nothing,
    FacialHairColors color = FacialHairColors.Black,
  }) {
    return """
    <svg width="20px" height="20px" viewBox="0 -40 112 180" >
      ${generateFacialHair(
      color: color,
      type: type,
    )}
    </svg>
    """;
  }
}
