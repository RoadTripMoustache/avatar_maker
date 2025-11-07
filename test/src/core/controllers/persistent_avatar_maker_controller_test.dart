import "package:avatar_maker/avatar_maker.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";

import "../../customizer/avatar_maker_random_widget_test.mocks.dart";

@GenerateNiceMocks([MockSpec<PersistentAvatarMakerController>()])
void main() {
  final MockPersistentAvatarMakerController mockController =
      MockPersistentAvatarMakerController();

  group("PersistentAvatarMakerController", () {
    testWidgets("Check isPersistentController value",
        (WidgetTester tester) async {
      when(mockController.isPersistentController()).thenReturn(true);

      expect(true, mockController.isPersistentController());
    });
  });
}
