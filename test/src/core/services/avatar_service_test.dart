import 'package:avatar_maker/avatar_maker.dart';
import 'package:avatar_maker/src/core/enums/property_category_ids.dart';
import 'package:avatar_maker/src/core/enums/property_items/accessories.dart';
import 'package:avatar_maker/src/core/enums/property_items/background_style.dart';
import 'package:avatar_maker/src/core/enums/property_items/eyebrows.dart';
import 'package:avatar_maker/src/core/enums/property_items/eyes.dart';
import 'package:avatar_maker/src/core/enums/property_items/facial_hair_colors.dart';
import 'package:avatar_maker/src/core/enums/property_items/facial_hair_types.dart';
import 'package:avatar_maker/src/core/enums/property_items/hair_colors.dart';
import 'package:avatar_maker/src/core/enums/property_items/hair_styles.dart';
import 'package:avatar_maker/src/core/enums/property_items/mouths.dart';
import 'package:avatar_maker/src/core/enums/property_items/noses.dart';
import 'package:avatar_maker/src/core/enums/property_items/outfit_colors.dart';
import 'package:avatar_maker/src/core/enums/property_items/outfit_types.dart';
import 'package:avatar_maker/src/core/enums/property_items/skin_colors.dart';
import 'package:avatar_maker/src/core/models/property_item.dart';
import 'package:avatar_maker/src/core/services/avatar_service.dart';
import 'package:avatar_maker/src/core/services/facial_hairs_service.dart';
import 'package:avatar_maker/src/core/services/hair_service.dart';
import 'package:avatar_maker/src/core/services/outfit_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AvatarService', () {
    group('extractPropertiesFromSvg', () {
      test('should extract properties from an SVG', () {
        // Arrange
        final svg = AvatarService.drawSVG(
          backgroundStyle: BackgroundStyles.Circle.value,
          outfit: OutfitTypes.ShirtCrewNeck.value,
          facialHair: FacialHairTypes.FullBeard.value,
          mouth: Mouths.Smile.value,
          nose: Noses.Default.value,
          eyes: Eyes.Happy.value,
          eyebrows: Eyebrows.RaisedExcited.value,
          accessory: Accessories.PrescriptionGlasses.value,
          hair: HairStyles.ShortWaved.value,
          skin: SkinColors.Black.value,
        );

        // Act
        final result = AvatarService.extractPropertiesFromSvg(svg);

        // Assert
        expect(result[PropertyCategoryIds.Background],
            equals(BackgroundStyles.Circle));
        expect(result[PropertyCategoryIds.OutfitType],
            equals(OutfitTypes.ShirtCrewNeck));
        expect(result[PropertyCategoryIds.FacialHairType],
            equals(FacialHairTypes.FullBeard));
        expect(result[PropertyCategoryIds.MouthType], equals(Mouths.Smile));
        expect(result[PropertyCategoryIds.Nose], equals(Noses.Default));
        expect(result[PropertyCategoryIds.EyeType], equals(Eyes.Happy));
        expect(result[PropertyCategoryIds.EyebrowType],
            equals(Eyebrows.RaisedExcited));
        expect(result[PropertyCategoryIds.Accessory],
            equals(Accessories.PrescriptionGlasses));
        expect(result[PropertyCategoryIds.HairStyle],
            equals(HairStyles.ShortWaved));
        expect(result[PropertyCategoryIds.SkinColor], equals(SkinColors.Black));
      });

      test('should handle SVG with missing properties by using defaults', () {
        // Arrange
        // Create an SVG with missing properties (just a basic structure)
        final svg = '''
        <svg width="264px" height="280px" viewBox="0 0 264 280" version="1.1"
            xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
            <desc>AvatarMaker on pub.dev</desc>
            <defs>
                <circle id="path-1" cx="120" cy="120" r="120"></circle>
                <path
                    d="M12,160 C12,226.27417 65.72583,280 132,280 C198.27417,280 252,226.27417 252,160 L264,160 L264,-1.42108547e-14 L-3.19744231e-14,-1.42108547e-14 L-3.19744231e-14,160 L12,160 Z"
                    id="path-3"></path>
                <path
                    d="M124,144.610951 L124,163 L128,163 L128,163 C167.764502,163 200,195.235498 200,235 L200,244 L0,244 L0,235 C-4.86974701e-15,195.235498 32.235498,163 72,163 L72,163 L76,163 L76,144.610951 C58.7626345,136.422372 46.3722246,119.687011 44.3051388,99.8812385 C38.4803105,99.0577866 34,94.0521096 34,88 L34,74 C34,68.0540074 38.3245733,63.1180731 44,62.1659169 L44,56 L44,56 C44,25.072054 69.072054,5.68137151e-15 100,0 L100,0 L100,0 C130.927946,-5.68137151e-15 156,25.072054 156,56 L156,62.1659169 C161.675427,63.1180731 166,68.0540074 166,74 L166,88 C166,94.0521096 161.51969,99.0577866 155.694861,99.8812385 C153.627775,119.687011 141.237365,136.422372 124,144.610951 Z"
                    id="path-5"></path>
            </defs>
            <g id="AvatarMaker" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                <g transform="translate(-825.000000, -1100.000000)" id="avatar_maker/Circle">
                    <g transform="translate(825.000000, 1100.000000)">
                        <g id="Mask"></g>
                        <g id="AvatarMaker" stroke-width="1" fill-rule="evenodd">
                            <g id="Body" transform="translate(32.000000, 36.000000)">
                                <mask id="mask-6" fill="white">
                                    <use xlink:href="#path-5"></use>
                                </mask>
                                <use fill="#D0C6AC" xlink:href="#path-5"></use>
                                <path
                                    d="M156,79 L156,102 C156,132.927946 130.927946,158 100,158 C69.072054,158 44,132.927946 44,102 L44,79 L44,94 C44,124.927946 69.072054,150 100,150 C130.927946,150 156,124.927946 156,94 L156,79 Z"
                                    id="Neck-Shadow" opacity="0.100000001" fill="#000000"
                                    mask="url(#mask-6)"></path>
                            </g>
                            <g id="Face" transform="translate(76.000000, 82.000000)" fill="#000000">
                            </g>
                        </g>
                    </g>
                </g>
            </g>
        </svg>
        ''';

        // Act
        final result = AvatarService.extractPropertiesFromSvg(svg);

        // Assert
        // Check that default values are used for missing properties
        expect(result[PropertyCategoryIds.Background],
            equals(BackgroundStyles.Transparent));
        expect(
            result[PropertyCategoryIds.OutfitType], equals(OutfitTypes.Hoodie));
        expect(result[PropertyCategoryIds.FacialHairType],
            equals(FacialHairTypes.Nothing));
        expect(result[PropertyCategoryIds.MouthType], equals(Mouths.Default));
        expect(result[PropertyCategoryIds.Nose], equals(Noses.Default));
        expect(result[PropertyCategoryIds.EyeType], equals(Eyes.Default));
        expect(
            result[PropertyCategoryIds.EyebrowType], equals(Eyebrows.Default));
        expect(
            result[PropertyCategoryIds.Accessory], equals(Accessories.Nothing));
        expect(result[PropertyCategoryIds.HairStyle], equals(HairStyles.Bald));
        expect(result[PropertyCategoryIds.SkinColor], equals(SkinColors.Brown));
      });

      test('should handle SVG with color properties', () {
        // Arrange
        final svg = AvatarService.drawSVG(
          backgroundStyle: BackgroundStyles.Transparent.value,
          outfit: OutfitService.generateOutfit(
            type: OutfitTypes.Hoodie,
            color: OutfitColors.Red,
          ),
          facialHair: FacialHairsService.generateFacialHair(
            type: FacialHairTypes.FullBeard,
            color: FacialHairColors.Auburn,
          ),
          mouth: Mouths.Default.value,
          nose: Noses.Default.value,
          eyes: Eyes.Default.value,
          eyebrows: Eyebrows.Default.value,
          accessory: Accessories.Nothing.value,
          hair: HairService.generateHairStyle(
            style: HairStyles.ShortWaved,
            color: HairColors.BlondeGolden,
          ),
          skin: SkinColors.Brown.value,
        );

        // Act
        final result = AvatarService.extractPropertiesFromSvg(svg);

        // Assert
        expect(
            result[PropertyCategoryIds.OutfitType], equals(OutfitTypes.Hoodie));
        expect(
            result[PropertyCategoryIds.OutfitColor], equals(OutfitColors.Red));
        expect(result[PropertyCategoryIds.FacialHairType],
            equals(FacialHairTypes.FullBeard));
        expect(result[PropertyCategoryIds.FacialHairColor],
            equals(FacialHairColors.Auburn));
        expect(result[PropertyCategoryIds.HairStyle],
            equals(HairStyles.ShortWaved));
        expect(result[PropertyCategoryIds.HairColor],
            equals(HairColors.BlondeGolden));
      });
    });
  });
}
