import "package:avatar_maker/src/enums/property_category_ids.dart";
import "package:avatar_maker/src/models/property_item.dart";

class CustomizedPropertyCategory {
  final PropertyCategoryIds id;
  final String? name;
  final String? iconFile;
  final List<PropertyItem>? properties;
  final bool toDisplay;
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
