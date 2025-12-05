import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/cart_list_tile.dart';
import 'package:union_shop/models/cart_item.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('CartListTile', () {
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

    testWidgets('should display product name and price', (tester) async {
      final cartItem = CartItem(product: testProduct, quantity: 1);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CartListTile(
              item: cartItem,
              onIncrease: () {},
              onDecrease: () {},
              onRemove: () {},
            ),
          ),
        ),
      );

      expect(find.text('Test Product'), findsOneWidget);
      expect(find.text('£19.99'), findsOneWidget);
    });

    testWidgets('should display size when provided', (tester) async {
      final cartItem = CartItem(
        product: testProduct,
        quantity: 1,
        size: 'M',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CartListTile(
              item: cartItem,
              onIncrease: () {},
              onDecrease: () {},
              onRemove: () {},
            ),
          ),
        ),
      );

      expect(find.text('Size: M'), findsOneWidget);
    });

    testWidgets('should call onIncrease when + button tapped', (tester) async {
      bool increased = false;
      final cartItem = CartItem(product: testProduct, quantity: 1);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CartListTile(
              item: cartItem,
              onIncrease: () => increased = true,
              onDecrease: () {},
              onRemove: () {},
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.add).first);
      expect(increased, isTrue);
    });

    testWidgets('should call onDecrease when - button tapped', (tester) async {
      bool decreased = false;
      final cartItem = CartItem(product: testProduct, quantity: 2);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CartListTile(
              item: cartItem,
              onIncrease: () {},
              onDecrease: () => decreased = true,
              onRemove: () {},
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.remove).first);
      expect(decreased, isTrue);
    });

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
  });
}
