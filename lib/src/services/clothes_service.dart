import 'package:avatar_maker/src/enums/placeholders.dart';
import 'package:avatar_maker/src/enums/property_items/outfit_colors.dart';
import 'package:avatar_maker/src/enums/property_items/outfit_types.dart';

class ClothesService {
  static String generateClothes({
    OutfitTypes type = OutfitTypes.Hoodie,
    OutfitColors color = OutfitColors.Black,
  }) {
    return type.svg.replaceAll(TO_REPLACE_WITH_CLOTHES_COLOR, color.hexCode);
  }
}
