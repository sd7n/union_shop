import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/data_service.dart';

void main() {
  group('ProductPage Logic', () {
    test('Product can be retrieved by ID', () {
      final products = DataService.instance.products;
      
      expect(products.isNotEmpty, isTrue);
      
      final product = products.first;
      final foundProduct = products.firstWhere((p) => p.id == product.id);
      
      expect(foundProduct.id, equals(product.id));
    });

    test('Product has required fields', () {
      final products = DataService.instance.products;
      final product = products.first;
      
      expect(product.id, isNotEmpty);
      expect(product.name, isNotEmpty);
      expect(product.price, greaterThan(0));
      expect(product.imageUrl, isNotEmpty);
    });

    test('Product colors list is valid', () {
      final products = DataService.instance.products;
      
      for (var product in products) {
        if (product.colors != null) {
          expect(product.colors!.isNotEmpty, isTrue);
          expect(product.colors!.every((c) => c.isNotEmpty), isTrue);
        }
      }
    });

    test('Product sizes list is valid', () {
      final products = DataService.instance.products;
      
      for (var product in products) {
        expect(product.sizes, isNotNull);
        if (product.sizes.isNotEmpty) {
          expect(product.sizes.every((s) => s.isNotEmpty), isTrue);
        }
      }
    });
  });
}
