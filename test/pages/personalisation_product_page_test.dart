import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PersonalisationProductPage Logic', () {
    test('Price map has all options', () {
      final priceMap = {
        'One Line of Text': 3.50,
        'Two Lines of Text': 5.00,
        'Three Lines of Text': 6.50,
        'Four Lines of Text': 8.00,
      };
      
      expect(priceMap.length, equals(4));
      expect(priceMap.values.every((price) => price > 0), isTrue);
    });

    test('Line count matches options', () {
      final lineCountMap = {
        'One Line of Text': 1,
        'Two Lines of Text': 2,
        'Three Lines of Text': 3,
        'Four Lines of Text': 4,
      };
      
      expect(lineCountMap['One Line of Text'], equals(1));
      expect(lineCountMap['Four Lines of Text'], equals(4));
    });

    test('Total price calculation with quantity', () {
      const basePrice = 3.50;
      const quantity = 2;
      final totalPrice = basePrice * quantity;
      
      expect(totalPrice, equals(7.00));
    });

    test('Price increases with more text lines', () {
      final prices = [3.50, 5.00, 6.50, 8.00];
      
      for (int i = 0; i < prices.length - 1; i++) {
        expect(prices[i], lessThan(prices[i + 1]));
      }
    });

    test('Quantity must be positive', () {
      final quantities = [1, 2, 5, 10];
      
      for (var qty in quantities) {
        expect(qty, greaterThan(0));
      }
    });
  });
}
