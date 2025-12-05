import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/data_service.dart';

void main() {
  group('CollectionsPage Logic Tests', () {
    test('should load collections from DataService', () {
      final data = DataService.instance;
      final collections = data.collections;

      expect(collections, isNotEmpty);
      expect(collections.length, greaterThan(0));
    });

    test('each collection should have valid properties', () {
      final data = DataService.instance;
      final collections = data.collections;

      for (var collection in collections) {
        expect(collection.id, isNotEmpty);
        expect(collection.name, isNotEmpty);
        expect(collection.description, isNotEmpty);
      }
    });

    test('collections should have expected IDs', () {
      final data = DataService.instance;
      final collectionIds = data.collections.map((c) => c.id).toList();

      expect(collectionIds.contains('hoodies'), isTrue);
      expect(collectionIds.contains('tshirts'), isTrue);
      expect(collectionIds.contains('accessories'), isTrue);
    });
  });
}
