// Renders EVERY item of EVERY category with flutter_svg (the engine the device
// uses), both as a standalone component and composited into an avatar.
//
// Run: flutter test tool/audit_all.dart
// Outputs:
//   build/audit_all/components/<Category>/<Name>.png
//   build/audit_all/avatars/<Category>/<Name>.png
//   build/audit_all/report.txt
import 'dart:io';
import 'dart:ui' as ui;

import 'package:avatar_maker/avatar_maker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

const _w = 264;
const _h = 280;

Future<void> _write(
    String path, String svg, StringBuffer report, String label) async {
  if (svg.trim().isEmpty) {
    report.writeln('$label: EMPTY_SVG');
    return;
  }
  try {
    final info = await vg.loadPicture(SvgStringLoader(svg), null);
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    canvas.drawPicture(info.picture);
    final picture = recorder.endRecording();
    final image = await picture.toImage(_w, _h);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    File(path).writeAsBytesSync(bytes!.buffer.asUint8List());
    info.picture.dispose();
    image.dispose();
    picture.dispose();
    report.writeln('$label: OK');
  } catch (e) {
    report.writeln('$label: ERROR $e');
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('render every component and composite', () async {
    final report = StringBuffer();
    final probe = NonPersistentAvatarMakerController();

    for (final category in probe.propertyCategories) {
      final items = category.properties;
      if (items == null || items.isEmpty) {
        report.writeln('${category.id.name}: NO_ITEMS');
        continue;
      }
      final dir = category.id.name;
      Directory('build/audit_all/components/$dir').createSync(recursive: true);
      Directory('build/audit_all/avatars/$dir').createSync(recursive: true);

      for (var i = 0; i < items.length; i++) {
        final item = items[i];
        final name = item.id.split('/').last;
        final thumb = probe.getComponentSVG(category.id, i);
        await _write('build/audit_all/components/$dir/$name.png', thumb, report,
            '$dir/$name component');

        final controller = NonPersistentAvatarMakerController();
        controller.selectedOptions[category.id] = item;
        await _write('build/audit_all/avatars/$dir/$name.png',
            controller.drawAvatarSVG(), report, '$dir/$name avatar');
      }
    }

    File('build/audit_all/report.txt').writeAsStringSync(report.toString());
  });
}
