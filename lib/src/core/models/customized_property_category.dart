import "package:avatar_maker/src/core/enums/property_category_ids.dart";
import "package:avatar_maker/src/core/models/property_item.dart";

/// Class to use by users to customize a category.
class CustomizedPropertyCategory {
  /// Id of the property to customize. It can't be a new id.
  final PropertyCategoryIds id;
  /// Name of the category to display. If a name is override by the user, the
  /// localization must be managed by the user for this category.
  final String? name;
  /// Path to the svg icon file to use for the category.
  final String? iconFile;
  /// List of properties to set for the category.
  final List<PropertyItem>? properties;
  /// Boolean to know if a category must be displayed or not. Default = true
  final bool toDisplay;
  /// Default value to use for this category. If the category is not displayed
  /// (so can't be updated), the default value will be the one used for all
  /// the users.
  final PropertyItem? defaultValue;

  const CustomizedPropertyCategory({
    required this.id,
    this.name,
    this.iconFile,
    this.properties = null,
    this.toDisplay = true,
    this.defaultValue,
  });
}
