import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/collection.dart';

void main() {
  group('Collection', () {
    test('should create Collection with all required fields', () {
      final collection = Collection(
        id: 'clothing',
        name: 'Clothing',
        description: 'All clothing items',
        imageUrl: 'https://example.com/clothing.jpg',
        isLocalImage: false,
      );

      expect(collection.id, 'clothing');
      expect(collection.name, 'Clothing');
      expect(collection.description, 'All clothing items');
      expect(collection.imageUrl, 'https://example.com/clothing.jpg');
      expect(collection.isLocalImage, false);
    });

    test('should create Collection with local image', () {
      final collection = Collection(
        id: 'merchandise',
        name: 'Merchandise',
        description: 'University merchandise',
        imageUrl: 'assets/images/merchandise.png',
        isLocalImage: true,
      );

      expect(collection.isLocalImage, true);
      expect(collection.imageUrl, 'assets/images/merchandise.png');
    });

    test('should create Collection with remote image', () {
      final collection = Collection(
        id: 'sale',
        name: 'Sale Items',
        description: 'Items on sale',
        imageUrl: 'https://example.com/sale.jpg',
        isLocalImage: false,
      );

      expect(collection.isLocalImage, false);
      expect(collection.imageUrl, startsWith('https://'));
    });

    test('toString should return correct format', () {
      final collection = Collection(
        id: 'test-collection',
        name: 'Test Collection',
        description: 'A test collection',
        imageUrl: 'https://example.com/test.jpg',
        isLocalImage: false,
      );

      final result = collection.toString();

      expect(result, contains('test-collection'));
      expect(result, contains('Test Collection'));
    });

    test('should handle special characters in name', () {
      final collection = Collection(
        id: 'pride',
        name: 'Pride & Unity',
        description: 'Pride collection with special chars: £, €',
        imageUrl: 'https://example.com/pride.jpg',
        isLocalImage: false,
      );

      expect(collection.name, contains('&'));
      expect(collection.description, contains('£'));
    });

    test('should handle empty description', () {
      final collection = Collection(
        id: 'minimal',
        name: 'Minimal',
        description: '',
        imageUrl: 'https://example.com/minimal.jpg',
        isLocalImage: false,
      );

      expect(collection.description, isEmpty);
    });

    test('should handle very long description', () {
      final longDesc = 'Lorem ipsum ' * 100;
      final collection = Collection(
        id: 'long',
        name: 'Long Description',
        description: longDesc,
        imageUrl: 'https://example.com/long.jpg',
        isLocalImage: false,
      );

      expect(collection.description.length, greaterThan(500));
    });

    test('Collection should be const constructible', () {
      const collection = Collection(
        id: 'const',
        name: 'Const Collection',
        description: 'A const collection',
        imageUrl: 'https://example.com/const.jpg',
        isLocalImage: false,
      );

      expect(collection.id, 'const');
      expect(collection.name, 'Const Collection');
    });

    test('should handle IDs with hyphens and underscores', () {
      final collection = Collection(
        id: 'test-collection_2024',
        name: 'Test Collection 2024',
        description: 'Collection for 2024',
        imageUrl: 'https://example.com/test.jpg',
        isLocalImage: false,
      );

      expect(collection.id, contains('-'));
      expect(collection.id, contains('_'));
    });

    test('should handle multiple collections with same name but different IDs', () {
      final collection1 = Collection(
        id: 'clothing-1',
        name: 'Clothing',
        description: 'First clothing collection',
        imageUrl: 'https://example.com/clothing1.jpg',
        isLocalImage: false,
      );

      final collection2 = Collection(
        id: 'clothing-2',
        name: 'Clothing',
        description: 'Second clothing collection',
        imageUrl: 'https://example.com/clothing2.jpg',
        isLocalImage: false,
      );

      expect(collection1.name, equals(collection2.name));
      expect(collection1.id, isNot(equals(collection2.id)));
    });

    test('should handle URL with query parameters', () {
      final collection = Collection(
        id: 'external',
        name: 'External Collection',
        description: 'Collection with external image',
        imageUrl: 'https://example.com/image.jpg?size=large&format=webp',
        isLocalImage: false,
      );

      expect(collection.imageUrl, contains('?'));
      expect(collection.imageUrl, contains('&'));
    });

    test('should handle local asset paths correctly', () {
      final collection = Collection(
        id: 'local1',
        name: 'Local Collection',
        description: 'Collection with local asset',
        imageUrl: 'assets/images/collections/test.png',
        isLocalImage: true,
      );

      expect(collection.imageUrl, startsWith('assets/'));
      expect(collection.isLocalImage, true);
    });

    test('should handle names with numbers', () {
      final collection = Collection(
        id: 'year2025',
        name: '2025 Collection',
        description: 'Collection for the year 2025',
        imageUrl: 'https://example.com/2025.jpg',
        isLocalImage: false,
      );

      expect(collection.name, contains('2025'));
      expect(collection.id, contains('2025'));
    });

    test('should handle unicode characters in description', () {
      final collection = Collection(
        id: 'unicode',
        name: 'Unicode Collection',
        description: 'Collection with emoji 🎓 and symbols ™️ ®️',
        imageUrl: 'https://example.com/unicode.jpg',
        isLocalImage: false,
      );

      expect(collection.description, contains('🎓'));
      expect(collection.description, contains('™'));
    });
  });
}
