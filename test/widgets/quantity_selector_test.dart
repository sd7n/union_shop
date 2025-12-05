import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/quantity_selector.dart';

void main() {
  group('QuantitySelector', () {
    testWidgets('should display initial quantity of 1', (tester) async {
      int? changedValue;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QuantitySelector(
              onChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );

      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('should increment quantity when + button is tapped', (tester) async {
      int? changedValue;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QuantitySelector(
              onChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(find.text('2'), findsOneWidget);
      expect(changedValue, 2);
    });

    testWidgets('should decrement quantity when - button is tapped', (tester) async {
      int? changedValue;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QuantitySelector(
              onChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );

      // Increment first to get to 2
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Then decrement
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      expect(find.text('1'), findsOneWidget);
      expect(changedValue, 1);
    });

    testWidgets('should not decrement below 1', (tester) async {
      int changeCount = 0;
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QuantitySelector(
              onChanged: (_) => changeCount++,
            ),
          ),
        ),
      );

      // Try to decrement from 1
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();

      expect(find.text('1'), findsOneWidget);
      expect(changeCount, 0); // Should not trigger callback
    });

    testWidgets('should call onChanged with correct value', (tester) async {
      final List<int> changedValues = [];
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QuantitySelector(
              onChanged: (value) => changedValues.add(value),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      expect(changedValues, [2, 3, 4]);
    });
  });
}
