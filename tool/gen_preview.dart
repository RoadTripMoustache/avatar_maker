// Generates preview pages from the actual Dart enum data so the browser shows
// exactly what the package renders.
//
// Run with: flutter test tool/gen_preview.dart
// Outputs: build/preview_thumbnails.html, build/preview_avatars.html
import 'dart:convert';
import 'dart:io';

import 'package:avatar_maker/avatar_maker.dart';
import 'package:flutter_test/flutter_test.dart';

const _style = '''
body{font:13px/1.4 system-ui,sans-serif;background:#f2f3f5;margin:0;padding:20px;color:#222}
h1{font-size:18px;margin:0 0 4px}
p.lead{margin:0 0 20px;color:#666}
h2{font-size:14px;margin:28px 0 10px;border-bottom:1px solid #d8dade;padding-bottom:6px;position:sticky;top:0;background:#f2f3f5;z-index:5}
.grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(180px,1fr));gap:10px}
.card{background:#fff;border:1px solid #e2e4e8;border-radius:10px;padding:6px;margin:0;text-align:center}
.card svg{display:block;width:100%;height:auto;aspect-ratio:264/280}
.name{font-size:11px;color:#333;word-break:break-word;padding-top:4px}
.meta{font-size:10px;color:#98a0aa}
''';

String _svgTag(String svg, {String extra = ''}) => svg.replaceFirst(
      RegExp(r'<svg[^>]*>'),
      '<svg viewBox="0 0 264 280" $extra>',
    );

void main() {
  test('generate preview pages', () {
    final controller = NonPersistentAvatarMakerController();

    final thumbs = StringBuffer()..write(_head('avatar_maker - thumbnails'));
    final avatars = StringBuffer()..write(_head('avatar_maker - avatars'));

    for (final category in controller.propertyCategories) {
      final items = category.properties;
      if (items == null || items.isEmpty) continue;
      final id = category.id;
      final isColor = id.name.toLowerCase().contains('color');

      thumbs.write(
          '<h2>${id.name} <span class="meta">${items.length} items</span></h2><div class="grid">');
      avatars.write(
          '<h2>${id.name} <span class="meta">${items.length} items</span></h2><div class="grid">');

      for (var i = 0; i < items.length; i++) {
        final item = items[i];
        final name = item.id.split('/').last;

        thumbs.write(
            '<figure class="card">${_svgTag(controller.getComponentSVG(id, i))}'
            '<div class="name">$name</div><div class="meta">#${i + 1}</div></figure>');

        if (!isColor && item.value.isNotEmpty) {
          // Fresh controller per item so every composite shows only this
          // category's variation on top of the defaults.
          final compositeController = NonPersistentAvatarMakerController();
          compositeController.selectedOptions[id] = item;
          final svg = compositeController.drawAvatarSVG();
          avatars.write('<figure class="card">${_svgTag(svg)}'
              '<div class="name">$name</div><div class="meta">#${i + 1}</div></figure>');
        }
      }
      thumbs.write('</div>');
      avatars.write('</div>');
    }

    thumbs.write('</body></html>');
    avatars.write('</body></html>');

    Directory('build').createSync(recursive: true);
    File('build/preview_thumbnails.html')
        .writeAsStringSync(thumbs.toString(), encoding: utf8);
    File('build/preview_avatars.html')
        .writeAsStringSync(avatars.toString(), encoding: utf8);

    // One page per category, so the browser can render a single grid at once.
    for (final category in controller.propertyCategories) {
      final items = category.properties;
      if (items == null || items.isEmpty) continue;
      final id = category.id;
      final isColor = id.name.toLowerCase().contains('color');
      final pageController = NonPersistentAvatarMakerController();
      final page = StringBuffer()..write(_head('avatar_maker - ${id.name}'));
      page.write('<div class="grid">');
      for (var i = 0; i < items.length; i++) {
        final item = items[i];
        final name = item.id.split('/').last;
        final svg = isColor || item.value.isEmpty
            ? pageController.getComponentSVG(id, i)
            : () {
                pageController.selectedOptions[id] = item;
                return pageController.drawAvatarSVG();
              }();
        page.write('<figure class="card">${_svgTag(svg)}'
            '<div class="name">$name</div>'
            '<div class="meta">#${i + 1}</div></figure>');
      }
      page.write('</div></body></html>');
      File('build/preview_${id.name}.html')
          .writeAsStringSync(page.toString(), encoding: utf8);
    }
  });
}

String _head(String title) => '''<!DOCTYPE html>
<html lang="en"><head><meta charset="utf-8"><title>$title</title>
<style>$_style</style></head><body><h1>$title</h1>
<p class="lead">Generated from the Dart enums.</p>
''';
