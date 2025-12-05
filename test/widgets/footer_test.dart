import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Footer Logic', () {
    test('URL parsing for external links', () {
      final url = 'https://www.example.com';
      final uri = Uri.parse(url);

      expect(uri.scheme, 'https');
      expect(uri.host, 'www.example.com');
      expect(uri.isAbsolute, isTrue);
    });

    test('Route navigation paths are valid', () {
      final routes = ['/contact', '/about', '/returns', '/privacy'];
      
      for (var route in routes) {
        expect(route, startsWith('/'));
        expect(route, isNotEmpty);
      }
    });

    test('Social media URLs are valid', () {
      final socialUrls = [
        'https://facebook.com',
        'https://twitter.com',
        'https://instagram.com',
      ];

      for (var url in socialUrls) {
        final uri = Uri.parse(url);
        expect(uri.scheme, 'https');
        expect(uri.host, isNotEmpty);
      }
    });
  });
}
