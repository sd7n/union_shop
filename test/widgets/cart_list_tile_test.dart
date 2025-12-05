import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/cart_item.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('CartListTile Logic Tests', () {
    final testProduct = Product(
      id: 'test-1',
      name: 'Test Product',
      description: 'Description',
      price: 19.99,
      imageUrl: 'test.jpg',
      isLocalImage: true,
      collectionId: 'test',
      sizes: ['S', 'M', 'L'],
    );

    test('CartItem should calculate total price', () {
      final cartItem = CartItem(
        product: testProduct,
        quantity: 2,
        size: 'L',
      );

      expect(cartItem.totalPrice, 19.99 * 2);
      expect(cartItem.size, 'L');
      expect(cartItem.quantity, 2);
    });

    test('CartItem without size', () {
      final cartItem = CartItem(
        product: testProduct,
        quantity: 3,
      );

      expect(cartItem.totalPrice, 19.99 * 3);
      expect(cartItem.size, isNull);
      expect(cartItem.quantity, 3);
    });

    test('CartItem with different quantities', () {
      final item1 = CartItem(product: testProduct, quantity: 1);
      final item5 = CartItem(product: testProduct, quantity: 5);

      expect(item1.totalPrice, 19.99);
      expect(item5.totalPrice, 19.99 * 5);
    });
  });
}
