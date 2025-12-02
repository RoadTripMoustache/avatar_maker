# Property Categories and Items Reference

This document lists all possible `PropertyCategoryIds` and their corresponding `itemId` values used in the `isItemLocked` callback:

```dart
final bool Function(PropertyCategoryIds categoryId, String itemId)? isItemLocked;
```
in [`lib/src/customizer/avatar_maker_customizer.dart`](lib/src/customizer/avatar_maker_customizer.dart:45-46).

`itemId` follows the pattern `"CategoryName/EnumValueName"` (e.g., `"Accessories/Nothing"`).

**Quick JSON Reference** (copy-paste for `isItemLocked` examples/validation).

Updated on 02/12/2025
```json
{
  "PropertyCategoryIds": {
    "Accessory": ["Accessories/Nothing", "Accessories/Kurt", "Accessories/Glasses", "Accessories/PrescriptionGlasses", "Accessories/Round", "Accessories/Sunglasses", "Accessories/Wayfarers"],
    "Background": ["BackgroundStyles/Transparent", "BackgroundStyles/Circle"],
    "EyebrowType": ["Eyebrows/Angry", "Eyebrows/AngryNatural", "Eyebrows/Default", "Eyebrows/DefaultNatural", "Eyebrows/FlatNatural", "Eyebrows/FrownNatural", "Eyebrows/RaisedExcited", "Eyebrows/RaisedExcitedNatural", "Eyebrows/SadConcerned", "Eyebrows/SadConcernedNatural", "Eyebrows/UnibrowNatural", "Eyebrows/UpDown", "Eyebrows/UpDownNatural"],
    "EyeType": ["Eyes/Closed", "Eyes/Cry", "Eyes/Default", "Eyes/Dizzy", "Eyes/EyeRoll", "Eyes/Happy", "Eyes/Hearts", "Eyes/Side", "Eyes/Surprised", "Eyes/Wink", "Eyes/WinkWacky", "Eyes/Squint"],
    "FacialHairColor": ["FacialHairColor/Auburn", "FacialHairColor/Black", "FacialHairColor/Blonde", "FacialHairColor/BlondeGolden", "FacialHairColor/Brown", "FacialHairColor/BrownDark", "FacialHairColor/PastelPink", "FacialHairColor/Platinum", "FacialHairColor/Red", "FacialHairColor/SilverGray", "FacialHairColor/DarkGray", "FacialHairColor/LightGray", "FacialHairColor/Purple", "FacialHairColor/Fuchsia", "FacialHairColor/Blue", "FacialHairColor/Green"],
    "FacialHairType": ["FacialHair/Nothing", "FacialHair/FullBeard", "FacialHair/BeardLight", "FacialHair/MoustacheFancy", "FacialHair/MoustacheMagnum"],
    "HairColor": ["HairColor/Auburn", "HairColor/Black", "HairColor/Blonde", "HairColor/BlondeGolden", "HairColor/Brown", "HairColor/BrownDark", "HairColor/PastelPink", "HairColor/Platinum", "HairColor/Red", "HairColor/SilverGray", "HairColor/DarkGray", "HairColor/LightGray", "HairColor/Purple", "HairColor/Fuchsia", "HairColor/Blue", "HairColor/Green"],
    "HairStyle": ["HairStyles/Bald", "HairStyles/Eyepatch", "HairStyles/Hat", "HairStyles/Hijab", "HairStyles/Long", "HairStyles/BobCut", "HairStyles/Bun", "HairStyles/LongCurly", "HairStyles/LongCurvy", "HairStyles/LongDreads", "HairStyles/Frida", "HairStyles/Fro", "HairStyles/FroWithBand", "HairStyles/MiaWallace", "HairStyles/ItsNotShort", "HairStyles/LongShavedSides", "HairStyles/LongStraight", "HairStyles/LongStraight2", "HairStyles/LongStraightStrand", "HairStyles/ShortDreads", "HairStyles/ShortDreads2", "HairStyles/ShortFrizzle", "HairStyles/ShortShaggy", "HairStyles/ShortFlat", "HairStyles/ShortRound", "HairStyles/ShortWaved", "HairStyles/ShortSides", "HairStyles/ShortCaesar", "HairStyles/ShortCaesarSides", "HairStyles/Turban", "HairStyles/WinterHat1", "HairStyles/WinterHat2", "HairStyles/WinterHat3", "HairStyles/WinterHat4"],
    "MouthType": ["Mouth/Concerned", "Mouth/Default", "Mouth/Disbelief", "Mouth/Eating", "Mouth/Grimace", "Mouth/ScreamOpen", "Mouth/Sad", "Mouth/Serious", "Mouth/Smile", "Mouth/Tongue", "Mouth/Twinkle", "Mouth/Vomit"],
    "Nose": ["Nose/Default"],
    "OutfitColor": ["OutfitColor/Black", "OutfitColor/LightBlue", "OutfitColor/Blue", "OutfitColor/DarkBlue", "OutfitColor/LightGray", "OutfitColor/Gray", "OutfitColor/Heather", "OutfitColor/PastelBlue", "OutfitColor/PastelGreen", "OutfitColor/PastelOrange", "OutfitColor/PastelRed", "OutfitColor/PastelYellow", "OutfitColor/Pink", "OutfitColor/Red", "OutfitColor/White", "OutfitColor/Green", "OutfitColor/Purple", "OutfitColor/Fuchsia", "OutfitColor/Orange", "OutfitColor/Lemon"],
    "OutfitType": ["OutfitTypes/BlazerTShirt", "OutfitTypes/BlazerSweater", "OutfitTypes/CollarSweater", "OutfitTypes/GraphicShirt", "OutfitTypes/Hoodie", "OutfitTypes/Overall", "OutfitTypes/ShirtCrewNeck", "OutfitTypes/ShirtScoopNeck", "OutfitTypes/ShirtVNeck"],
    "SkinColor": ["SkinColor/Tanned", "SkinColor/Yellow", "SkinColor/White", "SkinColor/Peach", "SkinColor/Brown", "SkinColor/DarkBrown", "SkinColor/Black"]
  }
}
```
## PropertyCategoryIds

