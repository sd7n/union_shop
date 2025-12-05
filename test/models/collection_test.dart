import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/collection.dart';

void main() {
  group('Collection', () {
    test('should create Collection with required fields', () {
      final collection = Collection(
        id: 'clothing',
        name: 'Clothing',
        description: 'All clothing items',
        imageUrl: 'https://example.com/clothing.jpg',
        isLocalImage: false,
      );

      expect(collection.id, 'clothing');
      expect(collection.name, 'Clothing');
    });

    test('should handle local images', () {
      final collection = Collection(
        id: 'merchandise',
        name: 'Merchandise',
        description: 'University merchandise',
        imageUrl: 'assets/images/merchandise.png',
        isLocalImage: true,
      );

      expect(collection.isLocalImage, true);
    });

    test('toString should contain info', () {
      final collection = Collection(
        id: 'test',
        name: 'Test Collection',
        description: 'A test',
        imageUrl: 'https://example.com/test.jpg',
        isLocalImage: false,
      );

      expect(collection.toString(), contains('test'));
    });
  });
}
