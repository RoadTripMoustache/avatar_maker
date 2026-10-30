import 'package:flutter_test/flutter_test.dart';

import 'package:avatar_maker/src/core/enums/property_items/hair_styles.dart';
import 'package:avatar_maker/src/core/enums/property_items/facial_hair_types.dart';
import 'package:avatar_maker/src/core/enums/property_items/eyebrows.dart';
import 'package:avatar_maker/src/core/enums/property_items/eyes.dart';
import 'package:avatar_maker/src/core/enums/property_items/noses.dart';
import 'package:avatar_maker/src/core/enums/property_items/mouths.dart';
import 'package:avatar_maker/src/core/enums/property_items/outfit_types.dart';
import 'package:avatar_maker/src/core/enums/property_items/accessories.dart';
import 'package:avatar_maker/src/core/enums/property_items/skin_colors.dart';
import 'package:avatar_maker/src/core/enums/property_items/background_style.dart';

import 'package:avatar_maker/src/core/enums/placeholders.dart';

void main() {
  test('every category offers at least 50 styles', () {
    expect(HairStyles.values.length, greaterThanOrEqualTo(50));
    expect(FacialHairTypes.values.length, greaterThanOrEqualTo(50));
    expect(Eyebrows.values.length, greaterThanOrEqualTo(50));
    expect(Eyes.values.length, greaterThanOrEqualTo(50));
    expect(Noses.values.length, greaterThanOrEqualTo(50));
    expect(Mouths.values.length, greaterThanOrEqualTo(50));
    expect(OutfitTypes.values.length, greaterThanOrEqualTo(50));
    expect(Accessories.values.length, greaterThanOrEqualTo(50));
    expect(SkinColors.values.length, greaterThanOrEqualTo(50));
    expect(BackgroundStyles.values.length, greaterThanOrEqualTo(50));
  });

  test('the ids are unique inside every category', () {
    void check(List<String> ids, String name) {
      expect(ids.toSet().length, ids.length, reason: '$name has duplicate ids');
    }

    check(HairStyles.values.map((e) => e.id).toList(), 'hair');
    check(FacialHairTypes.values.map((e) => e.id).toList(), 'facial hair');
    check(Eyebrows.values.map((e) => e.id).toList(), 'eyebrows');
    check(Eyes.values.map((e) => e.id).toList(), 'eyes');
    check(Noses.values.map((e) => e.id).toList(), 'nose');
    check(Mouths.values.map((e) => e.id).toList(), 'mouth');
    check(OutfitTypes.values.map((e) => e.id).toList(), 'outfit');
    check(Accessories.values.map((e) => e.id).toList(), 'accessories');
    check(SkinColors.values.map((e) => e.id).toList(), 'skin');
    check(BackgroundStyles.values.map((e) => e.id).toList(), 'background');
  });

  test('no style uses a <style> element', () {
    final all = <String>[
      ...HairStyles.values.map((e) => e.svg),
      ...FacialHairTypes.values.map((e) => e.svg),
      ...Eyebrows.values.map((e) => e.svg),
      ...Eyes.values.map((e) => e.svg),
      ...Noses.values.map((e) => e.svg),
      ...Mouths.values.map((e) => e.svg),
      ...OutfitTypes.values.map((e) => e.svg),
      ...Accessories.values.map((e) => e.svg),
      ...SkinColors.values.map((e) => e.svg),
      ...BackgroundStyles.values.map((e) => e.svg),
    ];
    for (final svg in all) {
      expect(svg, isNot(contains('<style')));
    }
  });

  test('the hair, facial hair and outfit placeholders resolve', () {
    for (final style in HairStyles.values) {
      if (style.svg.isEmpty) continue;
      final svg = style.svg
          .replaceAll(TO_REPLACE_WITH_HAIRS_COLOR_NAME, 'HairColor/Black')
          .replaceAll(TO_REPLACE_WITH_HAIRS_COLOR, '#2C1B18');
      expect(svg, isNot(contains('TO_REPLACE_WITH')));
    }
    for (final style in FacialHairTypes.values) {
      if (style.svg.isEmpty) continue;
      final svg = style.svg
          .replaceAll(
              TO_REPLACE_WITH_FACIAL_HAIRS_COLOR_NAME, 'FacialHairColor/Black')
          .replaceAll(TO_REPLACE_WITH_FACIAL_HAIRS_COLOR, '#252E32');
      expect(svg, isNot(contains('TO_REPLACE_WITH')));
    }
    for (final style in OutfitTypes.values) {
      if (style.svg.isEmpty) continue;
      final svg = style.svg
          .replaceAll(TO_REPLACE_WITH_OUTFIT_COLOR_NAME, 'OutfitColor/Black')
          .replaceAll(TO_REPLACE_WITH_OUTFIT_COLOR, '#5BC0DE');
      expect(svg, isNot(contains('TO_REPLACE_WITH')));
    }
  });

  test('every style is a well-formed SVG fragment', () {
    final all = <String>[
      ...HairStyles.values.map((e) => e.svg),
      ...FacialHairTypes.values.map((e) => e.svg),
      ...Eyebrows.values.map((e) => e.svg),
      ...Eyes.values.map((e) => e.svg),
      ...Noses.values.map((e) => e.svg),
      ...Mouths.values.map((e) => e.svg),
      ...OutfitTypes.values.map((e) => e.svg),
      ...Accessories.values.map((e) => e.svg),
      ...SkinColors.values.map((e) => e.svg),
      ...BackgroundStyles.values.map((e) => e.svg),
    ];
    for (final svg in all) {
      if (svg.isEmpty) continue;
      // The <g> elements have to balance, otherwise the SVG is truncated.
      expect(RegExp(r'<g\b').allMatches(svg).length,
          RegExp(r'</g>').allMatches(svg).length,
          reason: 'unbalanced <g>');
      // And every style has to carry the id the controller looks up.
      expect(svg.contains('id="'), isTrue);
    }
  });
}
