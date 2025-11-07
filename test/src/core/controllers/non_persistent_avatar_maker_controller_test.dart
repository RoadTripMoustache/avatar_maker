import "package:avatar_maker/avatar_maker.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  final NonPersistentAvatarMakerController controller =
      NonPersistentAvatarMakerController();

  group("NonPersistentAvatarMakerController", () {
    testWidgets("Check isPersistentController value",
        (WidgetTester tester) async {
      expect(false, controller.isPersistentController());
    });
  });
}
