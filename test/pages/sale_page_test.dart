import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/data_service.dart';

void main() {
  group('SalePage Logic Tests', () {
    test('should filter products with strikePrice for sale items', () {
      final data = DataService.instance;
      final saleProducts = data.products.where((p) => p.strikePrice != null).toList();

      expect(saleProducts.isNotEmpty, isTrue);
      for (var product in saleProducts) {
        expect(product.strikePrice, isNotNull);
      }
    });

    test('should sort products by price low to high', () {
      final data = DataService.instance;
      var products = data.products.where((p) => p.strikePrice != null).toList();
      products.sort((a, b) => a.price.compareTo(b.price));

      for (int i = 0; i < products.length - 1; i++) {
        expect(products[i].price, lessThanOrEqualTo(products[i + 1].price));
      }
    });

    test('should sort products by price high to low', () {
      final data = DataService.instance;
      var products = data.products.where((p) => p.strikePrice != null).toList();
      products.sort((a, b) => b.price.compareTo(a.price));

      for (int i = 0; i < products.length - 1; i++) {
        expect(products[i].price, greaterThanOrEqualTo(products[i + 1].price));
      }
    });
  });
}
