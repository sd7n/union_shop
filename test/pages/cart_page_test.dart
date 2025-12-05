import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('CartPage Logic Tests', () {
    final testProduct1 = Product(
      id: 'test-1',
      name: 'Test Product 1',
      description: 'Description',
      price: 10.00,
      imageUrl: 'test.jpg',
      isLocalImage: true,
      collectionId: 'test',
      sizes: ['S', 'M'],
    );

    final testProduct2 = Product(
      id: 'test-2',
      name: 'Test Product 2',
      description: 'Description',
      price: 20.00,
      imageUrl: 'test.jpg',
      isLocalImage: true,
      collectionId: 'test',
      sizes: ['L'],
    );

    test('should calculate cart total correctly', () {
      final cart = Cart();
      cart.addItem(testProduct1, 2, null);
      cart.addItem(testProduct2, 1, null);

      final expectedTotal = (10.00 * 2) + (20.00 * 1);
      expect(cart.total, expectedTotal);
    });

    test('should calculate item count correctly', () {
      final cart = Cart();
      cart.addItem(testProduct1, 2, 'M');
      cart.addItem(testProduct2, 3, 'L');

      expect(cart.itemCount, 5);
    });

    test('should remove item from cart', () {
      final cart = Cart();
      cart.addItem(testProduct1, 1, null);
      expect(cart.items.length, 1);

      cart.removeItem(testProduct1.id, null);
      expect(cart.items.length, 0);
    });

    test('should clear cart', () {
      final cart = Cart();
      cart.addItem(testProduct1, 1, null);
      cart.addItem(testProduct2, 1, null);
      expect(cart.items.length, 2);

      cart.clear();
      expect(cart.items.length, 0);
      expect(cart.total, 0.0);
    });
  });
}
