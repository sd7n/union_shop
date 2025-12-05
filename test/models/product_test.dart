import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('Product', () {
    test('should create Product with required fields only', () {
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
      expect(product.description, 'A test t-shirt');
      expect(product.price, 19.99);
      expect(product.imageUrl, 'https://example.com/image.jpg');
      expect(product.isLocalImage, false);
      expect(product.collectionId, 'clothing');
      expect(product.sizes, ['S', 'M', 'L']);
      expect(product.strikePrice, isNull);
      expect(product.images, isNull);
      expect(product.colors, isNull);
      expect(product.externalUrl, isNull);
    });

    test('should create Product with all fields', () {
      final product = Product(
        id: 'prod1',
        name: 'Test T-Shirt',
        description: 'A test t-shirt',
        price: 19.99,
        strikePrice: 29.99,
        imageUrl: 'https://example.com/image.jpg',
        isLocalImage: false,
        collectionId: 'clothing',
        sizes: ['S', 'M', 'L', 'XL'],
        images: ['image1.jpg', 'image2.jpg'],
        colors: ['Red', 'Blue', 'Green'],
        externalUrl: 'https://shop.example.com/product1',
      );

      expect(product.id, 'prod1');
      expect(product.name, 'Test T-Shirt');
      expect(product.description, 'A test t-shirt');
      expect(product.price, 19.99);
      expect(product.strikePrice, 29.99);
      expect(product.imageUrl, 'https://example.com/image.jpg');
      expect(product.isLocalImage, false);
      expect(product.collectionId, 'clothing');
      expect(product.sizes, ['S', 'M', 'L', 'XL']);
      expect(product.images, ['image1.jpg', 'image2.jpg']);
      expect(product.colors, ['Red', 'Blue', 'Green']);
      expect(product.externalUrl, 'https://shop.example.com/product1');
    });

    test('should create Product with local image', () {
      final product = Product(
        id: 'prod2',
        name: 'Local Product',
        description: 'Product with local image',
        price: 15.99,
        imageUrl: 'assets/images/product.png',
        isLocalImage: true,
        collectionId: 'merchandise',
        sizes: ['One Size'],
      );

      expect(product.isLocalImage, true);
      expect(product.imageUrl, 'assets/images/product.png');
    });

    test('should handle empty sizes list', () {
      final product = Product(
        id: 'prod3',
        name: 'No Size Product',
        description: 'Product without sizes',
        price: 9.99,
        imageUrl: 'https://example.com/image.jpg',
        isLocalImage: false,
        collectionId: 'accessories',
        sizes: [],
      );

      expect(product.sizes, isEmpty);
    });

    test('should handle single size', () {
      final product = Product(
        id: 'prod4',
        name: 'One Size Product',
        description: 'Product with one size',
        price: 12.99,
        imageUrl: 'https://example.com/image.jpg',
        isLocalImage: false,
        collectionId: 'accessories',
        sizes: ['One Size'],
      );

      expect(product.sizes, hasLength(1));
      expect(product.sizes.first, 'One Size');
    });

    test('should handle multiple colors', () {
      final product = Product(
        id: 'prod5',
        name: 'Colorful Product',
        description: 'Product with colors',
        price: 24.99,
        imageUrl: 'https://example.com/image.jpg',
        isLocalImage: false,
        collectionId: 'clothing',
        sizes: ['M'],
        colors: ['Red', 'Blue', 'Green', 'Yellow', 'Black'],
      );

      expect(product.colors, hasLength(5));
      expect(product.colors, contains('Red'));
      expect(product.colors, contains('Black'));
    });

    test('should handle multiple images', () {
      final product = Product(
        id: 'prod6',
        name: 'Multi-Image Product',
        description: 'Product with multiple images',
        price: 39.99,
        imageUrl: 'https://example.com/main.jpg',
        isLocalImage: false,
        collectionId: 'clothing',
        sizes: ['S', 'M', 'L'],
        images: [
          'https://example.com/image1.jpg',
          'https://example.com/image2.jpg',
          'https://example.com/image3.jpg',
        ],
      );

      expect(product.images, hasLength(3));
      expect(product.images!.first, 'https://example.com/image1.jpg');
    });

    test('should handle zero price', () {
      final product = Product(
        id: 'free1',
        name: 'Free Product',
        description: 'A free product',
        price: 0.0,
        imageUrl: 'https://example.com/image.jpg',
        isLocalImage: false,
        collectionId: 'promo',
        sizes: ['One Size'],
      );

      expect(product.price, 0.0);
    });

    test('should handle strikePrice greater than price (sale)', () {
      final product = Product(
        id: 'sale1',
        name: 'Sale Product',
        description: 'A product on sale',
        price: 15.99,
        strikePrice: 25.99,
        imageUrl: 'https://example.com/image.jpg',
        isLocalImage: false,
        collectionId: 'sale',
        sizes: ['S', 'M', 'L'],
      );

      expect(product.price, lessThan(product.strikePrice!));
      expect(product.strikePrice, 25.99);
    });

    test('toString should return correct format', () {
      final product = Product(
        id: 'prod1',
        name: 'Test Product',
        description: 'Test description',
        price: 19.99,
        imageUrl: 'https://example.com/image.jpg',
        isLocalImage: false,
        collectionId: 'test-collection',
        sizes: ['M'],
      );

      final result = product.toString();

      expect(result, contains('prod1'));
      expect(result, contains('Test Product'));
      expect(result, contains('19.99'));
      expect(result, contains('test-collection'));
    });

    test('should handle special characters in name and description', () {
      final product = Product(
        id: 'prod7',
        name: 'T-Shirt & Hoodie "Special"',
        description: 'Product with special chars: £, €, ©',
        price: 29.99,
        imageUrl: 'https://example.com/image.jpg',
        isLocalImage: false,
        collectionId: 'clothing',
        sizes: ['M'],
      );

      expect(product.name, contains('&'));
      expect(product.name, contains('"'));
      expect(product.description, contains('£'));
      expect(product.description, contains('€'));
    });

    test('should handle external URL', () {
      final product = Product(
        id: 'ext1',
        name: 'External Product',
        description: 'Product sold externally',
        price: 49.99,
        imageUrl: 'https://example.com/image.jpg',
        isLocalImage: false,
        collectionId: 'external',
        sizes: ['M'],
        externalUrl: 'https://external-shop.com/product',
      );

      expect(product.externalUrl, isNotNull);
      expect(product.externalUrl, startsWith('https://'));
    });

    test('Product should be const constructible', () {
      const product = Product(
        id: 'const1',
        name: 'Const Product',
        description: 'A const product',
        price: 19.99,
        imageUrl: 'https://example.com/image.jpg',
        isLocalImage: false,
        collectionId: 'test',
        sizes: ['M'],
      );

      expect(product.id, 'const1');
      expect(product.name, 'Const Product');
    });

    test('should handle very long description', () {
      final longDesc = 'A' * 1000; // 1000 character description
      final product = Product(
        id: 'long1',
        name: 'Long Description Product',
        description: longDesc,
        price: 19.99,
        imageUrl: 'https://example.com/image.jpg',
        isLocalImage: false,
        collectionId: 'test',
        sizes: ['M'],
      );

      expect(product.description.length, 1000);
    });

    test('should handle decimal prices with precision', () {
      final product = Product(
        id: 'precise1',
        name: 'Precise Price Product',
        description: 'Product with precise price',
        price: 19.999999,
        imageUrl: 'https://example.com/image.jpg',
        isLocalImage: false,
        collectionId: 'test',
        sizes: ['M'],
      );

      expect(product.price, isA<double>());
      expect(product.price, 19.999999);
    });
  });
}
