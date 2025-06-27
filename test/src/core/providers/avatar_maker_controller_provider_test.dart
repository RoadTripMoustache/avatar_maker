import "package:avatar_maker/avatar_maker.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/annotations.dart";
import "package:provider/provider.dart";

import "../../../helpers.dart";
@GenerateNiceMocks([MockSpec<AvatarMakerController>()])
import "avatar_maker_controller_provider_test.mocks.dart";

void main() {
  final MockAvatarMakerController mockController = MockAvatarMakerController();

  group("AvatarMakerControllerProvider", () {
    testWidgets(
        "Creates PersistentAvatarMakerController when no controller is provided",
        (WidgetTester tester) async {
      // Build the widget tree
      await tester.pumpMaterialApp(
        AvatarMakerControllerProvider(
          child: Builder(
            builder: (context) {
              // Access the controller from the provider
              final controller =
                  Provider.of<AvatarMakerController>(context, listen: false);

              // Verify it's a PersistentAvatarMakerController
              expect(controller, isA<PersistentAvatarMakerController>());

              return Text("Test");
            },
          ),
        ),
      );

      // Verify the text is rendered (indicating the builder was called)
      expect(find.text("Test"), findsOneWidget);
    });

    testWidgets("Uses provided controller", (WidgetTester tester) async {
      // Build the widget tree with a mock controller
      await tester.pumpMaterialApp(
        AvatarMakerControllerProvider(
          controller: mockController,
          child: Builder(
            builder: (context) {
              // Access the controller from the provider
              final controller =
                  Provider.of<AvatarMakerController>(context, listen: false);

              // Verify it's the mock controller we provided
              expect(controller, equals(mockController));

              return Text("Test");
            },
          ),
        ),
      );

      // Verify the text is rendered (indicating the builder was called)
      expect(find.text("Test"), findsOneWidget);
    });
  });
}
