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
      sizes: ['S', 'M', 'L'],
    );

    test('should create CartItem', () {
      final cartItem = CartItem(product: testProduct, quantity: 1);
      expect(cartItem.product, testProduct);
      expect(cartItem.quantity, 1);
    });

    test('should create CartItem with size', () {
      final cartItem = CartItem(product: testProduct, quantity: 2, size: 'M');
      expect(cartItem.size, 'M');
    });

    test('totalPrice should calculate correctly', () {
      final cartItem = CartItem(product: testProduct, quantity: 3);
      expect(cartItem.totalPrice, closeTo(59.97, 0.01));
    });

    test('toJson should serialize', () {
      final cartItem = CartItem(product: testProduct, quantity: 2, size: 'L');
      final json = cartItem.toJson();
      expect(json['productId'], 'prod1');
      expect(json['quantity'], 2);
    });
  });
}
