// Rasterizes composite avatars with the real Flutter SVG pipeline (flutter_svg)
// so the output matches what the device draws, not what a browser draws.
//
// Run with: flutter test tool/render_flutter.dart
// Outputs: build/flutter_render/<Name>.png
import 'dart:io';
import 'dart:ui' as ui;

import 'package:avatar_maker/avatar_maker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

const _size = 264.0;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('rasterize composites with flutter_svg', () async {
    final names = Platform.environment['RENDER_NAMES']?.split(',') ??
        const <String>[
          'Bald',
          'Hat',
          'Turban',
          'LongShavedSides',
          'Long',
          'BobCut',
          'Bun',
          'CrewCut',
          'Spiky',
          'EmoFringe',
          'Cornrows',
          'TwoTails',
        ];

    Directory('build/flutter_render').createSync(recursive: true);

    for (final category
        in NonPersistentAvatarMakerController().propertyCategories) {
      if (category.id.name != 'HairStyle') continue;
      final items = category.properties;
      if (items == null) continue;
      for (final item in items) {
        final name = item.id.split('/').last;
        if (!names.contains(name)) continue;

        final controller = NonPersistentAvatarMakerController();
        controller.selectedOptions[category.id] = item;

        final svg = controller.drawAvatarSVG();
        final loader = SvgStringLoader(svg);
        final recorder = ui.PictureRecorder();
        final canvas = Canvas(recorder);
        final info = await vg.loadPicture(loader, null);
        final scale = _size / info.size.width;
        canvas.scale(scale);
        canvas.drawPicture(info.picture);
        final picture = recorder.endRecording();
        final image = await picture.toImage(
          (_size * scale).round().clamp(1, 4000),
          (_size * scale * info.size.height / info.size.width)
              .round()
              .clamp(1, 4000),
        );
        final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
        File('build/flutter_render/$name.png')
            .writeAsBytesSync(bytes!.buffer.asUint8List());
        info.picture.dispose();
        image.dispose();
        picture.dispose();
      }
    }
  });
}
