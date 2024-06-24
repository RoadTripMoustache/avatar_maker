import "dart:convert";

import "package:avatar_maker/avatar_maker.dart";
import "package:avatar_maker/src/core/services/property_category_service.dart";

class OptionsService {
  static String jsonEncodeSelectedOptions(
      Map<PropertyCategoryIds, PropertyItem> selectedOptions) {
    Map<String, String> optionsToEncode = {};
    selectedOptions.forEach((key, value) =>
        optionsToEncode.putIfAbsent(key.name, () => value.label));
    return jsonEncode(optionsToEncode);
  }

  static Map<PropertyCategoryIds, PropertyItem> jsonDecodeSelectedOptions(
    List<CustomizedPropertyCategory> propertyCategories,
    String encodedOptions,
  ) {
    var decodedOptions = jsonDecode(encodedOptions);

    Map<PropertyCategoryIds, PropertyItem> selectedOptions = {};

    decodedOptions.forEach((key, value) {
      PropertyCategoryIds categoryId =
          PropertyCategoryIds.values.firstWhere((id) => id.name == key);
      PropertyItem item = PropertyCategoryService.getPropertyCategoryById(
              propertyCategories, categoryId)
          .properties!
          .firstWhere(
            (property) => property.label == value,
          );
      selectedOptions.putIfAbsent(categoryId, () => item);
    });
    return selectedOptions;
  }
}
