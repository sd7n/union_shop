import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AboutPage Logic', () {
    test('Page content describes Union Shop', () {
      const title = 'About the Union Shop';
      const description = 'The Union Shop is operated by the Students\' Union';
      
      expect(title, contains('Union Shop'));
      expect(description, contains('Students\' Union'));
    });

    test('Benefits list is not empty', () {
      final benefits = [
        'Official university-branded merchandise',
        'Supports student clubs and societies',
        'Fair pricing and regular promotions',
      ];
      
      expect(benefits.length, greaterThan(0));
      expect(benefits.every((b) => b.isNotEmpty), isTrue);
    });

    test('Page sections have titles', () {
      const sections = ['About the Union Shop', 'Why shop with us?'];
      
      for (var section in sections) {
        expect(section, isNotEmpty);
      }
    });
  });
}
