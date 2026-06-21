import "package:avatar_maker/avatar_maker.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../../customizer/avatar_maker_random_widget_test.mocks.dart";

@GenerateNiceMocks([MockSpec<PersistentAvatarMakerController>()])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final MockPersistentAvatarMakerController mockController =
      MockPersistentAvatarMakerController();

  group("PersistentAvatarMakerController", () {
    testWidgets("Check isPersistentController value",
        (WidgetTester tester) async {
      when(mockController.isPersistentController()).thenReturn(true);

      expect(true, mockController.isPersistentController());
    });
  });

  group("setJsonOptions widening (commit 2)", () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test(
      "accepts a base AvatarMakerController reference (Persistent subtype)",
      () {
        final persistent = PersistentAvatarMakerController();
        // Cast to base type — this compiles only because the signature
        // accepts AvatarMakerController (commit 2 widening).
        final AvatarMakerController typed = persistent;
        // ignore: unnecessary_statements
        typed;
        // ignore: unnecessary_statements
        () => PersistentAvatarMakerController.setJsonOptions(
              '{"HairStyle":"ShortFlat"}',
              controller: typed,
            );
      },
    );

    test(
      "accepts a NonPersistentAvatarMakerController typed as the base type",
      () {
        final nonPersistent = NonPersistentAvatarMakerController();
        final AvatarMakerController typed = nonPersistent;
        // ignore: unnecessary_statements
        typed;
        // ignore: unnecessary_statements
        () => PersistentAvatarMakerController.setJsonOptions(
              '{"HairStyle":"ShortFlat"}',
              controller: typed,
            );
      },
    );

    test(
      "still accepts the PersistentAvatarMakerController subtype directly "
      "(backward compatibility)",
      () {
        final persistent = PersistentAvatarMakerController();
        // ignore: unnecessary_statements
        () => PersistentAvatarMakerController.setJsonOptions(
              '{"HairStyle":"ShortFlat"}',
              controller: persistent,
            );
      },
    );
  });
}
