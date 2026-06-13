import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
    Locale('tr')
  ];

  /// No description provided for @property_category_accessories.
  ///
  /// In en, this message translates to:
  /// **'Accessories'**
  String get property_category_accessories;

  /// No description provided for @property_category_backgrounds.
  ///
  /// In en, this message translates to:
  /// **'Backgrounds'**
  String get property_category_backgrounds;

  /// No description provided for @property_category_effects.
  ///
  /// In en, this message translates to:
  /// **'Effects'**
  String get property_category_effects;

  /// No description provided for @property_category_effect_colors.
  ///
  /// In en, this message translates to:
  /// **'Effect Colors'**
  String get property_category_effect_colors;

  /// No description provided for @unlock_cosmetic_level.
  ///
  /// In en, this message translates to:
  /// **'Reach level {level} to unlock this cosmetic.'**
  String unlock_cosmetic_level(int level);

  /// No description provided for @property_category_eyes.
  ///
  /// In en, this message translates to:
  /// **'Eyes'**
  String get property_category_eyes;

  /// No description provided for @property_category_eyebrows.
  ///
  /// In en, this message translates to:
  /// **'Eyebrows'**
  String get property_category_eyebrows;

  /// No description provided for @property_category_facial_hair_colors.
  ///
  /// In en, this message translates to:
  /// **'Facial Hair Colors'**
  String get property_category_facial_hair_colors;

  /// No description provided for @property_category_facial_hair_types.
  ///
  /// In en, this message translates to:
  /// **'Facial Hairs'**
  String get property_category_facial_hair_types;

  /// No description provided for @property_category_hair_colors.
  ///
  /// In en, this message translates to:
  /// **'Hair Colors'**
  String get property_category_hair_colors;

  /// No description provided for @property_category_hairstyles.
  ///
  /// In en, this message translates to:
  /// **'Hairstyles'**
  String get property_category_hairstyles;

  /// No description provided for @property_category_mouths.
  ///
  /// In en, this message translates to:
  /// **'Mouths'**
  String get property_category_mouths;

  /// No description provided for @property_category_noses.
  ///
  /// In en, this message translates to:
  /// **'Noses'**
  String get property_category_noses;

  /// No description provided for @property_category_outfit_colors.
  ///
  /// In en, this message translates to:
  /// **'Outfit Colors'**
  String get property_category_outfit_colors;

  /// No description provided for @property_category_outfit_types.
  ///
  /// In en, this message translates to:
  /// **'Outfits'**
  String get property_category_outfit_types;

  /// No description provided for @property_category_skins.
  ///
  /// In en, this message translates to:
  /// **'Skins'**
  String get property_category_skins;

  /// No description provided for @item_none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get item_none;

  /// No description provided for @item_skin_tanned.
  ///
  /// In en, this message translates to:
  /// **'Tanned'**
  String get item_skin_tanned;

  /// No description provided for @item_skin_yellow.
  ///
  /// In en, this message translates to:
  /// **'Yellow'**
  String get item_skin_yellow;

  /// No description provided for @item_skin_white.
  ///
  /// In en, this message translates to:
  /// **'White'**
  String get item_skin_white;

  /// No description provided for @item_skin_peach.
  ///
  /// In en, this message translates to:
  /// **'Peach'**
  String get item_skin_peach;

  /// No description provided for @item_skin_brown.
  ///
  /// In en, this message translates to:
  /// **'Brown'**
  String get item_skin_brown;

  /// No description provided for @item_skin_dark_brown.
  ///
  /// In en, this message translates to:
  /// **'Dark Brown'**
  String get item_skin_dark_brown;

  /// No description provided for @item_skin_black.
  ///
  /// In en, this message translates to:
  /// **'Black'**
  String get item_skin_black;

  /// No description provided for @item_outfit_blazer_t_shirt.
  ///
  /// In en, this message translates to:
  /// **'Blazer T-Shirt'**
  String get item_outfit_blazer_t_shirt;

  /// No description provided for @item_outfit_blazer_sweater.
  ///
  /// In en, this message translates to:
  /// **'Blazer Sweater'**
  String get item_outfit_blazer_sweater;

  /// No description provided for @item_outfit_collar_sweater.
  ///
  /// In en, this message translates to:
  /// **'Collar Sweater'**
  String get item_outfit_collar_sweater;

  /// No description provided for @item_outfit_graphic_shirt.
  ///
  /// In en, this message translates to:
  /// **'Graphic Shirt'**
  String get item_outfit_graphic_shirt;

  /// No description provided for @item_outfit_hoodie.
  ///
  /// In en, this message translates to:
  /// **'Hoodie'**
  String get item_outfit_hoodie;

  /// No description provided for @item_outfit_overall.
  ///
  /// In en, this message translates to:
  /// **'Overall'**
  String get item_outfit_overall;

  /// No description provided for @item_outfit_shirt_crew_neck.
  ///
  /// In en, this message translates to:
  /// **'Crew Neck Shirt'**
  String get item_outfit_shirt_crew_neck;

  /// No description provided for @item_outfit_shirt_scoop_neck.
  ///
  /// In en, this message translates to:
  /// **'Scoop Neck Shirt'**
  String get item_outfit_shirt_scoop_neck;

  /// No description provided for @item_outfit_shirt_v_neck.
  ///
  /// In en, this message translates to:
  /// **'V-Neck Shirt'**
  String get item_outfit_shirt_v_neck;

  /// No description provided for @item_hair_auburn.
  ///
  /// In en, this message translates to:
  /// **'Auburn'**
  String get item_hair_auburn;

  /// No description provided for @item_hair_black.
  ///
  /// In en, this message translates to:
  /// **'Black'**
  String get item_hair_black;

  /// No description provided for @item_hair_blonde.
  ///
  /// In en, this message translates to:
  /// **'Blonde'**
  String get item_hair_blonde;

  /// No description provided for @item_hair_blonde_golden.
  ///
  /// In en, this message translates to:
  /// **'Blonde Golden'**
  String get item_hair_blonde_golden;

  /// No description provided for @item_hair_brown.
  ///
  /// In en, this message translates to:
  /// **'Brown'**
  String get item_hair_brown;

  /// No description provided for @item_hair_brown_dark.
  ///
  /// In en, this message translates to:
  /// **'Dark Brown'**
  String get item_hair_brown_dark;

  /// No description provided for @item_hair_pastel_pink.
  ///
  /// In en, this message translates to:
  /// **'Pastel Pink'**
  String get item_hair_pastel_pink;

  /// No description provided for @item_hair_platinum.
  ///
  /// In en, this message translates to:
  /// **'Platinum'**
  String get item_hair_platinum;

  /// No description provided for @item_hair_red.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get item_hair_red;

  /// No description provided for @item_hair_silver.
  ///
  /// In en, this message translates to:
  /// **'Silver'**
  String get item_hair_silver;

  /// No description provided for @item_eye_blue.
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get item_eye_blue;

  /// No description provided for @item_eye_brown.
  ///
  /// In en, this message translates to:
  /// **'Brown'**
  String get item_eye_brown;

  /// No description provided for @item_eye_green.
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get item_eye_green;

  /// No description provided for @item_eye_grey.
  ///
  /// In en, this message translates to:
  /// **'Grey'**
  String get item_eye_grey;

  /// No description provided for @item_eye_hazel.
  ///
  /// In en, this message translates to:
  /// **'Hazel'**
  String get item_eye_hazel;

  /// No description provided for @item_eye_red.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get item_eye_red;

  /// No description provided for @item_eye_black.
  ///
  /// In en, this message translates to:
  /// **'Black'**
  String get item_eye_black;

  /// No description provided for @item_accessory_glasses.
  ///
  /// In en, this message translates to:
  /// **'Glasses'**
  String get item_accessory_glasses;

  /// No description provided for @item_accessory_sunglasses.
  ///
  /// In en, this message translates to:
  /// **'Sunglasses'**
  String get item_accessory_sunglasses;

  /// No description provided for @item_accessory_headphones.
  ///
  /// In en, this message translates to:
  /// **'Headphones'**
  String get item_accessory_headphones;

  /// No description provided for @item_facial_hair_beard.
  ///
  /// In en, this message translates to:
  /// **'Beard'**
  String get item_facial_hair_beard;

  /// No description provided for @item_facial_hair_mustache.
  ///
  /// In en, this message translates to:
  /// **'Mustache'**
  String get item_facial_hair_mustache;

  /// No description provided for @item_facial_hair_goatee.
  ///
  /// In en, this message translates to:
  /// **'Goatee'**
  String get item_facial_hair_goatee;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
