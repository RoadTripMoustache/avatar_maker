import "package:avatar_maker/src/core/enums/placeholders.dart";
import "package:avatar_maker/src/core/enums/property_items/outfit_colors.dart";
import "package:avatar_maker/src/core/enums/property_items/outfit_types.dart";

/// Contains all the methods related to outfits.
class OutfitService {
  /// Replace the declarations of the outfit color placeholder with the
  /// selected color.
  static String generateOutfit({
    OutfitTypes type = OutfitTypes.Hoodie,
    OutfitColors color = OutfitColors.Black,
  }) {
    return type.svg
        .replaceAll(TO_REPLACE_WITH_OUTFIT_COLOR_NAME, color.id)
        .replaceAll(TO_REPLACE_WITH_OUTFIT_COLOR, color.hexCode);
  }

  /// Draw the SVG of an outfit with the type and the color given in
  /// parameter.
  static String drawSVG({
    OutfitTypes type = OutfitTypes.Hoodie,
    OutfitColors color = OutfitColors.Black,
  }) {
    return """<svg width="100px" height="120px" viewBox="30 100 200 250" >
      ${generateOutfit(
      color: color,
      type: type,
    )}
    </svg>""";
  }
}
