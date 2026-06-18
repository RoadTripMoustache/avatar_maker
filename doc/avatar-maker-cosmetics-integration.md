# Avatar Maker — Cosmetic System Documentation

This document describes the cosmetic system added to `avatar_maker`: cosmetic backgrounds, animated effects, separate effect colors, thumbnails, example-level locking, locked-item preview, and save protection.

## Architecture

Cosmetics are regular customizer categories, but their `PropertyItem`s render widgets instead of SVG strings.

```text
CustomizedPropertyCategory
  AvatarBackground
  AvatarEffect
  AvatarEffectColor
        ↓
AvatarMakerController.selectedOptions
        ↓
AvatarMakerAvatar.buildWithCosmetics()
        ↓
background layer → effect layer (behind avatar) → SVG avatar
```

## Public API files

- `lib/src/core/models/cosmetic_property_item.dart`
  - Base class for widget-rendered cosmetics.
  - Extends `PropertyItem` so cosmetics can be used with the existing category/grid/controller architecture.

- `lib/src/core/models/background_cosmetic_item.dart`
  - Gradient cosmetic background item.
  - Supports full-size and thumbnail rendering.

- `lib/src/core/models/effect_cosmetic_item.dart`
  - Built-in animated effect item.
  - Supports `customBuilder` for advanced animations.
  - Uses `EffectCosmeticItemWithColor` when an effect color is selected.

- `lib/src/core/models/effect_color_cosmetic_item.dart`
  - Separate effect color item.
  - Selecting none keeps the effect active and uses the effect's own colors.

- `lib/src/core/enums/effect_type.dart`
  - Enum of all built-in effects.

- `lib/src/customizer/widgets/cosmetic_effect_painter.dart`
  - Main animated `CustomPainter`.
  - Also contains `EffectThumbnailPainter` for type-distinct grid icons.

- `lib/src/customizer/widgets/cosmetic_effect_widget.dart`
  - Animated widget wrapper for effects.

- `lib/src/avatar/avatar_maker_avatar.dart`
  - Renders cosmetics behind the avatar:
    1. cosmetic background
    2. effect
    3. SVG avatar

## Effect types

Current built-in effects:

- `aura`
- `stars`
- `hearts`
- `sparkles`
- `flames`
- `snowflakes`
- `butterflies`
- `birds`
- `bubbles`
- `particles`
- `mist`
- `wavyLines`
- `orbitDots`
- `rotatingRing`
- `abstractShapes`
- `risingBubbles`
- `flyingObjects`
- `pushSymbols`
- `colorWaves`
- `growingVines`
- `networkWeb`
- `infinitySnake`
- `graphNodes`
- `waterDroplets`
- `liquidMetaballs`
- `morphShapes`
- `geometricConstellation`

All animations use `AnimationController.value` from `0.0` to `1.0`. Phase terms are integer-cycle expressions, so the first and last frame match and the loop is seamless.

## Custom effect example

`EffectCosmeticItem.customBuilder` lets an app replace the built-in painter with its own widget/painter.

```dart
EffectCosmeticItem(
  cosmeticId: "custom_rainbow_sweep",
  label: "Custom Rainbow",
  tier: "premium",
  cost: 900,
  effectType: EffectType.colorWaves,
  colors: [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
  ],
  customBuilder: (context, size, colors) {
    return CustomPaint(
      size: Size(size, size),
      painter: CustomRainbowSweepPainter(colors: colors),
    );
  },
);
```

The builder receives:

- `BuildContext`
- available effect `size`
- selected `colors`

When `customBuilder` is provided, it takes precedence over `effectType`.

## Hiding categories

Apps can hide any visual customization category by overriding it with `toDisplay: false`.

```dart
CustomizedPropertyCategory(
  id: PropertyCategoryIds.AvatarEffect,
  name: "Effects",
  iconFile: "assets/icons/effects.svg",
  toDisplay: false,
  properties: [
    NoEffectItem(),
    ...buildAllEffects(),
  ],
);
```

This is useful when a host app wants to provide its own UI or marketplace flow instead of the built-in customizer tabs.

## Rendering rules

### Backgrounds

Backgrounds render as a full circular cosmetic layer behind the avatar.

### Effects

Effects render behind the avatar and are clipped to the avatar bounds.

### Effect colors

Effect color selection is separate from effect type selection:

- No effect color selected → effect uses its built-in colors.
- Effect color selected → effect renders using the selected color.
- Selecting the "None" effect color clears only the color, not the effect.

## Thumbnails

The old implementation used one Material icon for all effect thumbnails, which made different effects hard to distinguish.

The current implementation uses `EffectThumbnailPainter`, a static per-effect `CustomPainter`. Each effect has a unique miniature preview, for example:

