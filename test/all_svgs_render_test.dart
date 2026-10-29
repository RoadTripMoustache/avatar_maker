import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xml/xml.dart' as xml;
import 'package:avatar_maker/avatar_maker.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('audit every single thumbnail SVG in every category', () async {
    final controller = NonPersistentAvatarMakerController();

    final broken = <String>[];

    for (final category in controller.propertyCategories) {
      final items = category.properties;
      if (items == null) continue;
      for (int i = 0; i < items.length; i++) {
        final item = items[i];
        final svg = controller.getComponentSVG(category.id, i);

        // 1. XML check
        try {
          xml.XmlDocument.parse(svg);
        } catch (e) {
          broken
              .add('${category.id.name} #$i (${item.id}): XML parse error: $e');
          continue;
        }

        // 2. flutter_svg loader check
        try {
          final loader = SvgStringLoader(svg);
          final pictureInfo = await vg.loadPicture(loader, null);
          pictureInfo.picture.dispose();
        } catch (e) {
          broken.add(
              '${category.id.name} #$i (${item.id}): flutter_svg parse error: $e');
        }
      }
    }

    if (broken.isNotEmpty) {
      print('FOUND ${broken.length} BROKEN THUMBNAILS:');
      for (final b in broken) {
        print('  - $b');
      }
    }
    expect(broken, isEmpty);
  });

  test('audit every single avatar composite with each item', () async {
    final controller = NonPersistentAvatarMakerController();

    final broken = <String>[];

    for (final category in controller.propertyCategories) {
      final items = category.properties;
      if (items == null) continue;
      for (int i = 0; i < items.length; i++) {
        final item = items[i];
        // Select item
        controller.selectedOptions[category.id] = item;
        final avatarSvg = controller.drawAvatarSVG();

        // 1. XML check
        try {
          xml.XmlDocument.parse(avatarSvg);
        } catch (e) {
          broken.add(
              'Avatar with ${category.id.name} #$i (${item.id}): XML parse error: $e');
          continue;
        }

        // 2. flutter_svg loader check
        try {
          final loader = SvgStringLoader(avatarSvg);
          final pictureInfo = await vg.loadPicture(loader, null);
          pictureInfo.picture.dispose();
        } catch (e) {
          broken.add(
              'Avatar with ${category.id.name} #$i (${item.id}): flutter_svg parse error: $e');
        }
      }
    }

    if (broken.isNotEmpty) {
      print('FOUND ${broken.length} BROKEN AVATARS:');
      for (final b in broken) {
        print('  - $b');
      }
    }
    expect(broken, isEmpty);
  });
}
