import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/app_data.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group('AppData', () {
    late List<Collection> testCollections;
    late List<Product> testProducts;

    setUp(() {
      testCollections = [
        const Collection(
          id: 'clothing',
          name: 'Clothing',
          description: 'All clothing items',
          imageUrl: 'https://example.com/clothing.jpg',
          isLocalImage: false,
        ),
        const Collection(
          id: 'merchandise',
          name: 'Merchandise',
          description: 'University merchandise',
          imageUrl: 'https://example.com/merchandise.jpg',
          isLocalImage: false,
        ),
        const Collection(
          id: 'sale',
          name: 'Sale',
          description: 'Items on sale',
          imageUrl: 'https://example.com/sale.jpg',
          isLocalImage: false,
        ),
      ];

      testProducts = [
        const Product(
          id: 'prod1',
          name: 'T-Shirt',
          description: 'A t-shirt',
          price: 19.99,
          imageUrl: 'https://example.com/tshirt.jpg',
          isLocalImage: false,
          collectionId: 'clothing',
          sizes: ['S', 'M', 'L'],
        ),
        const Product(
          id: 'prod2',
          name: 'Hoodie',
          description: 'A hoodie',
          price: 39.99,
          imageUrl: 'https://example.com/hoodie.jpg',
          isLocalImage: false,
          collectionId: 'clothing',
          sizes: ['M', 'L', 'XL'],
        ),
        const Product(
          id: 'prod3',
          name: 'Mug',
          description: 'A mug',
          price: 9.99,
          imageUrl: 'https://example.com/mug.jpg',
          isLocalImage: false,
          collectionId: 'merchandise',
          sizes: ['One Size'],
        ),
        const Product(
          id: 'prod4',
          name: 'Sale T-Shirt',
          description: 'Discounted t-shirt',
          price: 14.99,
          strikePrice: 24.99,
          imageUrl: 'https://example.com/sale-tshirt.jpg',
          isLocalImage: false,
          collectionId: 'sale',
          sizes: ['S', 'M', 'L'],
        ),
      ];
    });

    test('should create AppData with collections and products', () {
      final appData = AppData(
        collections: testCollections,
        products: testProducts,
      );

      expect(appData.collections.length, 3);
      expect(appData.products.length, 4);
    });

    test('should create AppData with empty lists', () {
      final appData = AppData(
        collections: [],
        products: [],
      );

      expect(appData.collections, isEmpty);
      expect(appData.products, isEmpty);
    });

    test('getCollection should return correct collection by ID', () {
      final appData = AppData(
        collections: testCollections,
        products: testProducts,
      );

      final collection = appData.getCollection('clothing');

      expect(collection.id, 'clothing');
      expect(collection.name, 'Clothing');
    });

    test('getCollection should find different collections', () {
      final appData = AppData(
        collections: testCollections,
        products: testProducts,
      );

      expect(appData.getCollection('clothing').name, 'Clothing');
      expect(appData.getCollection('merchandise').name, 'Merchandise');
      expect(appData.getCollection('sale').name, 'Sale');
    });

    test('getCollection should throw when collection not found', () {
      final appData = AppData(
        collections: testCollections,
        products: testProducts,
      );

      expect(
        () => appData.getCollection('nonexistent'),
        throwsStateError,
      );
    });

    test('getProduct should return correct product by ID', () {
      final appData = AppData(
        collections: testCollections,
        products: testProducts,
      );

      final product = appData.getProduct('prod1');

      expect(product.id, 'prod1');
      expect(product.name, 'T-Shirt');
    });

    test('getProduct should find different products', () {
      final appData = AppData(
        collections: testCollections,
        products: testProducts,
      );

      expect(appData.getProduct('prod1').name, 'T-Shirt');
      expect(appData.getProduct('prod2').name, 'Hoodie');
      expect(appData.getProduct('prod3').name, 'Mug');
      expect(appData.getProduct('prod4').name, 'Sale T-Shirt');
    });

    test('getProduct should throw when product not found', () {
      final appData = AppData(
        collections: testCollections,
        products: testProducts,
      );

      expect(
        () => appData.getProduct('nonexistent'),
        throwsStateError,
      );
    });

    test('getProductsForCollection should return products for specific collection', () {
      final appData = AppData(
        collections: testCollections,
        products: testProducts,
      );

      final clothingProducts = appData.getProductsForCollection('clothing');

      expect(clothingProducts.length, 2);
      expect(clothingProducts[0].name, 'T-Shirt');
      expect(clothingProducts[1].name, 'Hoodie');
    });

    test('getProductsForCollection should return single product for merchandise', () {
      final appData = AppData(
        collections: testCollections,
        products: testProducts,
      );

      final merchandiseProducts = appData.getProductsForCollection('merchandise');

      expect(merchandiseProducts.length, 1);
      expect(merchandiseProducts.first.name, 'Mug');
    });

    test('getProductsForCollection should return empty list for collection with no products', () {
      final emptyCollection = const Collection(
        id: 'empty',
        name: 'Empty',
        description: 'No products',
        imageUrl: 'https://example.com/empty.jpg',
        isLocalImage: false,
      );

      final appData = AppData(
        collections: [...testCollections, emptyCollection],
        products: testProducts,
      );

      final emptyProducts = appData.getProductsForCollection('empty');

      expect(emptyProducts, isEmpty);
    });

    test('getProductsForCollection should return all products with matching collectionId', () {
      final appData = AppData(
        collections: testCollections,
        products: testProducts,
      );

      final saleProducts = appData.getProductsForCollection('sale');

      expect(saleProducts.length, 1);
      expect(saleProducts.first.collectionId, 'sale');
    });

    test('should be const constructible', () {
      const appData = AppData(
        collections: [],
        products: [],
      );

      expect(appData.collections, isEmpty);
      expect(appData.products, isEmpty);
    });

    test('should handle large number of collections', () {
      final manyCollections = List.generate(
        100,
        (i) => Collection(
          id: 'coll$i',
          name: 'Collection $i',
          description: 'Description $i',
          imageUrl: 'https://example.com/coll$i.jpg',
          isLocalImage: false,
        ),
      );

      final appData = AppData(
        collections: manyCollections,
        products: [],
      );

      expect(appData.collections.length, 100);
      expect(appData.getCollection('coll50').name, 'Collection 50');
    });

    test('should handle large number of products', () {
      final manyProducts = List.generate(
        200,
        (i) => Product(
          id: 'prod$i',
          name: 'Product $i',
          description: 'Description $i',
          price: 19.99,
          imageUrl: 'https://example.com/prod$i.jpg',
          isLocalImage: false,
          collectionId: 'clothing',
          sizes: ['M'],
        ),
      );

      final appData = AppData(
        collections: testCollections,
        products: manyProducts,
      );

      expect(appData.products.length, 200);
      expect(appData.getProduct('prod100').name, 'Product 100');
    });

    test('getProductsForCollection should handle collection with many products', () {
      final manyClothingProducts = List.generate(
        50,
        (i) => Product(
          id: 'cloth$i',
          name: 'Clothing Item $i',
          description: 'Description $i',
          price: 19.99,
          imageUrl: 'https://example.com/cloth$i.jpg',
          isLocalImage: false,
          collectionId: 'clothing',
          sizes: ['M'],
        ),
      );

      final appData = AppData(
        collections: testCollections,
        products: [...testProducts, ...manyClothingProducts],
      );

      final clothingProducts = appData.getProductsForCollection('clothing');

      expect(clothingProducts.length, 52); // 2 original + 50 new
    });

    test('should preserve product order within collection', () {
      final appData = AppData(
        collections: testCollections,
        products: testProducts,
      );

      final clothingProducts = appData.getProductsForCollection('clothing');

      expect(clothingProducts[0].id, 'prod1');
      expect(clothingProducts[1].id, 'prod2');
    });

    test('should handle products across multiple collections', () {
      final appData = AppData(
        collections: testCollections,
        products: testProducts,
      );

      final clothingCount = appData.getProductsForCollection('clothing').length;
      final merchandiseCount = appData.getProductsForCollection('merchandise').length;
      final saleCount = appData.getProductsForCollection('sale').length;

      expect(clothingCount + merchandiseCount + saleCount, 4);
    });

    test('collections list should be immutable reference', () {
      final appData = AppData(
        collections: testCollections,
        products: testProducts,
      );

      expect(identical(appData.collections, testCollections), true);
    });

    test('products list should be immutable reference', () {
      final appData = AppData(
        collections: testCollections,
        products: testProducts,
      );

      expect(identical(appData.products, testProducts), true);
    });

    test('getProductsForCollection should return new list instance', () {
      final appData = AppData(
        collections: testCollections,
        products: testProducts,
      );

      final products1 = appData.getProductsForCollection('clothing');
      final products2 = appData.getProductsForCollection('clothing');

      expect(identical(products1, products2), false);
      expect(products1.length, products2.length);
    });

    test('should handle product with null optional fields', () {
      final product = const Product(
        id: 'simple',
        name: 'Simple Product',
        description: 'Simple',
        price: 9.99,
        imageUrl: 'https://example.com/simple.jpg',
        isLocalImage: false,
        collectionId: 'merchandise',
        sizes: ['One Size'],
      );

      final appData = AppData(
        collections: testCollections,
        products: [product],
      );

      final found = appData.getProduct('simple');
      expect(found.id, 'simple');
      expect(found.strikePrice, isNull);
    });
  });
}