- stars → star points
- hearts → hearts
- water droplets → droplets
- liquid metaballs → merged blobs
- graph nodes → node graph
- infinity snake → infinity path
- geometric constellation → diamond, triangle, circle, square

White or near-white colors are mapped to a dark drawing color in thumbnails so the preview remains visible on light backgrounds.

## Placeholder items

Cosmetic categories need a placeholder item because `PropertyCategory` validates that `defaultValue` exists in the category's property list.

Placeholders:

- `NoBackgroundItem`
- `NoEffectItem`
- `NoEffectColorItem`

Important:

- `NoEffectItem.category == "effect"`
- `NoEffectColorItem.category == "effect_color"`

Using `NoEffectItem` in the effect-color category causes selection/deselection bugs.

## Controller behavior

`AvatarMakerController` tracks:

- `_selectedBackgroundCosmetic`
- `_selectedEffectCosmetic`
- `_selectedEffectColorCosmetic`
- `_previewBackgroundCosmetic`
- `_previewEffectCosmetic`
- `_previewEffectColorCosmetic`
- `_previewOptions`

Cosmetic selections are synchronized from `selectedOptions` after:

- initial load
- JSON restore/import
- randomized selection

`selectCosmetic()` updates both the cosmetic field and `selectedOptions`, so grid selection state and avatar rendering stay in sync.

## Locking example

The example app demonstrates level/gold-based locking with the existing `AvatarMakerCustomizer` callbacks:

- `isItemLocked`
- `lockWidget`
- `onTapLockedItem`

Example rules:

- `basic` cosmetics: level 0
- `illustrated` cosmetics: level 3
- `premium` cosmetics: level 6
- expensive `premium` cosmetics, `cost >= 700`: level 8
- glasses: level 5

The lock callback receives `item.id`, which for cosmetics is formatted as:

```text
Cosmetic/<category>/<cosmeticId>
```

The example parses the final segment as `cosmeticId` before looking up the cosmetic item.

The example unlock dialog intentionally uses neutral localized text instead of cosmetic labels or sample prices:

```text
Reach level X to unlock this cosmetic.
```

Labels, prices, currencies, and purchase/unlock flows belong to the host app. The cosmetic item `label` and `cost` fields in the example are demo data only.

The example also previews locked items before they are unlocked. Tapping a locked item opens a dialog with a small preview and two actions:

- `Cancel`: closes the dialog and clears any temporary preview.
- `Preview`: applies the item as a temporary preview, then closes the dialog so the avatar can be seen.

Temporary previews are rendered by the controller without changing `selectedOptions`, so they are not saved or exported.

## Preview and save protection

Locked-item previews are temporary:

- `previewOption(item, category)` previews regular property items.
- `previewCosmetic(cosmeticItem)` previews cosmetic items.
- `clearPreview()` removes the temporary preview.
- Selecting another unlocked item, randomizing, restoring, saving, or disposing the customizer clears the preview.

`AvatarMakerSaveWidget` is disabled while a preview is active. `saveAvatarSVG()` also clears previews before persisting, so preview-only selections cannot be saved.

## Integration checklist

When integrating cosmetics in an app:

1. Add customized categories for:
   - `PropertyCategoryIds.AvatarBackground`
   - `PropertyCategoryIds.AvatarEffect`
   - `PropertyCategoryIds.AvatarEffectColor`

2. Include placeholders in each category:
   - `NoBackgroundItem()`
   - `NoEffectItem()`
   - `NoEffectColorItem()`

3. Use `AvatarMakerAvatar` normally. It automatically reads selected cosmetics from the controller.

4. Use `AvatarMakerCustomizer` for selection UI.

5. Use `isItemLocked` to lock cosmetics by tier, cost, ownership, or level.

6. Use `onTapLockedItem` to show purchase or unlock messaging.
7. Use `previewOption` or `previewCosmetic` if locked items should be previewed before unlock.
8. Remember that temporary previews are not saved; `saveAvatarSVG()` clears previews before persisting.

## Verification commands

```bash
flutter analyze lib/ example/
flutter test test/src/core/
```

Run the example app:

```bash
cd example
flutter run -d chrome
```

## PR checklist

- [x] Custom effect builder is documented and demonstrated
- [x] Categories can be hidden with `toDisplay: false`
- [x] Cosmetic categories render in the customizer
- [x] Avatar renders background and effects behind the avatar
- [x] Effect type and effect color are separate selections
- [x] Effect color "none" clears only the color
- [x] Effects loop seamlessly
- [x] Each effect has a distinct thumbnail
- [x] White/near-white thumbnails remain visible
- [x] Example includes level/gold locking
- [x] Locked items can be previewed without saving
- [x] Save is protected while preview is active
- [x] Effect color tab has a distinct icon
- [x] `flutter analyze lib/ example/` passes
- [x] Core tests pass
