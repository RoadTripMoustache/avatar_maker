# avatar_maker - 50 additional styles per category

Each category ships **50 distinct shapes**. Colours are *not* baked into the
style variants: for hair, facial hair and outfits the assets reuse the
package's existing colour placeholders, so `HairColor`, `FacialHairColor` and
`OutfitColor` keep working unchanged.

## Files

| Category | Preview SVG | Dart entries | Merge into |
|---|---|---|---|
| Hair | `assets/icons/hair_50.svg` | `lib/src/core/enums/property_items/generated/hair_50.dart` | `property_items/hair_styles.dart` |
| Facial hair | `assets/icons/facial_hair_50.svg` | `lib/src/core/enums/property_items/generated/facial_hair_50.dart` | `property_items/facial_hair_types.dart` |
| Eyebrows | `assets/icons/eyebrows_50.svg` | `lib/src/core/enums/property_items/generated/eyebrows_50.dart` | `property_items/eyebrows.dart` |
| Eyes | `assets/icons/eyes_50.svg` | `lib/src/core/enums/property_items/generated/eyes_50.dart` | `property_items/eyes.dart` |
| Nose | `assets/icons/nose_50.svg` | `lib/src/core/enums/property_items/generated/nose_50.dart` | `property_items/noses.dart` |
| Mouth | `assets/icons/mouth_50.svg` | `lib/src/core/enums/property_items/generated/mouth_50.dart` | `property_items/mouths.dart` |
| Outfit | `assets/icons/outfit_50.svg` | `lib/src/core/enums/property_items/generated/outfit_50.dart` | `property_items/outfit_types.dart` |
| Accessories | `assets/icons/accessories_50.svg` | `lib/src/core/enums/property_items/generated/accessories_50.dart` | `property_items/accessories.dart` |
| Skin | `assets/icons/skin_50.svg` | `lib/src/core/enums/property_items/generated/skin_50.dart` | `property_items/skin_colors.dart` |
| Background | `assets/icons/background_50.svg` | `lib/src/core/enums/property_items/generated/background_50.dart` | `property_items/background_style.dart` |

The Dart files are plain enums that implement `PropertyItem`, so they can be
merged into the built-in enums or exposed as extra categories. They live
under `lib/` so they are importable and testable right away:

```dart
import 'package:avatar_maker/src/core/enums/property_items/generated/hair_50.dart';
```

Open `assets/icons/preview_50.html` in a browser to see all items.

## Coordinate frames

The assets follow the frames the package renders in
(`lib/src/core/services/avatar_service.dart`):

* **Avatar frame** - `264x280`, head centre `x=132`, head top `y=36`,
  ear line `y=110`, jaw `y=181`. Hair and outfits live here.
* **Face frame** - the `<g id="Face" transform="translate(76,82)">` group:
  face centre `x=56`, eyes at `(30,30)` and `(82,30)`, brows `x 11..43` /
  `69..101`, nose `x 44..68`, mouth `x 42..70`. Facial hair, eyebrows, eyes,
  nose, mouth and accessories live here and inherit `fill="#000000"`.
* **Outfit frame** - the outfit group is translated by `(0,170)`.

## Colour placeholders

Hair, facial hair and outfits use the same mechanism as the built-in assets:

```dart
<g id="$TO_REPLACE_WITH_HAIRS_COLOR_NAME" mask="url(#am-hair-mask-1)" fill="$TO_REPLACE_WITH_HAIRS_COLOR">
```

`HairService.generateHairStyle` / `FacialHairsService.generateFacialHair` /
`OutfitService.generateOutfit` already replace both tokens, and
`AvatarService.extractPropertiesFromSvg` can read the selected colour back.

## flutter_svg compatibility

* No `<style>` blocks - every colour is an inline attribute or a
  `fill="..."` on a `<use>`/`<path>`.
* Only `path`, `circle`, `ellipse`, `rect`, `g`, `defs`, `mask`, `use` are
  used, all of which `flutter_svg` supports.
* `xlink:href` is used on `<use>` elements, matching the built-in assets.
