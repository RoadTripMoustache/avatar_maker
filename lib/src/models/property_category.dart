import 'package:avatar_maker/src/enums/property_category_ids.dart';
import 'package:avatar_maker/src/models/property_item.dart';

class PropertyCategory {
  PropertyCategoryIds get id => PropertyCategoryIds.HairStyle;
  String get name => "";
  String get iconFile => "";
  List<PropertyItem> get properties => List.empty();
  bool get toDisplay => true;
  PropertyItem get defaultValue => PropertyItem();
}
