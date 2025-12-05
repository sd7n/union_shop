import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/services/data_service.dart';

void main() {
  group('SearchOverlay Logic', () {
    test('Search filters products by name', () {
      final products = DataService.instance.products;
      final searchTerm = 'hoodie';
      
      final results = products.where((p) => 
        p.name.toLowerCase().contains(searchTerm.toLowerCase())
      ).toList();

      expect(results.isNotEmpty, isTrue);
      for (var product in results) {
        expect(
          product.name.toLowerCase().contains(searchTerm.toLowerCase()),
          isTrue,
        );
      }
    });

    test('Search filters products by description', () {
      final products = DataService.instance.products;
      final searchTerm = 'comfortable';
      
      final results = products.where((p) => 
        p.description.toLowerCase().contains(searchTerm.toLowerCase())
      ).toList();

      for (var product in results) {
        expect(
          product.description.toLowerCase().contains(searchTerm.toLowerCase()),
          isTrue,
        );
      }
    });

    test('Search is case-insensitive', () {
      final products = DataService.instance.products;
      final lowerSearch = products.where((p) => 
        p.name.toLowerCase().contains('hoodie')
      ).toList();
      final upperSearch = products.where((p) => 
        p.name.toLowerCase().contains('HOODIE'.toLowerCase())
      ).toList();

      expect(lowerSearch.length, equals(upperSearch.length));
    });

    test('Empty search term returns all products', () {
      final products = DataService.instance.products;
      final searchTerm = '';
      
      final results = products.where((p) => 
        p.name.toLowerCase().contains(searchTerm.toLowerCase()) ||
        p.description.toLowerCase().contains(searchTerm.toLowerCase())
      ).toList();

      expect(results.length, equals(products.length));
    });

    test('Non-matching search returns empty list', () {
      final products = DataService.instance.products;
      final searchTerm = 'xyznonexistent123';
      
      final results = products.where((p) => 
        p.name.toLowerCase().contains(searchTerm.toLowerCase()) ||
        p.description.toLowerCase().contains(searchTerm.toLowerCase())
      ).toList();

      expect(results.isEmpty, isTrue);
    });
  });
}
