import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:avatar_maker/avatar_maker.dart';
import 'package:avatar_maker/src/core/services/options_service.dart';
import 'package:avatar_maker/src/core/services/property_category_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<PropertyItem>(),
  MockSpec<CustomizedPropertyCategory>(),
  MockSpec<PropertyCategoryService>(), // Pour mocker la méthode statique
])
import 'options_service_test.mocks.dart';

// --- Données de Test ---
const String tAccessoryLabel = 'sunglasses';
const String tBackgroundLabel = 'gradient';
const PropertyCategoryIds tAccessoryId = PropertyCategoryIds.Accessory;
const PropertyCategoryIds tBackgroundId = PropertyCategoryIds.Background;
const String tEncodedJson =
    '{"Accessory":"sunglasses","Background":"gradient"}';

void main() {
  late MockPropertyItem mockAccessoryItem;
  late MockPropertyItem mockBackgroundItem;
  late MockCustomizedPropertyCategory mockAccessoryCategory;
  late MockCustomizedPropertyCategory mockBackgroundCategory;

  setUp(() {
    mockAccessoryItem = MockPropertyItem();
    when(mockAccessoryItem.label).thenReturn(tAccessoryLabel);

    mockBackgroundItem = MockPropertyItem();
    when(mockBackgroundItem.label).thenReturn(tBackgroundLabel);

    mockAccessoryCategory = MockCustomizedPropertyCategory();
    when(mockAccessoryCategory.id).thenReturn(tAccessoryId);
    when(mockAccessoryCategory.properties).thenReturn([mockAccessoryItem]);

    mockBackgroundCategory = MockCustomizedPropertyCategory();
    when(mockBackgroundCategory.id).thenReturn(tBackgroundId);
    when(mockBackgroundCategory.properties).thenReturn([mockBackgroundItem]);
  });

  group('OptionsService', () {
    group('jsonEncodeSelectedOptions', () {
      test('should correctly encode selected options map to a JSON string', () {
        // Arrange
        final Map<PropertyCategoryIds, PropertyItem> selectedOptions = {
          tAccessoryId: mockAccessoryItem,
          tBackgroundId: mockBackgroundItem,
        };

        // Act
        final String encodedResult =
            OptionsService.jsonEncodeSelectedOptions(selectedOptions);

        // Assert
        expect(encodedResult, equals(tEncodedJson));
      });

      test('should return an empty JSON object for an empty map', () {
        // Arrange
        final Map<PropertyCategoryIds, PropertyItem> selectedOptions = {};

        // Act
        final String encodedResult =
            OptionsService.jsonEncodeSelectedOptions(selectedOptions);

        // Assert
        expect(encodedResult, equals("{}"));
      });
    });

    group('jsonDecodeSelectedOptions', () {
      test(
          'should correctly decode JSON string back to Map<PropertyCategoryIds, PropertyItem>',
          () {
        // Arrange
        final List<CustomizedPropertyCategory> propertyCategories = [
          mockAccessoryCategory,
          mockBackgroundCategory
        ];

        // Act
        final Map<PropertyCategoryIds, PropertyItem> decodedResult =
            OptionsService.jsonDecodeSelectedOptions(
          propertyCategories,
          tEncodedJson,
        );

        // Assert
        expect(decodedResult.length, 2);

        expect(decodedResult.containsKey(tAccessoryId), isTrue);
        expect(decodedResult.containsKey(tBackgroundId), isTrue);

        expect(decodedResult[tAccessoryId], equals(mockAccessoryItem));
        expect(decodedResult[tBackgroundId], equals(mockBackgroundItem));
      });

      test('should handle empty JSON string', () {
        // Arrange
        final List<CustomizedPropertyCategory> propertyCategories = [];
        const String tEmptyJson = '{}';

        // Act
        final Map<PropertyCategoryIds, PropertyItem> decodedResult =
            OptionsService.jsonDecodeSelectedOptions(
          propertyCategories,
          tEmptyJson,
        );

        // Assert
        expect(decodedResult, isEmpty);
      });

      test('should throw if a category ID is not recognized', () async {
        // Arrange
        final List<CustomizedPropertyCategory> propertyCategories = [];
        const String tInvalidJson = '{"NonExistentId":"value"}';

        // Act & Assert
        expect(
          () => OptionsService.jsonDecodeSelectedOptions(
              propertyCategories, tInvalidJson),
          throwsA(isA<StateError>()),
        );
      });
    });
  });
}
