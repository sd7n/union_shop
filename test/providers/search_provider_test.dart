import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/providers/search_provider.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('SearchProvider', () {
    late SearchProvider searchProvider;
    late List<Product> testProducts;

    setUp(() {
      searchProvider = SearchProvider();
      testProducts = [
        const Product(
          id: 'prod1',
          name: 'Blue T-Shirt',
          description: 'A comfortable cotton t-shirt',
          price: 19.99,
          imageUrl: 'https://example.com/tshirt.jpg',
          isLocalImage: false,
          collectionId: 'clothing',
          sizes: ['S', 'M', 'L'],
        ),
        const Product(
          id: 'prod2',
          name: 'Red Hoodie',
          description: 'Warm hoodie for winter',
          price: 39.99,
          imageUrl: 'https://example.com/hoodie.jpg',
          isLocalImage: false,
          collectionId: 'clothing',
          sizes: ['M', 'L', 'XL'],
        ),
        const Product(
          id: 'prod3',
          name: 'Coffee Mug',
          description: 'University branded mug',
          price: 9.99,
          imageUrl: 'https://example.com/mug.jpg',
          isLocalImage: false,
          collectionId: 'merchandise',
          sizes: ['One Size'],
        ),
      ];
    });

    test('initial state should be empty', () {
      expect(searchProvider.searchTerm, '');
      expect(searchProvider.results, isEmpty);
    });

    test('setSearchTerm should update search term', () {
      searchProvider.setSearchTerm('shirt');
      expect(searchProvider.searchTerm, 'shirt');
    });

    test('runSearch should find products by name', () {
      searchProvider.setSearchTerm('shirt');
      searchProvider.runSearch(testProducts);

      expect(searchProvider.results.length, 1);
      expect(searchProvider.results.first.name, 'Blue T-Shirt');
    });

    test('runSearch should find products by description', () {
      searchProvider.setSearchTerm('winter');
      searchProvider.runSearch(testProducts);

      expect(searchProvider.results.length, 1);
      expect(searchProvider.results.first.name, 'Red Hoodie');
    });

    test('runSearch should be case insensitive', () {
      searchProvider.setSearchTerm('BLUE');
      searchProvider.runSearch(testProducts);

      expect(searchProvider.results.length, 1);
      expect(searchProvider.results.first.name, 'Blue T-Shirt');
    });

    test('runSearch should return multiple matching products', () {
      searchProvider.setSearchTerm('shirt');
      searchProvider.runSearch(testProducts);

      expect(searchProvider.results.length, 1);
    });

    test('runSearch should return empty list for no matches', () {
      searchProvider.setSearchTerm('xyz123nonexistent');
      searchProvider.runSearch(testProducts);

      expect(searchProvider.results, isEmpty);
    });

    test('runSearch should return empty list when search term is empty', () {
      searchProvider.setSearchTerm('');
      searchProvider.runSearch(testProducts);

      expect(searchProvider.results, isEmpty);
    });

    test('runSearch should handle partial matches', () {
      searchProvider.setSearchTerm('mug');
      searchProvider.runSearch(testProducts);

      expect(searchProvider.results.length, 1);
      expect(searchProvider.results.first.name, 'Coffee Mug');
    });
  });
}
