import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/data_service.dart';

void main() {
  group('Home Page Logic Tests', () {
    test('should load products from DataService', () {
      final data = DataService.instance;
      final products = data.products;

      expect(products, isNotEmpty);
      expect(products.length, greaterThan(0));
    });

    test('should load collections from DataService', () {
      final data = DataService.instance;
      final collections = data.collections;

      expect(collections, isNotEmpty);
      expect(collections.length, greaterThan(0));
    });



    test('products should have valid prices', () {
      final data = DataService.instance;
      
      for (var product in data.products) {
        expect(product.price, greaterThan(0));
        if (product.strikePrice != null) {
          expect(product.strikePrice, greaterThan(product.price));
        }
      }
    });
  });
}
