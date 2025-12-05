import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/product_grid_card.dart';

void main() {
  group('ProductGridCard', () {
    test('ProductGridCard should have required properties', () {
      const card = ProductGridCard(
        title: 'Test Product',
        price: '£19.99',
        imageUrl: 'test.jpg',
        productId: 'test-1',
        isLocalImage: true,
        index: 3,
      );

      expect(card.title, 'Test Product');
      expect(card.price, '£19.99');
      expect(card.productId, 'test-1');
      expect(card.isLocalImage, isTrue);
      expect(card.index, 3);
    });

    test('ProductGridCard should accept external URL', () {
      const card = ProductGridCard(
        title: 'Product',
        price: '£10',
        imageUrl: 'url',
        productId: 'id',
        externalUrl: 'https://example.com',
      );

      expect(card.externalUrl, 'https://example.com');
    });

    test('ProductGridCard defaults', () {
      const card = ProductGridCard(
        title: 'Product',
        price: '£5',
        imageUrl: 'img',
        productId: 'id',
      );

      expect(card.isLocalImage, isFalse);
      expect(card.index, 0);
      expect(card.externalUrl, isNull);
    });
  });
}
