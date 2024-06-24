import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";


extension WidgetTesterExtension on WidgetTester {
  Future<void> pumpMaterialApp(Widget widget) {
    return pumpWidget(
      MaterialApp(
        home: new Scaffold(
          body: new Column(
            children: [widget],
          ),
        ),
      ),
    );
  }

}

