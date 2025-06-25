import "package:avatar_maker/src/core/controllers/avatar_maker_controller.dart";
import "package:avatar_maker/src/core/enums/property_category_ids.dart";
import "package:avatar_maker/src/core/models/customized_property_category.dart";
import "package:avatar_maker/src/core/models/property_item.dart";
import "package:flutter/material.dart";

/// Non-persistent implementation of the Avatar Maker controller
///
/// This controller provides all the functionality of the avatar maker
/// without persisting any data. It's useful for scenarios where persistence
/// is not needed or is handled externally.
class NonPersistentAvatarMakerController extends AvatarMakerController {
  /// In-memory storage for the SVG
  String _storedSVG = "";

  NonPersistentAvatarMakerController({
    List<CustomizedPropertyCategory>? customizedPropertyCategories,
    Map<PropertyCategoryIds, PropertyItem>? selectedOptions,
    Locale? locale,
  }) : super(
          customizedPropertyCategories: customizedPropertyCategories,
          selectedOptions: selectedOptions,
          locale: locale,
        );

  NonPersistentAvatarMakerController.fromSvg(
      {required String svg,
      List<CustomizedPropertyCategory>? customizedPropertyCategories,
      Locale? locale})
      : super.fromSvg(
            svg: svg,
            customizedPropertyCategories: customizedPropertyCategories,
            locale: locale);

  /// Get the selected options from memory or use defaults
  @override
  Future<Map<PropertyCategoryIds, PropertyItem>> getSelectedOptions() async {
    // If no options are selected yet, use the default options
    if (selectedOptions.isEmpty) {
      selectedOptions = Map.from(defaultSelectedOptions);
    }
    return selectedOptions;
  }

  /// Perform the save operation without persistence
  /// This implementation just updates the in-memory SVG
  @override
  Future<void> performSave() async {
    // Store the SVG in memory only
    _storedSVG = drawAvatarSVG();
  }

  /// Perform the restore operation without persistence
  /// This implementation just returns the current state
  @override
  Future<RestoredData> performRestore() async {
    // Use the stored SVG if available, otherwise generate a new one
    String svg = _storedSVG.isNotEmpty ? _storedSVG : drawAvatarSVG();

    // Return the current options
    return RestoredData(svg: svg, options: selectedOptions);
  }

  /// Set selected options from a list
  ///
  /// This method allows setting the selected options directly from a list,
  /// which is useful when the options are provided externally.
  void setSelectedOptionsFromList(
      Map<PropertyCategoryIds, PropertyItem> options) {
    selectedOptions = options;
    updatePreview();
  }
}
