// Rasterizes ONE property item's SVG (on a transparent canvas) so we can compare
// exactly what the mask does, without the head/face layers hiding it.
//
// Run: flutter test tool/render_item.dart --dart-define=ITEM=Hat
import 'dart:io';
import 'dart:ui' as ui;

import 'package:avatar_maker/avatar_maker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('rasterize raw item svg', () async {
    final want = const String.fromEnvironment('ITEM', defaultValue: 'Hat');
    Directory('build/items').createSync(recursive: true);

    for (final category
        in NonPersistentAvatarMakerController().propertyCategories) {
      final items = category.properties;
      if (items == null) continue;
      for (final item in items) {
        if (item.value.isEmpty) continue;
        final name = item.id.split('/').last;
        if (name != want) continue;

        final raw = item.value.trim();
        final svg = raw.startsWith('<svg')
            ? raw
            : '<svg width="264" height="280" viewBox="0 0 264 280" '
                'xmlns="http://www.w3.org/2000/svg" '
                'xmlns:xlink="http://www.w3.org/1999/xlink">$raw</svg>';

        final info = await vg.loadPicture(SvgStringLoader(svg), null);
        final recorder = ui.PictureRecorder();
        final canvas = Canvas(recorder);
        canvas.drawPicture(info.picture);
        final picture = recorder.endRecording();
        final image = await picture.toImage(264, 280);
        final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
        File('build/items/$name.png')
            .writeAsBytesSync(bytes!.buffer.asUint8List());
        info.picture.dispose();
        image.dispose();
        picture.dispose();
      }
    }
  });
}
