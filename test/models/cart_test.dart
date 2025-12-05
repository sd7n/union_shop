import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/models/cart_item.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('Cart', () {
    late Cart cart;
    late Product testProduct1;
    late Product testProduct2;

    setUp(() {
      cart = Cart();
      testProduct1 = Product(
        id: 'prod1',
        name: 'T-Shirt',
        description: 'A t-shirt',
        price: 19.99,
        imageUrl: 'https://example.com/tshirt.jpg',
        isLocalImage: false,
        collectionId: 'clothing',
        sizes: ['S', 'M', 'L'],
      );
      testProduct2 = Product(
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

    test('new Cart should be empty', () {
      expect(cart.items, isEmpty);
      expect(cart.total, 0.0);
      expect(cart.itemCount, 0);
    });

    test('addItem should add new item to cart', () {
      cart.addItem(testProduct1, 1, 'M');

      expect(cart.items.length, 1);
      expect(cart.items.first.product, testProduct1);
      expect(cart.items.first.quantity, 1);
      expect(cart.items.first.size, 'M');
    });

    test('addItem should increase quantity for existing item with same size', () {
      cart.addItem(testProduct1, 1, 'M');
      cart.addItem(testProduct1, 2, 'M');

      expect(cart.items.length, 1);
      expect(cart.items.first.quantity, 3);
    });

    test('addItem should create separate items for different sizes', () {
      cart.addItem(testProduct1, 1, 'M');
      cart.addItem(testProduct1, 1, 'L');

      expect(cart.items.length, 2);
      expect(cart.items[0].size, 'M');
      expect(cart.items[1].size, 'L');
    });

    test('addItem should handle item without size', () {
      cart.addItem(testProduct1, 1, null);

      expect(cart.items.length, 1);
      expect(cart.items.first.size, isNull);
    });

    test('addItem should differentiate between sized and non-sized items', () {
      cart.addItem(testProduct1, 1, 'M');
      cart.addItem(testProduct1, 1, null);

      expect(cart.items.length, 2);
    });

    test('addItem should add multiple different products', () {
      cart.addItem(testProduct1, 1, 'M');
      cart.addItem(testProduct2, 1, 'L');

      expect(cart.items.length, 2);
      expect(cart.items[0].product.id, 'prod1');
      expect(cart.items[1].product.id, 'prod2');
    });

    test('total should calculate sum of all item prices', () {
      cart.addItem(testProduct1, 1, 'M'); // 19.99
      cart.addItem(testProduct2, 1, 'L'); // 39.99

      expect(cart.total, closeTo(59.98, 0.01));
    });

    test('total should update when quantity increases', () {
      cart.addItem(testProduct1, 1, 'M'); // 19.99
      cart.addItem(testProduct1, 2, 'M'); // adds 2 more = 3 total

      expect(cart.total, closeTo(59.97, 0.01));
    });

    test('total should be 0 for empty cart', () {
      expect(cart.total, 0.0);
    });

    test('itemCount should return total quantity of all items', () {
      cart.addItem(testProduct1, 2, 'M');
      cart.addItem(testProduct2, 3, 'L');

      expect(cart.itemCount, 5);
    });

    test('itemCount should be 0 for empty cart', () {
      expect(cart.itemCount, 0);
    });

    test('itemCount should update when items added', () {
      expect(cart.itemCount, 0);
      
      cart.addItem(testProduct1, 1, 'M');
      expect(cart.itemCount, 1);
      
      cart.addItem(testProduct1, 2, 'M');
      expect(cart.itemCount, 3);
    });

    test('removeItem should remove item by product ID and size', () {
      cart.addItem(testProduct1, 1, 'M');
      cart.addItem(testProduct1, 1, 'L');

      cart.removeItem('prod1', 'M');

      expect(cart.items.length, 1);
      expect(cart.items.first.size, 'L');
    });

    test('removeItem should handle removing item without size', () {
      cart.addItem(testProduct1, 1, null);
      cart.addItem(testProduct1, 1, 'M');

      cart.removeItem('prod1', null);

      expect(cart.items.length, 1);
      expect(cart.items.first.size, 'M');
    });

    test('removeItem should not affect other items', () {
      cart.addItem(testProduct1, 1, 'M');
      cart.addItem(testProduct2, 1, 'L');

      cart.removeItem('prod1', 'M');

      expect(cart.items.length, 1);
      expect(cart.items.first.product.id, 'prod2');
    });

    test('removeItem should do nothing if item not found', () {
      cart.addItem(testProduct1, 1, 'M');

      cart.removeItem('nonexistent', 'L');

      expect(cart.items.length, 1);
    });

    test('clear should remove all items', () {
      cart.addItem(testProduct1, 2, 'M');
      cart.addItem(testProduct2, 3, 'L');

      cart.clear();

      expect(cart.items, isEmpty);
      expect(cart.total, 0.0);
      expect(cart.itemCount, 0);
    });

    test('clear should work on empty cart', () {
      cart.clear();

      expect(cart.items, isEmpty);
    });

    test('should handle adding same product with multiple sizes', () {
      cart.addItem(testProduct1, 1, 'S');
      cart.addItem(testProduct1, 1, 'M');
      cart.addItem(testProduct1, 1, 'L');

      expect(cart.items.length, 3);
      expect(cart.itemCount, 3);
      expect(cart.total, closeTo(59.97, 0.01));
    });

    test('should handle large quantities', () {
      cart.addItem(testProduct1, 100, 'M');

      expect(cart.items.first.quantity, 100);
      expect(cart.itemCount, 100);
      expect(cart.total, closeTo(1999.0, 0.01));
    });

    test('should handle adding multiple increments', () {
      cart.addItem(testProduct1, 1, 'M');
      cart.addItem(testProduct1, 1, 'M');
      cart.addItem(testProduct1, 1, 'M');
      cart.addItem(testProduct1, 1, 'M');

      expect(cart.items.length, 1);
      expect(cart.items.first.quantity, 4);
    });

    test('should handle products with different prices', () {
      final cheapProduct = Product(
        id: 'cheap',
        name: 'Cheap Item',
        description: 'Cheap',
        price: 5.99,
        imageUrl: 'https://example.com/cheap.jpg',
        isLocalImage: false,
        collectionId: 'sale',
        sizes: ['One Size'],
      );

      final expensiveProduct = Product(
        id: 'expensive',
        name: 'Expensive Item',
        description: 'Expensive',
        price: 99.99,
        imageUrl: 'https://example.com/expensive.jpg',
        isLocalImage: false,
        collectionId: 'premium',
        sizes: ['One Size'],
      );

      cart.addItem(cheapProduct, 1, null);
      cart.addItem(expensiveProduct, 1, null);

      expect(cart.total, closeTo(105.98, 0.01));
    });

    test('should handle free products', () {
      final freeProduct = Product(
        id: 'free',
        name: 'Free Item',
        description: 'Free',
        price: 0.0,
        imageUrl: 'https://example.com/free.jpg',
        isLocalImage: false,
        collectionId: 'promo',
        sizes: ['One Size'],
      );

      cart.addItem(freeProduct, 1, null);
      cart.addItem(testProduct1, 1, 'M');

      expect(cart.total, closeTo(19.99, 0.01));
      expect(cart.itemCount, 2);
    });

    test('removing all items one by one should result in empty cart', () {
      cart.addItem(testProduct1, 1, 'M');
      cart.addItem(testProduct1, 1, 'L');
      cart.addItem(testProduct2, 1, 'XL');

      cart.removeItem('prod1', 'M');
      cart.removeItem('prod1', 'L');
      cart.removeItem('prod2', 'XL');

      expect(cart.items, isEmpty);
      expect(cart.total, 0.0);
      expect(cart.itemCount, 0);
    });

    test('should maintain correct state after mixed operations', () {
      cart.addItem(testProduct1, 2, 'M');
      cart.addItem(testProduct2, 1, 'L');
      cart.removeItem('prod1', 'M');
      cart.addItem(testProduct1, 1, 'L');
      cart.addItem(testProduct2, 2, 'L');

      expect(cart.items.length, 2);
      expect(cart.itemCount, 4);
    });

    test('items list should be mutable', () {
      cart.addItem(testProduct1, 1, 'M');
      
      // Directly modify quantity through items list
      cart.items.first.quantity = 5;

      expect(cart.items.first.quantity, 5);
      expect(cart.itemCount, 5);
      expect(cart.total, closeTo(99.95, 0.01));
    });
  });
}
