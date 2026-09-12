## [Unreleased]
### Added
- feat: Add 4 hair styles: `Mohawk`, `Ponytail`, `TopKnot` and `Curtains`
- feat: Add 4 facial hair types: `Goatee`, `SoulPatch`, `MuttonChops` and `MoustacheHandlebar`, tripling the choice in the thinnest category
- feat: Add 8 hair colors, and the same 8 facial hair colors: `Copper`, `Chestnut`, `Burgundy`, `Ginger`, `White`, `Teal`, `Mint` and `Lavender`
- feat: Add 8 outfit colors: `Teal`, `Mint`, `Lavender`, `Burgundy`, `Mustard`, `Cream`, `Charcoal` and `Coral`
- feat: Add 8 eyes: `Stars`, `Sleepy`, `Wide`, `Sparkle`, `Determined`, `Shy`, `Anime` and `Worried`
- feat: Add 7 eyebrows: `Bushy`, `Wavy`, `Thin`, `Sharp`, `Rounded`, `Pierced` and `Notched`
- feat: Add 9 mouths: `Whistle`, `Smirk`, `Kiss`, `Grin`, `Pout`, `Zigzag`, `Braces`, `Gap` and `Sneer`
- feat: Add 9 noses: `Button`, `Wide`, `Small`, `Nostrils`, `Hooked`, `Upturned`, `Pointed`, `Bulbous` and `Roman`. The category ships with `toDisplay: false` because it had a single option; with ten it may be worth showing by default
- feat: Add 22 accessories, which are no longer only eyewear: an eye patch, a monocle, a face mask, heart and star glasses, aviators, ski goggles, a sleep mask, a cyber visor, a bandana, earrings, freckles, blush, a plaster, war paint, a clown nose, a sweat drop, stubble, a septum ring, a scar, tears and a beauty spot
- feat: Add 11 skin tones: `Porcelain`, `Almond`, `Olive`, `Sienna` and `Espresso` fill out the realistic ramp, and `Stone`, `Mint`, `Lilac`, `Rose`, `Azure` and `Fern` sit after it

- feat: Add 5 outfits: `TankTop`, `Turtleneck`, `ShirtAndTie`, `DenimJacket` and `Jersey`
- feat: Add a further 10 of each: hair styles, facial hair types, outfits, eyes, eyebrows, mouths, noses, accessories, skin tones, hair colors, facial hair colors and outfit colors
- feat: Add Swedish (sv) localization with a complete set of translation strings
- feat: Show the `Nose` category by default. It carried `toDisplay: false` while it had a single option; it now has ten

### Updated
- fix: `PropertyItemLocalization` falls back to the item's own label for skin tones that have no l10n key yet, the way every unlocalized category already does
- fix: The customizer's option tiles announce the item's own localized name to screen readers. Every tile used to announce the same hardcoded English phrase, which left `localizedLabel` and all of its translations unused

---

## [1.8.0] - 23/08/2026
### Added
- feat: Add Persian (Farsi) localization support with complete translation strings
- feat: Add independent `width` and `height` parameters to `AvatarMakerAvatar` for flexible container sizing
- feat: Add independent `svgWidth` and `svgHeight` parameters to `AvatarMakerAvatar` for precise SVG rendering control
- feat: Add `svgPadding` parameter to `AvatarMakerAvatar` for custom padding around the avatar
- feat: Add `border` parameter to `AvatarMakerAvatar` for custom border styling

### Updated
- refactor: Update localization lookup to properly support Persian (fa) as a supported locale

## [1.7.0] - 21/06/2026
### Added
- feat: Add `onItemSelected` callback to `AvatarMakerCustomizer` so consumers can observe unlocked item taps (e.g. for preview-then-apply flows). The selection is still applied immediately by default.
- feat: `EffectCosmeticItem.buildWidget` accepts an optional `overrideColors` parameter so the chosen effect color is forwarded to `customBuilder`.
- chore: Add test coverage threshold enforcement to CI workflow (default 100%).

