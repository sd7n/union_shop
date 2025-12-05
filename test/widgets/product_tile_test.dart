import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/product_tile.dart';

void main() {
  group('ProductTile Widget', () {
    late Product testProduct;
    late Product saleProduct;
    bool wasTapped = false;

    setUp(() {
      wasTapped = false;
      testProduct = const Product(
        id: 'test1',
        name: 'Test Product',
        description: 'A test product',
        price: 19.99,
        imageUrl: 'https://via.placeholder.com/150',
        isLocalImage: false,
        collectionId: 'test',
        sizes: ['M'],
      );
      saleProduct = const Product(
        id: 'sale1',
        name: 'Sale Product',
        description: 'Product on sale',
        price: 14.99,
        strikePrice: 24.99,
        imageUrl: 'https://via.placeholder.com/150',
        isLocalImage: false,
        collectionId: 'sale',
        sizes: ['M'],
      );
    });

    testWidgets('should display product name', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductTile(
              product: testProduct,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('Test Product'), findsOneWidget);
    });

    testWidgets('should display product price', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductTile(
              product: testProduct,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('£19.99'), findsOneWidget);
    });

    testWidgets('should display strike price and sale price', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductTile(
              product: saleProduct,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.text('£24.99'), findsOneWidget);
      expect(find.text('£14.99'), findsOneWidget);
    });

    testWidgets('should call onTap when tapped', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductTile(
              product: testProduct,
              onTap: () => wasTapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(GestureDetector));
      expect(wasTapped, true);
    });

    testWidgets('should display image', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductTile(
              product: testProduct,
              onTap: () {},
            ),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('should have correct aspect ratio', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProductTile(
              product: testProduct,
              onTap: () {},
            ),
          ),
        ),
      );

      final aspectRatio = tester.widget<AspectRatio>(find.byType(AspectRatio));
      expect(aspectRatio.aspectRatio, 1.0);
    });
  });
}
