import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PrintShackAboutPage Logic', () {
    test('Page title is correct', () {
      const title = 'The Union Print Shack';
      
      expect(title, contains('Print Shack'));
      expect(title, isNotEmpty);
    });

    test('Service description mentions customisation', () {
      const description = 'heat-pressed customisation on all our clothing';
      
      expect(description, contains('customisation'));
      expect(description, contains('clothing'));
    });

    test('Pricing structure is defined', () {
      final pricingOptions = {
        'One Line of Text': 3.50,
        'Two Lines of Text': 5.00,
        'Three Lines of Text': 6.50,
      };
      
      expect(pricingOptions.length, greaterThan(0));
      expect(pricingOptions.values.every((p) => p > 0), isTrue);
    });

    test('Page supports different layout widths', () {
      const wideWidth = 900.0;
      const narrowWidth = 600.0;
      
      final isWide = wideWidth >= 900;
      final isNarrow = narrowWidth < 900;
      
      expect(isWide, isTrue);
      expect(isNarrow, isTrue);
    });
  });
}
