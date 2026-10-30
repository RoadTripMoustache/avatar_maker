// Rasterizes EVERY hair style with flutter_svg (the engine the device uses) so
// we can measure where the hair actually lands.
//
// Run with: flutter test tool/audit_hair.dart
// Outputs: build/audit/<Name>.png  +  build/audit_hair.txt
import 'dart:io';
import 'dart:ui' as ui;

import 'package:avatar_maker/avatar_maker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

const _w = 264;
const _h = 280;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('rasterize every hair style with flutter_svg', () async {
    Directory('build/audit').createSync(recursive: true);
    final report = StringBuffer();

    for (final category
        in NonPersistentAvatarMakerController().propertyCategories) {
      if (category.id.name != 'HairStyle') continue;
      final items = category.properties;
      if (items == null) continue;

      for (final item in items) {
        final name = item.id.split('/').last;
        if (item.value.isEmpty) {
          report.writeln('$name: EMPTY');
          continue;
        }

        final controller = NonPersistentAvatarMakerController();
        controller.selectedOptions[category.id] = item;
        final svg = controller.drawAvatarSVG();

        try {
          final info = await vg.loadPicture(SvgStringLoader(svg), null);
          final recorder = ui.PictureRecorder();
          final canvas = Canvas(recorder);
          canvas.drawPicture(info.picture);
          final picture = recorder.endRecording();
          final image = await picture.toImage(_w, _h);
          final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
          File('build/audit/$name.png')
              .writeAsBytesSync(bytes!.buffer.asUint8List());
          info.picture.dispose();
          image.dispose();
          picture.dispose();
          report.writeln('$name: OK');
        } catch (e) {
          report.writeln('$name: ERROR $e');
        }
      }
    }

    File('build/audit_hair.txt').writeAsStringSync(report.toString());
  });
}
