import "dart:io";

import "package:flutter_test/flutter_test.dart";

void main() {
  group("BackgroundStyles deprecation (commit 4)", () {
    final source = File(
      "lib/src/core/enums/property_items/background_style.dart",
    ).readAsStringSync();

    test("enum declaration is annotated @Deprecated", () {
      expect(
        source,
        contains("@Deprecated("),
        reason: "BackgroundStyles must carry a @Deprecated annotation",
      );
    });

    test("annotation is on the enum declaration (not just anywhere)", () {
      // Match: @Deprecated(...)\n enum BackgroundStyles
      final annotationOnEnum = RegExp(
        r"@Deprecated\s*\(.*?\)\s*\n\s*enum\s+BackgroundStyles",
        multiLine: true,
        dotAll: true,
      ).hasMatch(source);
      expect(annotationOnEnum, isTrue,
          reason: "@Deprecated must precede the enum declaration directly");
    });

    test("deprecation message references BackgroundCosmeticItem", () {
      final matches =
          RegExp(r'@Deprecated\s*\(\s*[\s\S]*?\)').firstMatch(source);
      expect(matches, isNotNull);
      final message = matches!.group(0)!;
      expect(message, contains("BackgroundCosmeticItem"),
          reason: "Migration path must be clearly named in the deprecation "
              "message");
    });

    test("deprecation message mentions 2.0.0 removal", () {
      final matches =
          RegExp(r'@Deprecated\s*\(\s*[\s\S]*?\)').firstMatch(source);
      expect(matches, isNotNull);
      final message = matches!.group(0)!;
      expect(message, contains("2.0.0"),
          reason: "Users must know when the enum will be removed");
    });
  });
}