### Fixed
- fix: `EffectCosmeticItemWithColor` now respects `EffectCosmeticItem.customBuilder` when an `EffectColorCosmeticItem` is selected. Previously, custom effects were silently replaced with the built-in `CosmeticEffectWidget` whenever an effect color was active.
- fix: `PersistentAvatarMakerController.setJsonOptions` now accepts the base `AvatarMakerController` type instead of requiring the `PersistentAvatarMakerController` subtype. This removes the type-mismatch footgun between `AvatarMakerControllerProvider` (which exposes the base type) and the static helper.

### Deprecated
- chore: `BackgroundStyles` enum is now `@Deprecated`. Use `BackgroundCosmeticItem` instead. The enum will be removed in v2.0.0. No runtime behaviour change.

### Tests
- test: Add unit tests for `EffectCosmeticItem.buildWidget` `overrideColors` propagation and `EffectCosmeticItemWithColor` customBuilder delegation.
- test: Add integration tests in `AvatarMakerAvatar` for the custom-effect + effect-color scenario.
- test: Add type-signature tests for the widened `setJsonOptions`.
- test: Add callback tests for `AvatarMakerCustomizer.onItemSelected` (fires, propagates correct args, skips locked items, backward compatible).
- test: Add a static source-level test guarding the `@Deprecated` annotation on `BackgroundStyles`.


## [1.6.0] - 18/06/2026
### Added
- feat: Add `onItemSelected` callback to `AvatarMakerCustomizer` so consumers can observe unlocked item taps (e.g. for preview-then-apply flows). The selection is still applied immediately by default.

### Tests
- feat: Add temporary locked-item preview support without mutating saved selections.
- feat: Disable `AvatarMakerSaveWidget` while a temporary preview is active.
- feat: Add `usePreview` parameter to `AvatarMakerAvatar` (default `true`) so avatars that live outside the customizer context can opt out of rendering the controller's temporary preview state. When set to `false`, the avatar always reflects the saved selection even if a preview is active on the controller.
- docs: Add cosmetic system integration documentation.
- example: Demonstrate cosmetic categories, animated effects, effect colors, custom effects, level/gold locking, and locked-item preview.
- example: Set `usePreview: false` on the home page avatar so locked-item previews activated inside the customizer do not leak onto the home screen.
- test: Update tests and mocks for cosmetic categories, localization, and save-widget preview guard.
- test: Cover `AvatarMakerAvatar` `usePreview: true` (default) and `usePreview: false` rendering behavior.

### Updated
- refactor: Remove direct `material_symbols_icons` dependency and use Material `Icons` in tests.
- chore: Prepare version bump from `1.5.0` to `1.6.0` for the cosmetic system release.


## [1.5.0] - 06/12/2025
### Added
- chore: Unit tests for services

### Update
- refactor: Update color enums (`facial_hair_colors.dart`, `hair_colors.dart`, `outfit_colors.dart`, `skin_colors.dart`) to use unique `itemId` patterns (e.g., `FacialHairColor/Auburn`) instead of shared IDs for improved `isItemLocked` filtering/logging.


## [1.4.0] - 01/12/2025
### Added
- feat: Added `lockWidget` to `AvatarMakerCustomizer` to allow custom widgets for locked items.
- feat: Added `onTapLockedItem` callback to `AvatarMakerCustomizer` to handle taps on locked items.
- docs: Updated documentation for item locking.
- example: Updated example app to demonstrate custom lock UI and interaction.


## [1.3.1] - 29/11/2025
### Fixed
- fix: Example application
- fix: Components size


## [1.3.0] - 29/11/2025
### Added
- feat: Added locked items support. This feature introduces the ability to lock avatar customization items based on specific conditions (e.g., user level, premium membership, etc)
- docs: Update documentation about locked items

### Updated
- refactor: Remove deprecated `withOpacity` method calls

## [1.2.0] - 21/11/2025
### Added
- chore: Update lib versions
- doc: Update documentation about property categories
- feat: Add `isPersistentController` method in the controller to let some widgets know if they must be displayed or not. (Like save or reset button in with a non persistant controller)

### Updated
- chore: Update example bootstrapping to a not deprecated solution


## [1.1.0] - 27/06/2025
### Breaking Changes
- feat: move away from `getX` to `provider` for state management, introducing `AvatarMakerControllerProvider`. You will need to wrap your app with `AvatarMakerControllerProvider` to use the new architecture.
- refactor: update the IDs of each SVG part to allow faster parsing. Existing avatar will be discarded.

