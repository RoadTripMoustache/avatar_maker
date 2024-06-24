import "package:avatar_maker/l10n/app_localizations.dart";
import "package:avatar_maker/src/core/enums/property_category_ids.dart";
import "package:avatar_maker/src/core/models/property_item.dart";

class PropertyCategory {
  final PropertyCategoryIds id;
  final String Function(AppLocalizations l10n) getL10nName;
  final String iconFile;
  final List<PropertyItem> properties;
  final bool toDisplay;
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
