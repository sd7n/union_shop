import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/cart_item.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('CartItem', () {
    final testProduct = Product(
      id: 'prod1',
      name: 'Test T-Shirt',
      description: 'A test t-shirt',
      price: 19.99,
      imageUrl: 'https://example.com/tshirt.jpg',
      isLocalImage: false,
      collectionId: 'clothing',
      sizes: ['S', 'M', 'L', 'XL'],
    );

    test('should create CartItem with required fields', () {
      final cartItem = CartItem(
        product: testProduct,
        quantity: 1,
      );

      expect(cartItem.product, testProduct);
      expect(cartItem.quantity, 1);
      expect(cartItem.size, isNull);
    });

    test('should create CartItem with size', () {
      final cartItem = CartItem(
        product: testProduct,
        quantity: 2,
        size: 'M',
      );

      expect(cartItem.product, testProduct);
      expect(cartItem.quantity, 2);
      expect(cartItem.size, 'M');
    });

    test('totalPrice should calculate correctly for quantity 1', () {
      final cartItem = CartItem(
        product: testProduct,
        quantity: 1,
      );

      expect(cartItem.totalPrice, 19.99);
    });

    test('totalPrice should calculate correctly for quantity 2', () {
      final cartItem = CartItem(
        product: testProduct,
        quantity: 2,
      );

      expect(cartItem.totalPrice, 39.98);
    });

    test('totalPrice should calculate correctly for quantity 5', () {
      final cartItem = CartItem(
        product: testProduct,
        quantity: 5,
      );

      expect(cartItem.totalPrice, closeTo(99.95, 0.01));
    });

    test('totalPrice should be 0 when quantity is 0', () {
      final cartItem = CartItem(
        product: testProduct,
        quantity: 0,
      );

      expect(cartItem.totalPrice, 0.0);
    });

    test('should update quantity', () {
      final cartItem = CartItem(
        product: testProduct,
        quantity: 1,
      );

      cartItem.quantity = 3;

      expect(cartItem.quantity, 3);
      expect(cartItem.totalPrice, closeTo(59.97, 0.01));
    });

    test('toJson should serialize correctly without size', () {
      final cartItem = CartItem(
        product: testProduct,
        quantity: 2,
      );

      final json = cartItem.toJson();

      expect(json['productId'], 'prod1');
      expect(json['quantity'], 2);
      expect(json['size'], isNull);
    });

    test('toJson should serialize correctly with size', () {
      final cartItem = CartItem(
        product: testProduct,
        quantity: 3,
        size: 'L',
      );

      final json = cartItem.toJson();

      expect(json['productId'], 'prod1');
      expect(json['quantity'], 3);
      expect(json['size'], 'L');
    });

    test('fromJson should deserialize correctly without size', () {
      final json = {
        'productId': 'prod1',
        'quantity': 2,
        'size': null,
      };

      final cartItem = CartItem.fromJson(json, testProduct);

      expect(cartItem.product.id, 'prod1');
      expect(cartItem.quantity, 2);
      expect(cartItem.size, isNull);
    });

    test('fromJson should deserialize correctly with size', () {
      final json = {
        'productId': 'prod1',
        'quantity': 3,
        'size': 'XL',
      };

      final cartItem = CartItem.fromJson(json, testProduct);

      expect(cartItem.product.id, 'prod1');
      expect(cartItem.quantity, 3);
      expect(cartItem.size, 'XL');
    });

    test('copyWith should create new instance with updated quantity', () {
      final original = CartItem(
        product: testProduct,
        quantity: 1,
        size: 'M',
      );

      final updated = original.copyWith(quantity: 5);

      expect(updated.quantity, 5);
      expect(updated.size, 'M');
      expect(updated.product, testProduct);
      expect(original.quantity, 1); // Original unchanged
    });

    test('copyWith should create new instance with updated size', () {
      final original = CartItem(
        product: testProduct,
        quantity: 2,
        size: 'S',
      );

      final updated = original.copyWith(size: 'XL');

      expect(updated.size, 'XL');
      expect(updated.quantity, 2);
      expect(updated.product, testProduct);
    });

    test('copyWith should preserve original values when not provided', () {
      final original = CartItem(
        product: testProduct,
        quantity: 3,
        size: 'L',
      );

      final updated = original.copyWith();

      expect(updated.quantity, 3);
      expect(updated.size, 'L');
      expect(updated.product, testProduct);
    });

    test('copyWith should handle changing product', () {
      final newProduct = Product(
        id: 'prod2',
        name: 'New Product',
        description: 'A different product',
        price: 29.99,
        imageUrl: 'https://example.com/new.jpg',
        isLocalImage: false,
        collectionId: 'clothing',
        sizes: ['M'],
      );

      final original = CartItem(
        product: testProduct,
        quantity: 1,
      );

      final updated = original.copyWith(product: newProduct);

      expect(updated.product, newProduct);
      expect(updated.product.id, 'prod2');
    });

    test('toString should format correctly without size', () {
      final cartItem = CartItem(
        product: testProduct,
        quantity: 2,
      );

      final result = cartItem.toString();

      expect(result, contains('Test T-Shirt'));
      expect(result, contains('2'));
      expect(result, contains('39.98'));
      expect(result, contains('null'));
    });

    test('toString should format correctly with size', () {
      final cartItem = CartItem(
        product: testProduct,
        quantity: 1,
        size: 'L',
      );

      final result = cartItem.toString();

      expect(result, contains('Test T-Shirt'));
      expect(result, contains('1'));
      expect(result, contains('L'));
      expect(result, contains('19.99'));
    });

    test('should handle large quantities', () {
      final cartItem = CartItem(
        product: testProduct,
        quantity: 100,
      );

      expect(cartItem.quantity, 100);
      expect(cartItem.totalPrice, closeTo(1999.0, 0.01));
    });

    test('should handle products with decimal prices', () {
      final product = Product(
        id: 'prod3',
        name: 'Decimal Product',
        description: 'Product with decimal price',
        price: 15.49,
        imageUrl: 'https://example.com/decimal.jpg',
        isLocalImage: false,
        collectionId: 'test',
        sizes: ['M'],
      );

      final cartItem = CartItem(
        product: product,
        quantity: 3,
      );

      expect(cartItem.totalPrice, closeTo(46.47, 0.01));
    });

    test('toJson and fromJson should be reversible', () {
      final original = CartItem(
        product: testProduct,
        quantity: 4,
        size: 'XL',
      );

      final json = original.toJson();
      final reconstructed = CartItem.fromJson(json, testProduct);

      expect(reconstructed.product.id, original.product.id);
      expect(reconstructed.quantity, original.quantity);
      expect(reconstructed.size, original.size);
    });

    test('should handle CartItem with zero-priced product', () {
      final freeProduct = Product(
        id: 'free1',
        name: 'Free Item',
        description: 'A free product',
        price: 0.0,
        imageUrl: 'https://example.com/free.jpg',
        isLocalImage: false,
        collectionId: 'promo',
        sizes: ['One Size'],
      );

      final cartItem = CartItem(
        product: freeProduct,
        quantity: 5,
      );

      expect(cartItem.totalPrice, 0.0);
    });

    test('should handle all available sizes', () {
      final sizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL'];
      
      for (final size in sizes) {
        final cartItem = CartItem(
          product: testProduct,
          quantity: 1,
          size: size,
        );

        expect(cartItem.size, size);
      }
    });

    test('should handle product with sale price', () {
      final saleProduct = Product(
        id: 'sale1',
        name: 'Sale Product',
        description: 'Product on sale',
        price: 14.99,
        strikePrice: 24.99,
        imageUrl: 'https://example.com/sale.jpg',
        isLocalImage: false,
        collectionId: 'sale',
        sizes: ['M'],
      );

      final cartItem = CartItem(
        product: saleProduct,
        quantity: 2,
      );

      // Total should use current price, not strike price
      expect(cartItem.totalPrice, closeTo(29.98, 0.01));
    });
  });
}
