import io, os

DOC = '''# avatar_maker - extended style packs

Every category now offers **50+ styles**. The new items are distinct shapes,
not recolours of one another: the silhouette, the hairline, the fringe and the
extra volumes all differ.

The hair / facial hair / outfit packs reuse the package's existing colour
placeholders (`TO_REPLACE_WITH_HAIRS_COLOR`,
`TO_REPLACE_WITH_FACIAL_HAIRS_COLOR`, `TO_REPLACE_WITH_OUTFIT_COLOR`), so the
`HairColor`, `FacialHairColor` and `OutfitColor` categories keep working
unchanged - a hair style is a shape, the colour is picked separately.

## Item counts

| Category | Before | After | Merge target |
|---|---|---|---|
| Hair styles | 49 | 107 | `property_items/hair_styles.dart` |
| Facial hair types | 19 | 81 | `property_items/facial_hair_types.dart` |
| Eyebrows | 30 | 74 | `property_items/eyebrows.dart` |
| Eyes | 30 | 74 | `property_items/eyes.dart` |
| Noses | 20 | 57 | `property_items/noses.dart` |
| Mouths | 31 | 68 | `property_items/mouths.dart` |
| Outfit types | 24 | 75 | `property_items/outfit_types.dart` |
| Accessories | 39 | 89 | `property_items/accessories.dart` |
| Skin colours | 28 | 66 | `property_items/skin_colors.dart` |
| Background styles | 2 | 51 | `property_items/background_style.dart` |
| **Total** | **272** | **742** | |

The new items are part of the built-in enums, so they show up in the real
customizer without any extra wiring - `HairStyles.values` now has 107 entries.

## Preview

`assets/icons/preview_50.html` renders every item on a full avatar, composed
with the package's own `AvatarService.drawSVG`. Open it in a browser.

The standalone SVG packs are next to it:

| File | Category |
|---|---|
| `assets/icons/hair_50.svg` | hair styles |
| `assets/icons/facial_hair_50.svg` | facial hair types |
| `assets/icons/eyebrows_50.svg` | eyebrows |
| `assets/icons/eyes_50.svg` | eyes |
| `assets/icons/nose_50.svg` | noses |
| `assets/icons/mouth_50.svg` | mouths |
| `assets/icons/outfit_50.svg` | outfits |
| `assets/icons/accessories_50.svg` | accessories |
| `assets/icons/skin_50.svg` | skin colours |
| `assets/icons/background_50.svg` | backgrounds |

## Coordinate frames

The assets follow the frames the package renders in
(`lib/src/core/services/avatar_service.dart`):

* **Avatar frame** - `264x280`. The head silhouette (`path-5`) is drawn inside
  `<g id="Body" transform="translate(32,36)">`, so in avatar coordinates the
  skull top is at `y=36`, the head spans `x 66..198` and the chin is at
  `y=181`. Hair and outfits live in this frame.
* **Face frame** - the `<g id="Face" transform="translate(76,82)" fill="#000000">`
  group: face centre `x=56`, eyes at `(30,30)` and `(82,30)`, brows `x 11..43` /
  `69..101`, nose `x 44..68`, mouth `x 42..70` `y 70..82`, chin at `y=99`.
  Facial hair, eyebrows, eyes, nose, mouth and accessories live here.
* **Outfit frame** - the outfit group is translated by `(0,170)`, so the torso
  spans `x 32..232` in a `264x110` band, with the neck opening at
  `x 104..160`.

## Colour placeholders

Hair, facial hair and outfits use the same mechanism as the built-in assets:

```dart
<g id="$TO_REPLACE_WITH_HAIRS_COLOR_NAME" fill="$TO_REPLACE_WITH_HAIRS_COLOR" fill-rule="evenodd">
```

`HairService.generateHairStyle` / `FacialHairsService.generateFacialHair` /
`OutfitService.generateOutfit` already replace both tokens, and
`AvatarService.extractPropertiesFromSvg` can read the selected colour back.

## flutter_svg compatibility

* No `<style>` blocks - every colour is an inline attribute, so the assets
  render with `flutter_svg` (a `<style>` element is unsupported and would
  leave the shapes uncoloured).
* Only `path`, `circle`, `ellipse`, `rect`, `g`, `defs`, `mask`, `use` are
  used, all of which `flutter_svg` supports.
* `xlink:href` is used on `<use>` elements, matching the built-in assets.

## Tests

`test/generated_assets_test.dart` checks that every category offers at least
50 styles, that the ids are unique, that the colour placeholders resolve, that
no style contains a `<style>` element and that every style is a well-formed
SVG fragment.

```bash
flutter test test/generated_assets_test.dart
```

## Regenerating

`contrib/generator/` holds the Python generator that produced the packs:

```bash
cd contrib/generator
python build_packs.py          # writes the SVG packs and the Dart entries
python merge_into_enums.py     # merges the Dart entries into the built-in enums
python merge_background.py     # the background enum has a different layout
python make_preview.py         # writes assets/icons/preview_50.html
python count_items.py          # prints the item count per category
```

`contrib/backup/` keeps a copy of the enum files as they were before the
merge.
'''

path = r'C:\Projeler\avatar_maker\contrib\README.md'
io.open(path, 'w', encoding='utf-8', newline='\n').write(DOC)
print('written', path, os.path.getsize(path))
