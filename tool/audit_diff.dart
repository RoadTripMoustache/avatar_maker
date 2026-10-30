// Renders each item composited into an avatar, plus a per-category baseline
// (the item that draws the least), so a plain pixel diff shows exactly which
// pixels the item contributes and where.
//
// Run: flutter test tool/audit_diff.dart
// Outputs:
//   build/diff/item/<Category>/<Name>.png     avatar with <Name> selected
//   build/diff/base/<Category>.png            avatar with the baseline selected
import 'dart:io';
import 'dart:ui' as ui;

import 'package:avatar_maker/avatar_maker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

const _w = 264;
const _h = 280;

Future<int> _render(String svg, String path) async {
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
  return bytes.lengthInBytes;
}

Future<int> _drawnPixels(String svg) async {
  final info = await vg.loadPicture(SvgStringLoader(svg), null);
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);
  canvas.drawPicture(info.picture);
  final picture = recorder.endRecording();
  final image = await picture.toImage(_w, _h);
  final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
  final pixels = data!.buffer.asUint8List();
  var count = 0;
  for (var i = 3; i < pixels.length; i += 4) {
    if (pixels[i] > 8) count++;
  }
  info.picture.dispose();
  image.dispose();
  picture.dispose();
  return count;
}

/// A category whose diff against this item is meaningful (i.e. an item that
/// draws nothing, or as close to nothing as the category has).
const _baseline = <String, String>{
  'Accessory': 'Nothing',
  'FacialHairType': 'Nothing',
  'HairStyle': 'Bald',
  'EyeType': 'Default',
  'MouthType': 'Default',
  'Nose': 'Default',
  'EyebrowType': 'Default',
  'Background': 'Transparent',
};

/// Categories where a pixel diff of the item against a baseline tells us where
/// the item is drawn. Colours and outfits have no "nothing" baseline.
const _diffable = {
  'Accessory',
  'FacialHairType',
  'HairStyle',
  'EyeType',
  'MouthType',
  'Nose',
  'EyebrowType',
  'Background',
};

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('render item diffs', () async {
    final probe = NonPersistentAvatarMakerController();

    for (final category in probe.propertyCategories) {
      final items = category.properties;
      if (items == null || items.isEmpty) continue;
      final cat = category.id.name;
      if (!_diffable.contains(cat)) continue;
      Directory('build/diff/item/$cat').createSync(recursive: true);
      Directory('build/diff/base').createSync(recursive: true);

      // Baseline: the item that paints the fewest pixels on its own.
      var bestIndex = 0;
      var bestCount = 1 << 30;
      final wanted = _baseline[cat];
      for (var i = 0; i < items.length; i++) {
        final item = items[i];
        final name = item.id.split('/').last;
        final raw = probe.getComponentSVG(category.id, i);
        final count = raw.trim().isEmpty ? 0 : await _drawnPixels(raw);
        if (wanted != null && name == wanted) {
          bestCount = count;
          bestIndex = i;
          break;
        }
        if (count < bestCount) {
          bestCount = count;
          bestIndex = i;
        }
      }
      final base = items[bestIndex];
      final baseCtrl = NonPersistentAvatarMakerController();
      baseCtrl.selectedOptions[category.id] = base;
      await _render(baseCtrl.drawAvatarSVG(), 'build/diff/base/$cat.png');
      stdout.writeln('$cat baseline: ${base.id.split('/').last} '
          '($bestCount px)');

      for (final item in items) {
        final name = item.id.split('/').last;
        final ctrl = NonPersistentAvatarMakerController();
        ctrl.selectedOptions[category.id] = item;
        await _render(ctrl.drawAvatarSVG(), 'build/diff/item/$cat/$name.png');
      }
    }
  });
}
