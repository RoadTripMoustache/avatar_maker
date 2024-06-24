import "package:avatar_maker/src/enums/placeholders.dart";
import "package:avatar_maker/src/enums/property_items/facial_hair_colors.dart";
import "package:avatar_maker/src/enums/property_items/facial_hair_types.dart";

class FacialHairsService {
  static String generateFacialHair({
    FacialHairTypes type = FacialHairTypes.Nothing,
    FacialHairColors color = FacialHairColors.Black,
  }) {
    return type.svg
        .replaceAll(TO_REPLACE_WITH_FACIAL_HAIRS_COLOR, color.hexCode);
  }
}
