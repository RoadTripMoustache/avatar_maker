import 'dart:ui' as ui;

import 'package:flutter/material.dart';
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

  test('Hat covers the scalp instead of being clipped by its own mask',
      () async {
    final controller = NonPersistentAvatarMakerController();
    for (final category in controller.propertyCategories) {
      if (category.id.name != 'HairStyle') continue;
      controller.selectedOptions[category.id] = HairStyles.Hat;
    }
    final avatarSvg = controller.drawAvatarSVG();

    final info = await vg.loadPicture(SvgStringLoader(avatarSvg), null);
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    canvas.drawPicture(info.picture);
    final picture = recorder.endRecording();
    final image = await picture.toImage(264, 280);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    info.picture.dispose();
    picture.dispose();
    image.dispose();

    final decoded = await decodeImageFromList(bytes!.buffer.asUint8List());
    final data = await decoded.toByteData(format: ui.ImageByteFormat.rawRgba);
    final pixels = data!.buffer.asUint8List();
    // Avatar canvas is 264x280 with an RGBA byte stream.
    int pixelAt(int x, int y) {
      final i = (y * decoded.width + x) * 4;
      return (pixels[i] << 16) | (pixels[i + 1] << 8) | pixels[i + 2];
    }

    // The head silhouette starts at y = 36 and is centred on x = 132. The hat
    // crown is painted over that area, so the top of the skull must be hat
    // coloured (#1F333C) and never skin.
    const hat = 0x1F333C;
    for (final point in const [
      [110, 60],
      [132, 60],
      [150, 60],
      [132, 70],
    ]) {
      final argb = pixelAt(point[0], point[1]);
      expect(
        argb,
        hat,
        reason: 'expected hat at ${point[0]},${point[1]} but got '
            '${argb.toRadixString(16)}',
      );
    }
    decoded.dispose();
  });
}
