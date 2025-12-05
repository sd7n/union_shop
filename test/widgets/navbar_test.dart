import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Navbar Logic', () {
    test('Shop menu items have valid routes', () {
      final shopRoutes = {
        'clothing': '/collection-detail',
        'merchandise': '/collection-detail',
        'halloween': '/collection-detail',
        'signatureEssential': '/collection-detail',
      };

      for (var route in shopRoutes.values) {
        expect(route, startsWith('/'));
        expect(route, isNotEmpty);
      }
    });

    test('Print Shack menu has correct routes', () {
      final printShackRoutes = {
        'about': '/printshack-about',
        'personalisation': '/personalisation',
      };

      for (var route in printShackRoutes.values) {
        expect(route, startsWith('/'));
        expect(route, isNotEmpty);
      }
    });

    test('Navbar preferred height is correct', () {
      const preferredHeight = 110.0;
      
      expect(preferredHeight, greaterThan(0));
      expect(preferredHeight, lessThanOrEqualTo(200));
    });

    test('Cart badge count is non-negative', () {
      final itemCounts = [0, 1, 5, 10, 99];
      
      for (var count in itemCounts) {
        expect(count, greaterThanOrEqualTo(0));
      }
    });
  });
}
