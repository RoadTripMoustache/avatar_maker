import "package:avatar_maker/src/core/enums/property_category_ids.dart";
import "package:avatar_maker/src/core/models/property_item.dart";

class PropertyCategory {
  PropertyCategoryIds get id => PropertyCategoryIds.HairStyle;
  String get name => "";
  String get iconFile => "";
  List<PropertyItem> get properties => List.empty();
  bool get toDisplay => true;
  PropertyItem get defaultValue => PropertyItem();
}
