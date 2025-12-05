import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/data_service.dart';

void main() {
  group('DataService', () {
    late DataService dataService;

    setUp(() {
      dataService = DataService.instance;
    });

    test('should be a singleton', () {
      final instance1 = DataService.instance;
      final instance2 = DataService.instance;

      expect(identical(instance1, instance2), true);
    });

    test('should have collections loaded', () {
      expect(dataService.collections, isNotEmpty);
      expect(dataService.collections.length, greaterThan(0));
    });

    test('should have products loaded', () {
      expect(dataService.products, isNotEmpty);
      expect(dataService.products.length, greaterThan(0));
    });

    test('should have appData initialized', () {
      expect(dataService.appData, isNotNull);
      expect(dataService.appData.collections, isNotEmpty);
      expect(dataService.appData.products, isNotEmpty);
    });

    test('collections should have valid structure', () {
      for (final collection in dataService.collections) {
        expect(collection.id, isNotEmpty);
        expect(collection.name, isNotEmpty);
        expect(collection.imageUrl, isNotEmpty);
      }
    });

    test('products should have valid structure', () {
      for (final product in dataService.products) {
        expect(product.id, isNotEmpty);
        expect(product.name, isNotEmpty);
        expect(product.price, greaterThanOrEqualTo(0));
        expect(product.collectionId, isNotEmpty);
      }
    });

    test('all products should belong to existing collections', () {
      final collectionIds = dataService.collections.map((c) => c.id).toSet();

      for (final product in dataService.products) {
        expect(collectionIds.contains(product.collectionId), true,
            reason: 'Product ${product.id} has invalid collectionId: ${product.collectionId}');
      }
    });

    test('appData should provide access to collections and products', () {
      expect(dataService.appData.collections, equals(dataService.collections));
      expect(dataService.appData.products, equals(dataService.products));
    });
  });
}
