import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpMaterialApp(Widget widget) {
    return pumpWidget(
      MaterialApp(
        home: new Scaffold(
          body: new SizedBox(
            height: 600.0,
            width: 600.0,
            child: widget,
          ),
        ),
      ),
    );
  }
}
