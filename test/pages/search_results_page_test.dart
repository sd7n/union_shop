import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/data_service.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('SearchResultsPage Logic Tests', () {
    test('should search products by name', () {
      final data = DataService.instance;
      const searchTerm = 'hoodie';
      final results = data.products
          .where((p) => p.name.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();

      for (var product in results) {
        expect(product.name.toLowerCase(), contains(searchTerm.toLowerCase()));
      }
    });

    test('should search products by description', () {
      final data = DataService.instance;
      const searchTerm = 'purple';
      final results = data.products
          .where((p) => 
              p.name.toLowerCase().contains(searchTerm.toLowerCase()) ||
              p.description.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();

      for (var product in results) {
        final matchesName = product.name.toLowerCase().contains(searchTerm.toLowerCase());
        final matchesDesc = product.description.toLowerCase().contains(searchTerm.toLowerCase());
        expect(matchesName || matchesDesc, isTrue);
      }
    });

    test('should return empty results for non-matching search', () {
      final data = DataService.instance;
      const searchTerm = 'xyznonexistent123';
      final results = data.products
          .where((p) => 
              p.name.toLowerCase().contains(searchTerm.toLowerCase()) ||
              p.description.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();

      expect(results, isEmpty);
    });
  });
}
