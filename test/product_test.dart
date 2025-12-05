import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/data_service.dart';

void main() {
  group('Product Page Logic Tests', () {
    test('should get product by ID', () {
      final data = DataService.instance;
      final product = data.products.first;

      expect(product, isNotNull);
      expect(product.id, isNotEmpty);
      expect(product.name, isNotEmpty);
    });

    test('products should have required fields', () {
      final data = DataService.instance;
      
      for (var product in data.products) {
        expect(product.id, isNotEmpty);
        expect(product.name, isNotEmpty);
        expect(product.price, greaterThan(0));
        expect(product.imageUrl, isNotEmpty);
      }
    });

    test('products should belong to collections', () {
      final data = DataService.instance;
      final collectionIds = data.collections.map((c) => c.id).toSet();
      
      for (var product in data.products) {
        expect(collectionIds.contains(product.collectionId), isTrue);
      }
    });

    test('should find products by collection', () {
      final data = DataService.instance;
      final firstCollection = data.collections.first;
      final products = data.products
          .where((p) => p.collectionId == firstCollection.id)
          .toList();

      expect(products, isNotEmpty);
    });
  });
}