From [`lib/src/core/enums/property_category_ids.dart`](lib/src/core/enums/property_category_ids.dart:2-16):

- `Accessory`
- `Background`
- `EyebrowType`
- `EyeType`
- `FacialHairColor`
- `FacialHairType`
- `HairColor`
- `HairStyle`
- `MouthType`
- `Nose`
- `OutfitColor`
- `OutfitType`
- `SkinColor`

## Item IDs per Category

### Accessory (`PropertyCategoryIds.Accessory`)
From [`lib/src/core/enums/property_items/accessories.dart`](lib/src/core/enums/property_items/accessories.dart):
- `Accessories/Nothing`
- `Accessories/Kurt`
- `Accessories/Glasses`
- `Accessories/PrescriptionGlasses`
- `Accessories/Round`
- `Accessories/Sunglasses`
- `Accessories/Wayfarers`

### Background (`PropertyCategoryIds.Background`)
From [`lib/src/core/enums/property_items/background_style.dart`](lib/src/core/enums/property_items/background_style.dart):
- `BackgroundStyles/Transparent`
- `BackgroundStyles/Circle`

### EyebrowType (`PropertyCategoryIds.EyebrowType`)
From [`lib/src/core/enums/property_items/eyebrows.dart`](lib/src/core/enums/property_items/eyebrows.dart):
- `Eyebrows/Angry`
- `Eyebrows/AngryNatural`
- `Eyebrows/Default`
- `Eyebrows/DefaultNatural`
- `Eyebrows/FlatNatural`
- `Eyebrows/FrownNatural`
- `Eyebrows/RaisedExcited`
- `Eyebrows/RaisedExcitedNatural`
- `Eyebrows/SadConcerned`
- `Eyebrows/SadConcernedNatural`
- `Eyebrows/UnibrowNatural`
- `Eyebrows/UpDown`
- `Eyebrows/UpDownNatural`

### EyeType (`PropertyCategoryIds.EyeType`)
From [`lib/src/core/enums/property_items/eyes.dart`](lib/src/core/enums/property_items/eyes.dart):
- `Eyes/Closed`
- `Eyes/Cry`
- `Eyes/Default`
- `Eyes/Dizzy`
- `Eyes/EyeRoll`
- `Eyes/Happy`
- `Eyes/Hearts`
- `Eyes/Side`
- `Eyes/Surprised`
- `Eyes/Wink`
- `Eyes/WinkWacky`
- `Eyes/Squint`

### FacialHairColor (`PropertyCategoryIds.FacialHairColor`)
From [`lib/src/core/enums/property_items/facial_hair_colors.dart`](lib/src/core/enums/property_items/facial_hair_colors.dart):
- `FacialHairColor/Auburn`
- `FacialHairColor/Black`
- `FacialHairColor/Blonde`
- `FacialHairColor/BlondeGolden`
- `FacialHairColor/Brown`
- `FacialHairColor/BrownDark`
- `FacialHairColor/PastelPink`
- `FacialHairColor/Platinum`
- `FacialHairColor/Red`
- `FacialHairColor/SilverGray`
- `FacialHairColor/DarkGray`
- `FacialHairColor/LightGray`
- `FacialHairColor/Purple`
- `FacialHairColor/Fuchsia`
- `FacialHairColor/Blue`
- `FacialHairColor/Green`

### FacialHairType (`PropertyCategoryIds.FacialHairType`)
From [`lib/src/core/enums/property_items/facial_hair_types.dart`](lib/src/core/enums/property_items/facial_hair_types.dart):
- `FacialHair/Nothing`
- `FacialHair/FullBeard`
- `FacialHair/BeardLight`
- `FacialHair/MoustacheFancy`
- `FacialHair/MoustacheMagnum`

