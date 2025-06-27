import "package:avatar_maker/avatar_maker.dart";
import "package:avatar_maker/l10n/app_localizations.dart";
import "package:avatar_maker/src/core/enums/property_categories.dart";
import "package:avatar_maker/src/core/models/property_category.dart";
import "package:collection/collection.dart";

/// Contains all the methods related to property categories.
class PropertyCategoryService {
  /// Search the propertyCategory matching the id.
  static CustomizedPropertyCategory getPropertyCategoryById(
    List<CustomizedPropertyCategory> propertyCategories,
    PropertyCategoryIds id,
  ) {
    CustomizedPropertyCategory searchedCategory = propertyCategories.first;
    for (CustomizedPropertyCategory category in propertyCategories) {
      if (category.id == id) {
        searchedCategory = category;
        break;
      }
    }
    return searchedCategory;
  }

  /// mergePropertyCategories - Override the [PropertyCategories] with a list
  /// of [CustomizedPropertyCategory] given in parameters.
  /// If the same property is override multiple times, only the first will be
  /// considered.
  /// Returns all the merged categories as [CustomizedPropertyCategory]
  static List<CustomizedPropertyCategory> mergePropertyCategories(
    List<CustomizedPropertyCategory>? customizedPropertyCategories,
    AppLocalizations l10n,
  ) {
    if (customizedPropertyCategories == null ||
        customizedPropertyCategories.isEmpty) {
      return defaultPropertyCategories
          .map((category) => _toCustomizedPropertyCategory(category, l10n))
          .toList();
    }

    List<CustomizedPropertyCategory> mergedCategoriesList = List.empty();

    defaultPropertyCategories.forEach((propertyCategory) {
      // Search if is there a customization for the category.
      CustomizedPropertyCategory? customizedPropertyCategory =
          customizedPropertyCategories.firstWhereOrNull(
        (element) => element.id == propertyCategory.id,
      );

      // If not, add the base property category
      if (customizedPropertyCategory == null) {
        mergedCategoriesList
            .add(_toCustomizedPropertyCategory(propertyCategory, l10n));
      } else {
        // Otherwise, override the base property category parameters with the
        // ones defined in the customized property category.
        mergedCategoriesList.add(_mergePropertyCategories(
          propertyCategory,
          customizedPropertyCategory,
          l10n,
        ));
      }
    });

    return mergedCategoriesList;
  }

  /// Merge the CustomizedPropertyCategory given by the user to the static
  /// PropertyCategory.
  /// Returns a [CustomizedPropertyCategory] instance.
  static CustomizedPropertyCategory _mergePropertyCategories(
    PropertyCategory propertyCategory,
    CustomizedPropertyCategory customizedPropertyCategory,
    AppLocalizations l10n,
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
        .firstWhereOrNull((element) => element.label == defaultValue.label);
    if (defaultValueInThePropertyList == null) {
      throw new ArgumentError(
        "The default value of a category must be in its property list.",
        "defaultValue missing in the properties",
      );
    }

    return CustomizedPropertyCategory(
      id: propertyCategory.id,
      toDisplay: customizedPropertyCategory.toDisplay,
      name:
          customizedPropertyCategory.name ?? propertyCategory.getL10nName(l10n),
      defaultValue: defaultValue,
      iconFile:
          customizedPropertyCategory.iconFile ?? propertyCategory.iconFile,
      properties: properties,
    );
  }

  /// Transform a [PropertyCategory] to a [CustomizedPropertyCategory].
  static CustomizedPropertyCategory _toCustomizedPropertyCategory(
    PropertyCategory propertyCategory,
    AppLocalizations l10n,
  ) {
    return CustomizedPropertyCategory(
      id: propertyCategory.id,
      toDisplay: propertyCategory.toDisplay,
      name: propertyCategory.getL10nName(l10n),
      defaultValue: propertyCategory.defaultValue,
      iconFile: propertyCategory.iconFile,
      properties: propertyCategory.properties,
    );
  }
}
