import "dart:convert";

import "package:avatar_maker/avatar_maker.dart";
import "package:avatar_maker/src/core/services/property_category_service.dart";

class OptionsService {
  /// Encode the selected options to a JSON string
  static String jsonEncodeSelectedOptions(
      Map<PropertyCategoryIds, PropertyItem> selectedOptions) {
    Map<String, String> optionsToEncode = {};
    selectedOptions.forEach((key, value) =>
        optionsToEncode.putIfAbsent(key.name, () => value.label));
    return jsonEncode(optionsToEncode);
  }

  /// Decode the JSON selected options to a
  /// Map<PropertyCategoryIds, PropertyItem>.
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
