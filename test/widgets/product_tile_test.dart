import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('ProductTile Logic', () {
    test('Product with strike price shows discount', () {
      final product = Product(
        id: '1',
        name: 'Test Product',
        price: 19.99,
        strikePrice: 29.99,
        imageUrl: 'assets/test.png',
        description: 'Test',
        collectionId: '1',
        isLocalImage: true,
        sizes: ['S', 'M', 'L'],
      );

      expect(product.strikePrice, 29.99);
      expect(product.price, lessThan(product.strikePrice!));
    });

    test('Product without strike price has no discount', () {
      final product = Product(
        id: '1',
        name: 'Regular Product',
        price: 19.99,
        imageUrl: 'assets/test.png',
        description: 'Test',
        collectionId: '1',
        isLocalImage: true,
        sizes: ['S', 'M', 'L'],
      );

      expect(product.strikePrice, isNull);
    });

    test('Product with local image uses asset path', () {
      final product = Product(
        id: '1',
        name: 'Local Image Product',
        price: 19.99,
        imageUrl: 'assets/test.png',
        description: 'Test',
        collectionId: '1',
        isLocalImage: true,
        sizes: ['S', 'M', 'L'],
      );

      expect(product.isLocalImage, isTrue);
      expect(product.imageUrl, startsWith('assets/'));
    });

    test('Product price formatting is correct', () {
      final product = Product(
        id: '1',
        name: 'Test Product',
        price: 19.99,
        imageUrl: 'assets/test.png',
        description: 'Test',
        collectionId: '1',
        isLocalImage: true,
        sizes: ['S', 'M', 'L'],
      );

      final formatted = product.price.toStringAsFixed(2);
      expect(formatted, '19.99');
    });
  });
}
