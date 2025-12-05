import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('Product', () {
    test('should create Product with required fields', () {
      final product = Product(
        id: 'prod1',
        name: 'Test T-Shirt',
        description: 'A test t-shirt',
        price: 19.99,
        imageUrl: 'https://example.com/image.jpg',
        isLocalImage: false,
        collectionId: 'clothing',
        sizes: ['S', 'M', 'L'],
      );

      expect(product.id, 'prod1');
      expect(product.name, 'Test T-Shirt');
      expect(product.price, 19.99);
    });

    test('should create Product with optional fields', () {
      final product = Product(
        id: 'prod2',
        name: 'Sale T-Shirt',
        description: 'On sale',
        price: 15.99,
        strikePrice: 25.99,
        imageUrl: 'https://example.com/image.jpg',
        isLocalImage: false,
        collectionId: 'sale',
        sizes: ['S', 'M'],
        colors: ['Red', 'Blue'],
      );

      expect(product.strikePrice, 25.99);
      expect(product.colors, isNotNull);
    });

    test('should handle local images', () {
      final product = Product(
        id: 'prod3',
        name: 'Local Product',
        description: 'With local image',
        price: 10.00,
        imageUrl: 'assets/images/product.png',
        isLocalImage: true,
        collectionId: 'test',
        sizes: ['M'],
      );

      expect(product.isLocalImage, true);
    });

    test('should have valid price', () {
      final product = Product(
        id: 'prod4',
        name: 'Product',
        description: 'Test',
        price: 29.99,
        imageUrl: 'url',
        isLocalImage: false,
        collectionId: 'test',
        sizes: ['M'],
      );

      expect(product.price, greaterThan(0));
    });

    test('strikePrice should be greater than price for sales', () {
      final product = Product(
        id: 'sale1',
        name: 'Sale Item',
        description: 'On sale',
        price: 15.00,
        strikePrice: 20.00,
        imageUrl: 'url',
        isLocalImage: false,
        collectionId: 'sale',
        sizes: ['M'],
      );

      expect(product.strikePrice!, greaterThan(product.price));
    });
  });
}
