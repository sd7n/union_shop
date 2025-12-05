import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/providers/cart_provider.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/models/cart_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('CartProvider', () {
    late CartProvider cartProvider;
    late Product testProduct1;
    late Product testProduct2;

    setUp(() async {
      // Initialize shared preferences with empty data
      SharedPreferences.setMockInitialValues({});
      
      cartProvider = CartProvider();
      await Future.delayed(const Duration(milliseconds: 100)); // Wait for async init

      testProduct1 = const Product(
        id: 'prod1',
        name: 'T-Shirt',
        description: 'A t-shirt',
        price: 19.99,
        imageUrl: 'https://example.com/tshirt.jpg',
        isLocalImage: false,
        collectionId: 'clothing',
        sizes: ['S', 'M', 'L'],
      );

      testProduct2 = const Product(
        id: 'prod2',
        name: 'Hoodie',
        description: 'A hoodie',
        price: 39.99,
        imageUrl: 'https://example.com/hoodie.jpg',
        isLocalImage: false,
        collectionId: 'clothing',
        sizes: ['M', 'L', 'XL'],
      );
    });

    test('should initialize with empty cart', () {
      expect(cartProvider.cart.items, isEmpty);
      expect(cartProvider.cart.total, 0.0);
      expect(cartProvider.cart.itemCount, 0);
    });

    test('add should add item to cart', () {
      cartProvider.add(testProduct1, 1, 'M');

      expect(cartProvider.cart.items.length, 1);
      expect(cartProvider.cart.items.first.product.id, 'prod1');
      expect(cartProvider.cart.items.first.quantity, 1);
      expect(cartProvider.cart.items.first.size, 'M');
    });

    test('add should trigger notifyListeners', () {
      var notified = false;
      cartProvider.addListener(() => notified = true);

      cartProvider.add(testProduct1, 1, 'M');

      expect(notified, true);
    });

    test('add should combine same product and size', () {
      cartProvider.add(testProduct1, 1, 'M');
      cartProvider.add(testProduct1, 2, 'M');

      expect(cartProvider.cart.items.length, 1);
      expect(cartProvider.cart.items.first.quantity, 3);
    });

    test('add should create separate items for different sizes', () {
      cartProvider.add(testProduct1, 1, 'M');
      cartProvider.add(testProduct1, 1, 'L');

      expect(cartProvider.cart.items.length, 2);
    });

    test('remove should remove item from cart', () {
      cartProvider.add(testProduct1, 1, 'M');
      final item = cartProvider.cart.items.first;

      cartProvider.remove(item);

      expect(cartProvider.cart.items, isEmpty);
    });

    test('remove should trigger notifyListeners', () {
      cartProvider.add(testProduct1, 1, 'M');
      final item = cartProvider.cart.items.first;

      var notified = false;
      cartProvider.addListener(() => notified = true);

      cartProvider.remove(item);

      expect(notified, true);
    });

    test('remove should only remove matching item', () {
      cartProvider.add(testProduct1, 1, 'M');
      cartProvider.add(testProduct1, 1, 'L');
      
      final itemToRemove = cartProvider.cart.items.first;
      cartProvider.remove(itemToRemove);

      expect(cartProvider.cart.items.length, 1);
      expect(cartProvider.cart.items.first.size, 'L');
    });

    test('updateQuantity should update item quantity', () {
      cartProvider.add(testProduct1, 1, 'M');
      final item = cartProvider.cart.items.first;

      cartProvider.updateQuantity(item, 5);

      expect(cartProvider.cart.items.first.quantity, 5);
    });

    test('updateQuantity should trigger notifyListeners', () {
      cartProvider.add(testProduct1, 1, 'M');
      final item = cartProvider.cart.items.first;

      var notified = false;
      cartProvider.addListener(() => notified = true);

      cartProvider.updateQuantity(item, 3);

      expect(notified, true);
    });

    test('updateQuantity with 0 or negative should remove item', () {
      cartProvider.add(testProduct1, 1, 'M');
      final item = cartProvider.cart.items.first;

      cartProvider.updateQuantity(item, 0);

      expect(cartProvider.cart.items, isEmpty);
    });

    test('updateQuantity with negative number should remove item', () {
      cartProvider.add(testProduct1, 1, 'M');
      final item = cartProvider.cart.items.first;

      cartProvider.updateQuantity(item, -1);

      expect(cartProvider.cart.items, isEmpty);
    });

    test('clear should remove all items', () {
      cartProvider.add(testProduct1, 1, 'M');
      cartProvider.add(testProduct2, 1, 'L');

      cartProvider.clear();

      expect(cartProvider.cart.items, isEmpty);
      expect(cartProvider.cart.total, 0.0);
      expect(cartProvider.cart.itemCount, 0);
    });

    test('clear should trigger notifyListeners', () {
      cartProvider.add(testProduct1, 1, 'M');

      var notified = false;
      cartProvider.addListener(() => notified = true);

      cartProvider.clear();

      expect(notified, true);
    });

    test('cart total should be calculated correctly', () {
      cartProvider.add(testProduct1, 1, 'M'); // 19.99
      cartProvider.add(testProduct2, 1, 'L'); // 39.99

      expect(cartProvider.cart.total, closeTo(59.98, 0.01));
    });

    test('cart itemCount should be calculated correctly', () {
      cartProvider.add(testProduct1, 2, 'M');
      cartProvider.add(testProduct2, 3, 'L');

      expect(cartProvider.cart.itemCount, 5);
    });

    test('should handle adding multiple different products', () {
      cartProvider.add(testProduct1, 1, 'M');
      cartProvider.add(testProduct2, 1, 'L');

      expect(cartProvider.cart.items.length, 2);
    });

    test('should handle adding items without size', () {
      cartProvider.add(testProduct1, 1, null);

      expect(cartProvider.cart.items.length, 1);
      expect(cartProvider.cart.items.first.size, isNull);
    });

    test('should differentiate between sized and non-sized items', () {
      cartProvider.add(testProduct1, 1, 'M');
      cartProvider.add(testProduct1, 1, null);

      expect(cartProvider.cart.items.length, 2);
    });

    test('updateQuantity should handle item not in cart gracefully', () {
      final item = CartItem(
        product: testProduct1,
        quantity: 1,
        size: 'M',
      );

      // Should not throw
      cartProvider.updateQuantity(item, 5);

      // Cart should still be empty
      expect(cartProvider.cart.items, isEmpty);
    });

    test('should handle large quantities', () {
      cartProvider.add(testProduct1, 100, 'M');

      expect(cartProvider.cart.items.first.quantity, 100);
      expect(cartProvider.cart.itemCount, 100);
    });

    test('multiple listeners should all be notified', () {
      var listener1Called = false;
      var listener2Called = false;

      cartProvider.addListener(() => listener1Called = true);
      cartProvider.addListener(() => listener2Called = true);

      cartProvider.add(testProduct1, 1, 'M');

      expect(listener1Called, true);
      expect(listener2Called, true);
    });

    test('cart should persist after clearing and adding', () {
      cartProvider.add(testProduct1, 1, 'M');
      cartProvider.clear();
      cartProvider.add(testProduct2, 2, 'L');

      expect(cartProvider.cart.items.length, 1);
      expect(cartProvider.cart.items.first.product.id, 'prod2');
      expect(cartProvider.cart.items.first.quantity, 2);
    });

    test('updateQuantity should correctly update specific item', () {
      cartProvider.add(testProduct1, 1, 'M');
      cartProvider.add(testProduct1, 1, 'L');
      
      final itemM = cartProvider.cart.items.firstWhere((i) => i.size == 'M');
      cartProvider.updateQuantity(itemM, 10);

      final updatedItemM = cartProvider.cart.items.firstWhere((i) => i.size == 'M');
      final itemL = cartProvider.cart.items.firstWhere((i) => i.size == 'L');

      expect(updatedItemM.quantity, 10);
      expect(itemL.quantity, 1); // Should not be affected
    });

    test('cart reference should remain the same', () {
      final cart1 = cartProvider.cart;
      cartProvider.add(testProduct1, 1, 'M');
      final cart2 = cartProvider.cart;

      expect(identical(cart1, cart2), true);
    });

    test('should handle rapid successive additions', () {
      for (int i = 0; i < 10; i++) {
        cartProvider.add(testProduct1, 1, 'M');
      }

      expect(cartProvider.cart.items.length, 1);
      expect(cartProvider.cart.items.first.quantity, 10);
    });

    test('should handle adding zero quantity', () {
      cartProvider.add(testProduct1, 0, 'M');

      // Should still add the item with 0 quantity
      expect(cartProvider.cart.items.length, 1);
      expect(cartProvider.cart.items.first.quantity, 0);
      expect(cartProvider.cart.itemCount, 0);
    });
  });
}
