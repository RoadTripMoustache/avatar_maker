import "package:avatar_maker/src/enums/placeholders.dart";
import "package:avatar_maker/src/enums/property_items/hair_colors.dart";
import "package:avatar_maker/src/enums/property_items/hair_styles.dart";

class HairService {
  static String generateHairStyle({
    HairStyles style = HairStyles.Eyepatch,
    HairColors color = HairColors.Black,
  }) {
    return style.svg.replaceAll(TO_REPLACE_WITH_HAIRS_COLOR, color.hexCode);
  }
}