### Added
- feat: introduce `AvatarMakerController` to allow creating your own controller
- feat: introduce `NonPersistentAvatarMakerController` for cases where you don't need the package to persist the avatar
- test: improve tests

### Updated
- feat: update the architecture of each widget to allow injecting a custom controller
- refactor: rename `AvatarMakerController` to `PersistentAvatarMakerController`

## [0.3.0] - 26/05/2025
### Added
- ci: Improve github action pipelines

## [0.2.1] - 25/05/2025
### Added
- Bump dependencies to latest versions

## [0.2.0] - 08/07/2024
### Added 
- Add a reset button [#15](https://github.com/RoadTripMoustache/avatar_maker/issues/15)
- Add a randomizer button [#16](https://github.com/RoadTripMoustache/avatar_maker/issues/14)

### Fixed
- Example configurations
- README

## [0.1.0] - 30/06/2024
### Added
- New colors for facial hairs, hairs & outfits
- Documentation
  - [tooling - peanut](./docs/tooling/peanut.md)
  - [tooling - l10n](./docs/tooling/l10n.md)
  - [How to define a custom theme ?](./docs/how-to/define_custom_theme.md)
  - [How to customize property category ?](./docs/how-to/define_customized_property_category.md)
  - [How to support a new language ?](./docs/how-to/support_new_language.md)
- Localization
  - English
  - French
- Add customization of categories and properties
- Unit tests

### Updated
- Refactor and reorganize the code to match with RoadTripMoustache standards ([#9](https://github.com/RoadTripMoustache/avatar_maker/issues/9))
- Documentation
  - README.md
- Update dependencies

---
# Fluttermoji legacy CHANGELOG
## [1.0.2] - 26/03/2023
 * Upgrades dependencies

## [1.0.1] - 25/10/2022
 * Minor bug fix [#22](https://github.com/psk907/fluttermoji/pull/22#issue-1250729612)

## [1.0.0] - 15/02/2022
 * Adds `FluttermojiThemeData` and `FluttermojiSaveWidget` to the library.
 * Fixes some visual glithes in the appbar of the `FluttermojiCustomizer`.
 * Minor internal refactoring.
 * Updates dependency versions
 * BREAKING CHANGES 
   *  The customizer widget no longer has the top row with "Customize" and the save button, and the `showSaveWidget` property has been removed.
   *  The widget's do not set to Material light/dark system theme automatically anymore. This must be implemented using the [theme] property.
   *  Refer the doc comments for more details.

*****

## [0.2.3] - 03/12/2021

 * Updates dependency versions

## [0.2.2] - 11/10/2021

 * Adds toggle to show/hide save button widget in `FluttermojiCustomizer` widget.
  
## [0.2.1] - 03/05/2021

 * Fixes bug where preview and avatars don't revert to saved version after unsaved edits
 * Adds `clearFluttermoji()` to FluttermojiFunctions
 * Some optimizations

## [0.2.0] - 08/04/2021

 * Updates dependencies to their null-safe stable version
 * Migrates package to Null safety
 * Removes dead code

## [0.2.0-nullsafety.0] - 10/03/2021

 * Updated dependencies to their null-safe version
 * Migrated package to Null safety
 * Remove dead code

## [0.1.2+1] - 30/01/2021

 * (Hotfix) Cleared some lints for a cleaner code

## [0.1.2] - 19/01/2021

 * Fixed a bug in decodeFluttermojifromString()

## [0.1.1] - 01/01/2021

 * Added Material Dark theme support to FluttermojiCircleAvatar
 * Added screenshots to the README.md

## [0.1.0] - 24/12/2020

* Added documentation to many APIs and to the README.md as well.
* Created new utility functions to allow sharing of Fluttermojis to server/DB and decoding them for render using flutter_svg package.
* Fixed the bug on loading Fluttermoji on first launch.
* Fixed standalone customizer issues.
* Description updates
* Other minor changes and fixes.


## [0.0.1] - 23/12/2020

* Initial Release - documentation and instructions pending
