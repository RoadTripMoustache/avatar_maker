import "package:avatar_maker/src/core/controllers/avatar_maker_controller.dart";
import "package:avatar_maker/src/core/enums/preferences_label.dart";
import "package:avatar_maker/src/core/enums/property_category_ids.dart";
import "package:avatar_maker/src/core/models/customized_property_category.dart";
import "package:avatar_maker/src/core/models/property_item.dart";
import "package:avatar_maker/src/core/services/options_service.dart";
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

/// Brains of the Avatar_Maker package with persistence capabilities
///
/// Built using the ChangeNotifier architecture to allow the two widgets to easily
/// communicate with each other. This controller persists data in SharedPreferences.
class PersistentAvatarMakerController extends AvatarMakerController {
  PersistentAvatarMakerController({
    List<CustomizedPropertyCategory>? customizedPropertyCategories,
    Locale? locale,
  }) : super(
          customizedPropertyCategories: customizedPropertyCategories,
          locale: locale,
        );

  /// Get the current stored options from the shared preferences, or set the
  /// options with the default values if no options where stored.
  @override
  Future<Map<PropertyCategoryIds, PropertyItem>> getSelectedOptions() async {
    return await getStoredOptions();
  }

  /// Get the current stored options from the shared preferences, or set the
  /// options with the default values if no options where stored.
  Future<Map<PropertyCategoryIds, PropertyItem>> getStoredOptions() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? _avatarMakerOptions =
        pref.getString(PreferencesLabel.avatarMakerSelectedOptions.name);

    if (_avatarMakerOptions == null || _avatarMakerOptions.isEmpty) {
      Map<PropertyCategoryIds, PropertyItem> _avatarMakerOptionsMap = {};
      _avatarMakerOptionsMap.addAll(defaultSelectedOptions);

      await pref.setString(PreferencesLabel.avatarMakerSelectedOptions.name,
          OptionsService.jsonEncodeSelectedOptions(_avatarMakerOptionsMap));
      selectedOptions = _avatarMakerOptionsMap;
    } else {
      selectedOptions = OptionsService.jsonDecodeSelectedOptions(
          this.propertyCategories, _avatarMakerOptions);
    }
    notifyListeners();
    return selectedOptions;
  }

  /// Perform the save operation by storing data in SharedPreferences
  @override
  Future<void> performSave() async {
    // Update selectedOptions stored
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(
      PreferencesLabel.avatarMakerSelectedOptions.name,
      OptionsService.jsonEncodeSelectedOptions(selectedOptions),
    );

    // Get the SVG to display and store
    final String avatarSVG = drawAvatarSVG();
    await pref.setString(PreferencesLabel.avatarMakerSVG.name, avatarSVG);
  }

  /// Perform the restore operation by retrieving data from SharedPreferences
  @override
  Future<RestoredData> performRestore() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    // Get the SVG from preferences or use default
    String svg = pref.getString(PreferencesLabel.avatarMakerSVG.name) ??
        OptionsService.jsonEncodeSelectedOptions(defaultSelectedOptions);

    // Get the options
    Map<PropertyCategoryIds, PropertyItem> options = await getStoredOptions();

    return RestoredData(svg: svg, options: options);
  }

  /// Erase AvatarMaker user's preferences from local storage
  static Future<List<bool>> clearAvatarMaker() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return Future.wait([
      pref.remove(PreferencesLabel.avatarMakerSelectedOptions.name),
      pref.remove(PreferencesLabel.avatarMakerSVG.name),
    ]);
  }

  /// Extract the selected options to JSON for an external save.
  ///
  /// Method made to simplify actions from library users.
  static Future<String> getJsonOptions() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.get(PreferencesLabel.avatarMakerSelectedOptions.name) as String;
  }

  /// Import the given options in a JSON format to the controller.
  ///
  /// Method made to simplify actions from library users.
  /// 
  /// [controller] - The AvatarMakerController instance to use
  static void setJsonOptions(String jsonAvatarOptions, {required PersistentAvatarMakerController controller}) {
    controller.saveAvatarSVG(jsonAvatarOptions: jsonAvatarOptions);
  }

  /// Extract the current avatar SVG for an external save.
  ///
  /// Method made to simplify actions from library users.
  static Future<String> getAvatarSVG() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.get(PreferencesLabel.avatarMakerSVG.name) as String;
  }
}
