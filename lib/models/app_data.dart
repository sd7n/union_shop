import 'product.dart';
import 'collection.dart';

class AppData {
  final List<Collection> collections;
  final List<Product> products;

  const AppData({
    required this.collections,
    required this.products,
  });

  Collection getCollection(String id) =>
      collections.firstWhere((c) => c.id == id);

  Product getProduct(String id) =>
      products.firstWhere((p) => p.id == id);

  List<Product> getProductsForCollection(String id) =>
      products.where((p) => p.collectionId == id).toList();
}
