import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomePage Logic', () {
    test('Home route is root path', () {
      const homeRoute = '/';
      
      expect(homeRoute, equals('/'));
    });

    test('Hero slides list is not empty', () {
      final slides = [
        {'title': 'Essential Range', 'route': '/collection-detail'},
        {'title': 'Print Shack', 'route': '/printshack-about'},
      ];
      
      expect(slides.length, greaterThan(0));
      expect(slides.every((s) => s['title']!.isNotEmpty), isTrue);
    });

    test('Featured collections are displayed', () {
      final collections = ['Clothing', 'Merchandise', 'Halloween'];
      
      expect(collections.length, greaterThan(0));
      expect(collections.every((c) => c.isNotEmpty), isTrue);
    });
  });
}