### HairColor (`PropertyCategoryIds.HairColor`)
From [`lib/src/core/enums/property_items/hair_colors.dart`](lib/src/core/enums/property_items/hair_colors.dart):
- `HairColor/Auburn`
- `HairColor/Black`
- `HairColor/Blonde`
- `HairColor/BlondeGolden`
- `HairColor/Brown`
- `HairColor/BrownDark`
- `HairColor/PastelPink`
- `HairColor/Platinum`
- `HairColor/Red`
- `HairColor/SilverGray`
- `HairColor/DarkGray`
- `HairColor/LightGray`
- `HairColor/Purple`
- `HairColor/Fuchsia`
- `HairColor/Blue`
- `HairColor/Green`

### HairStyle (`PropertyCategoryIds.HairStyle`)
From [`lib/src/core/enums/property_items/hair_styles.dart`](lib/src/core/enums/property_items/hair_styles.dart):
- `HairStyles/Bald`
- `HairStyles/Eyepatch`
- `HairStyles/Hat`
- `HairStyles/Hijab`
- `HairStyles/Long`
- `HairStyles/BobCut`
- `HairStyles/Bun`
- `HairStyles/LongCurly`
- `HairStyles/LongCurvy`
- `HairStyles/LongDreads`
- `HairStyles/Frida`
- `HairStyles/Fro`
- `HairStyles/FroWithBand`
- `HairStyles/MiaWallace`
- `HairStyles/ItsNotShort`
- `HairStyles/LongShavedSides`
- `HairStyles/LongStraight`
- `HairStyles/LongStraight2`
- `HairStyles/LongStraightStrand`
- `HairStyles/ShortDreads`
- `HairStyles/ShortDreads2`
- `HairStyles/ShortFrizzle`
- `HairStyles/ShortShaggy`
- `HairStyles/ShortFlat`
- `HairStyles/ShortRound`
- `HairStyles/ShortWaved`
- `HairStyles/ShortSides`
- `HairStyles/ShortCaesar`
- `HairStyles/ShortCaesarSides`
- `HairStyles/Turban`
- `HairStyles/WinterHat1`
- `HairStyles/WinterHat2`
- `HairStyles/WinterHat3`
- `HairStyles/WinterHat4`

### MouthType (`PropertyCategoryIds.MouthType`)
From [`lib/src/core/enums/property_items/mouths.dart`](lib/src/core/enums/property_items/mouths.dart):
- `Mouth/Concerned`
- `Mouth/Default`
- `Mouth/Disbelief`
- `Mouth/Eating`
- `Mouth/Grimace`
- `Mouth/ScreamOpen`
- `Mouth/Sad`
- `Mouth/Serious`
- `Mouth/Smile`
- `Mouth/Tongue`
- `Mouth/Twinkle`
- `Mouth/Vomit`

### Nose (`PropertyCategoryIds.Nose`)
From [`lib/src/core/enums/property_items/noses.dart`](lib/src/core/enums/property_items/noses.dart):
- `Nose/Default`

### OutfitColor (`PropertyCategoryIds.OutfitColor`)
From [`lib/src/core/enums/property_items/outfit_colors.dart`](lib/src/core/enums/property_items/outfit_colors.dart):
- `OutfitColor/Black`
- `OutfitColor/LightBlue`
- `OutfitColor/Blue`
- `OutfitColor/DarkBlue`
- `OutfitColor/LightGray`
- `OutfitColor/Gray`
- `OutfitColor/Heather`
- `OutfitColor/PastelBlue`
- `OutfitColor/PastelGreen`
- `OutfitColor/PastelOrange`
- `OutfitColor/PastelRed`
- `OutfitColor/PastelYellow`
- `OutfitColor/Pink`
- `OutfitColor/Red`
- `OutfitColor/White`
- `OutfitColor/Green`
- `OutfitColor/Purple`
- `OutfitColor/Fuchsia`
- `OutfitColor/Orange`
- `OutfitColor/Lemon`

### OutfitType (`PropertyCategoryIds.OutfitType`)
From [`lib/src/core/enums/property_items/outfit_types.dart`](lib/src/core/enums/property_items/outfit_types.dart):
- `OutfitTypes/BlazerTShirt`
- `OutfitTypes/BlazerSweater`
- `OutfitTypes/CollarSweater`
- `OutfitTypes/GraphicShirt`
- `OutfitTypes/Hoodie`
- `OutfitTypes/Overall`
- `OutfitTypes/ShirtCrewNeck`
- `OutfitTypes/ShirtScoopNeck`
- `OutfitTypes/ShirtVNeck`

### SkinColor (`PropertyCategoryIds.SkinColor`)
From [`lib/src/core/enums/property_items/skin_colors.dart`](lib/src/core/enums/property_items/skin_colors.dart):
- `SkinColor/Tanned`
- `SkinColor/Yellow`
- `SkinColor/White`
- `SkinColor/Peach`
- `SkinColor/Brown`
- `SkinColor/DarkBrown`
- `SkinColor/Black`

See [`lib/src/core/enums/property_categories.dart`](lib/src/core/enums/property_categories.dart) for category definitions and defaults.