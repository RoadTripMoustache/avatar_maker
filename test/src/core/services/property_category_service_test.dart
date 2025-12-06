import "package:flutter_test/flutter_test.dart";
import "package:avatar_maker/avatar_maker.dart";
import "package:avatar_maker/l10n/app_localizations.dart";
import "package:avatar_maker/src/core/models/property_category.dart";
import "package:avatar_maker/src/core/services/property_category_service.dart";
import "package:mockito/annotations.dart";
import "package:mockito/mockito.dart";

@GenerateNiceMocks([
  MockSpec<AppLocalizations>(),
  MockSpec<PropertyCategory>(),
  MockSpec<CustomizedPropertyCategory>(),
  MockSpec<PropertyItem>(),
])
import "property_category_service_test.mocks.dart";

final PropertyCategory defaultCategory1 = MockPropertyCategory();
final PropertyCategory defaultCategory2 = MockPropertyCategory();

void main() {
  late MockAppLocalizations mockL10n;
  late MockPropertyItem mockDefaultItem1;
  late MockPropertyItem mockDefaultItem2;
  late MockPropertyItem mockCustomItem;

  setUp(() {
    mockL10n = MockAppLocalizations();
    when(mockL10n.property_category_accessories).thenReturn('Accessories');
    when(mockL10n.property_category_backgrounds).thenReturn('Backgrounds');
    when(mockL10n.property_category_eyes).thenReturn('Eyes');
    when(mockL10n.property_category_eyebrows).thenReturn('Eyebrows');
    when(mockL10n.property_category_facial_hair_colors)
        .thenReturn('Facial Hair Colors');
    when(mockL10n.property_category_facial_hair_types)
        .thenReturn('Facial Hairs');
    when(mockL10n.property_category_hair_colors).thenReturn('Hair Colors');
    when(mockL10n.property_category_hairstyles).thenReturn('Hairstyles');
    when(mockL10n.property_category_mouths).thenReturn('Mouths');
    when(mockL10n.property_category_noses).thenReturn('Noses');
    when(mockL10n.property_category_outfit_colors).thenReturn('Outfit Colors');
    when(mockL10n.property_category_outfit_types).thenReturn('Outfits');
    when(mockL10n.property_category_skins).thenReturn('Skins');

    mockDefaultItem1 = MockPropertyItem();
    when(mockDefaultItem1.label).thenReturn('DefaultItem1');
    when(mockDefaultItem1.id).thenReturn('default_item_1');

    mockDefaultItem2 = MockPropertyItem();
    when(mockDefaultItem2.label).thenReturn('DefaultItem2');
    when(mockDefaultItem2.id).thenReturn('default_item_2');

    mockCustomItem = MockPropertyItem();
    when(mockCustomItem.label).thenReturn('CustomItem');
    when(mockCustomItem.id).thenReturn('custom_item');

    when(defaultCategory1.id).thenReturn(PropertyCategoryIds.Accessory);
    when(defaultCategory1.getL10nName(mockL10n))
        .thenReturn('Accessory (Default)');
    when(defaultCategory1.defaultValue).thenReturn(mockDefaultItem1);
    when(defaultCategory1.properties)
        .thenReturn([mockDefaultItem1, mockDefaultItem2]);
    when(defaultCategory1.toDisplay).thenReturn(true);
    when(defaultCategory1.iconFile).thenReturn('icon1.svg');

    when(defaultCategory2.id).thenReturn(PropertyCategoryIds.Background);
    when(defaultCategory2.getL10nName(mockL10n))
        .thenReturn('Background (Default)');
    when(defaultCategory2.defaultValue).thenReturn(mockDefaultItem2);
    when(defaultCategory2.properties).thenReturn([mockDefaultItem2]);
    when(defaultCategory2.toDisplay).thenReturn(true);
    when(defaultCategory2.iconFile).thenReturn('icon2.svg');
  });

  group('PropertyCategoryService', () {
    group('getPropertyCategoryById', () {
      late MockCustomizedPropertyCategory mockSearched;
      late MockCustomizedPropertyCategory mockOther;

      setUp(() {
        mockSearched = MockCustomizedPropertyCategory();
        when(mockSearched.id).thenReturn(PropertyCategoryIds.Accessory);
        mockOther = MockCustomizedPropertyCategory();
        when(mockOther.id).thenReturn(PropertyCategoryIds.Background);
      });

      test('should return the category matching the provided id', () {
        // Arrange
        final List<CustomizedPropertyCategory> categories = [
          mockOther,
          mockSearched
        ];

        // Act
        final result = PropertyCategoryService.getPropertyCategoryById(
            categories, PropertyCategoryIds.Accessory);

        // Assert
        expect(result, equals(mockSearched));
      });
    });

    group('mergePropertyCategories', () {
      test(
          'should return default categories if customized list is null or empty',
          () {
        // Act
        final result =
            PropertyCategoryService.mergePropertyCategories(null, mockL10n);

        // Assert
        expect(result.length, 13);

        expect(result.first.id, equals(PropertyCategoryIds.HairStyle));
        expect(result.first.name, equals('Hairstyles'));
      });

      test(
          'should correctly merge customized categories and keep non-customized defaults',
          () {
        // Arrange
        final MockCustomizedPropertyCategory customCategory2 =
            MockCustomizedPropertyCategory();
        when(customCategory2.id).thenReturn(PropertyCategoryIds.Background);
        when(customCategory2.name).thenReturn('Custom Background Name');
        when(customCategory2.properties).thenReturn(
            [mockCustomItem, mockDefaultItem2]); // Nouvelle liste de props
        when(customCategory2.defaultValue)
            .thenReturn(mockDefaultItem2); // Défaut dans la nouvelle liste
        when(customCategory2.toDisplay).thenReturn(false);
        when(customCategory2.iconFile).thenReturn('custom_icon.svg');

        final List<CustomizedPropertyCategory> customizedList = [
          customCategory2
        ];

        // Act
        final result = PropertyCategoryService.mergePropertyCategories(
            customizedList, mockL10n);

        // Assert
        expect(result.length, 13);

        final accessoryResult =
            result.firstWhere((e) => e.id == PropertyCategoryIds.Accessory);
        expect(accessoryResult.name, equals('Accessories'));
        expect(accessoryResult.properties!.length, 7);
        expect(
            accessoryResult.iconFile, equals('assets/icons/accessories.svg'));

        final backgroundResult =
            result.firstWhere((e) => e.id == PropertyCategoryIds.Background);
        expect(backgroundResult.name, equals('Custom Background Name'));
        expect(backgroundResult.toDisplay, isFalse);
        expect(backgroundResult.properties!.first, equals(mockCustomItem));
        expect(backgroundResult.iconFile, equals('custom_icon.svg'));
      });

      test(
          'should throw ArgumentError if customized defaultValue is not in the customized properties list',
          () {
        // Arrange
        final MockCustomizedPropertyCategory customCategory2 =
            MockCustomizedPropertyCategory();
        when(customCategory2.id).thenReturn(PropertyCategoryIds.Background);
        when(customCategory2.properties)
            .thenReturn([mockCustomItem]); // Liste SANS mockDefaultItem2
        when(customCategory2.defaultValue)
            .thenReturn(mockDefaultItem2); // Défaut MANQUANT dans la liste

        final List<CustomizedPropertyCategory> customizedList = [
          customCategory2
        ];

        // Act & Assert
        expect(
          () => PropertyCategoryService.mergePropertyCategories(
              customizedList, mockL10n),
          throwsA(isA<ArgumentError>()),
        );
      });
    });
  });
}
