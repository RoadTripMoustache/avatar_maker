import "package:avatar_maker/src/core/enums/placeholders.dart";
import "package:avatar_maker/src/core/enums/property_items/outfit_colors.dart";
import "package:avatar_maker/src/core/enums/property_items/outfit_types.dart";

class OutfitService {
  static String generateOutfit({
    OutfitTypes type = OutfitTypes.Hoodie,
    OutfitColors color = OutfitColors.Black,
  }) {
    return type.svg.replaceAll(TO_REPLACE_WITH_OUTFIT_COLOR, color.hexCode);
  }
}
