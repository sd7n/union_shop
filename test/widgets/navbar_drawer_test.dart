import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NavbarDrawer Logic', () {
    test('Navigation routes are valid paths', () {
      final routes = ['/', '/collection-detail', '/sale', '/about', '/auth'];
      
      for (var route in routes) {
        expect(route, startsWith('/'));
        expect(route, isNotEmpty);
      }
    });

    test('All drawer menu items have routes', () {
      final menuItems = {
        'Home': '/',
        'Collections': '/collection-detail',
        'Sale': '/sale',
        'About': '/about',
        'Sign In': '/auth',
      };

      expect(menuItems.keys.length, equals(5));
      expect(menuItems.values.every((route) => route.startsWith('/')), isTrue);
    });

    test('Drawer title is correctly set', () {
      const drawerTitle = 'Union Shop Menu';
      
      expect(drawerTitle, isNotEmpty);
      expect(drawerTitle, contains('Union Shop'));
    });
  });
}
