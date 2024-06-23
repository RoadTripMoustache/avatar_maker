import 'package:avatar_maker/src/enums/property_categories.dart';
import 'package:avatar_maker/src/models/customized_property_category.dart';
import 'package:avatar_maker/src/models/property_category.dart';
import 'package:avatar_maker/src/models/property_item.dart';
import 'package:get/get.dart';

class PropertyCategoryService {
  /// mergePropertyCategories - Override the [PropertyCategories] with a list
  /// of [CustomizedPropertyCategory] given in parameters.
  /// If the same property is override multiple times, only the first will be
  /// considered.
  // TODO : Doc + params
  static List<CustomizedPropertyCategory> mergePropertyCategories(
    List<CustomizedPropertyCategory>? customizedPropertyCategories,
  ) {
    if (customizedPropertyCategories == null || customizedPropertyCategories.isEmpty) {
      return PropertyCategories.values
          .map(_toCustomizedPropertyCategory)
          .toList();
    }

    List<CustomizedPropertyCategory> mergedCategoriesList = List.empty();

    PropertyCategories.values.forEach((propertyCategory) {
      // Search if is there a customization for the category.
      CustomizedPropertyCategory? customizedPropertyCategory =
          customizedPropertyCategories.firstWhereOrNull(
        (element) => element.id == propertyCategory.id,
      );

      // If not, add the base property category
      if (customizedPropertyCategory == null) {
        mergedCategoriesList
            .add(_toCustomizedPropertyCategory(propertyCategory));
      } else {
        // Otherwise, override the base property category parameters with the
        // ones defined in the customized property category.
        mergedCategoriesList.add(_mergePropertyCategories(
          propertyCategory,
          customizedPropertyCategory,
        ));
      }
    });

    return mergedCategoriesList;
  }

  static CustomizedPropertyCategory _mergePropertyCategories(
    PropertyCategory propertyCategory,
    CustomizedPropertyCategory customizedPropertyCategory,
  ) {
    List<PropertyItem> properties = propertyCategory.properties;
    if (customizedPropertyCategory.properties != null &&
        customizedPropertyCategory.properties!.isNotEmpty) {
      properties = customizedPropertyCategory.properties!;
    }

    PropertyItem defaultValue = customizedPropertyCategory.defaultValue ??
        propertyCategory.defaultValue;

    // Check if the default value of the property category is in its property list.
    PropertyItem? defaultValueInThePropertyList = properties
        .firstWhereOrNull((element) => element.name == defaultValue.name);
    if (defaultValueInThePropertyList == null) {
      throw new ArgumentError(
        "The default value of a category must be in its property list.",
        "defaultValue missing in the properties",
      );
    }

    return CustomizedPropertyCategory(
      id: propertyCategory.id,
      toDisplay: customizedPropertyCategory.toDisplay,
      name: customizedPropertyCategory.name ?? propertyCategory.name,
      defaultValue: defaultValue,
      iconFile:
          customizedPropertyCategory.iconFile ?? propertyCategory.iconFile,
      properties: properties,
    );
  }

  static CustomizedPropertyCategory _toCustomizedPropertyCategory(
      PropertyCategory propertyCategory) {
    return CustomizedPropertyCategory(
      id: propertyCategory.id,
      toDisplay: propertyCategory.toDisplay,
      name: propertyCategory.name,
      defaultValue: propertyCategory.defaultValue,
      iconFile: propertyCategory.iconFile,
      properties: propertyCategory.properties,
    );
  }
}
