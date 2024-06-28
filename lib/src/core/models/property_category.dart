import "package:avatar_maker/l10n/app_localizations.dart";
import "package:avatar_maker/src/core/enums/property_category_ids.dart";
import "package:avatar_maker/src/core/models/property_item.dart";

/// Represents a property category managed by the library.
class PropertyCategory {
  /// Id of the property category.
  final PropertyCategoryIds id;

  /// Function to define the right localized name to use.
  final String Function(AppLocalizations l10n) getL10nName;

  /// Path to the SVG icon file to use.
  final String iconFile;

  /// List of properties available for this category.
  final List<PropertyItem> properties;

  /// Boolean to know if the category can be updated (if displayed) in the
  /// customizer.
  final bool toDisplay;

  /// Default value for the property category.
  final PropertyItem defaultValue;

  const PropertyCategory({
    required this.id,
    required this.getL10nName,
    required this.iconFile,
    required this.properties,
    required this.toDisplay,
    required this.defaultValue,
  });
}
