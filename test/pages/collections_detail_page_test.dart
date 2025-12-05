import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/data_service.dart';

void main() {
  group('CollectionDetailPage Logic Tests', () {
    test('should get products for a collection', () {
      final data = DataService.instance;
      final hoodieProducts = data.products.where((p) => p.collectionId == 'hoodies').toList();

      expect(hoodieProducts, isNotEmpty);
      for (var product in hoodieProducts) {
        expect(product.collectionId, 'hoodies');
      }
    });

    test('should filter products by collection ID', () {
      final data = DataService.instance;
      const testCollectionId = 'tshirts';
      final products = data.products.where((p) => p.collectionId == testCollectionId).toList();

      for (var product in products) {
        expect(product.collectionId, testCollectionId);
      }
    });

    test('should get collection by ID', () {
      final data = DataService.instance;
      final collection = data.collections.firstWhere((c) => c.id == 'hoodies');

      expect(collection, isNotNull);
      expect(collection.id, 'hoodies');
      expect(collection.name, isNotEmpty);
    });
  });
}
