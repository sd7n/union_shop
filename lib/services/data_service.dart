import '../models/app_data.dart';
import '../models/collection.dart';
import '../models/product.dart';

class DataService {
  static final DataService instance = DataService._();

  DataService._() {
    load();
  }

  late final AppData appData;

  final _collections = [
    Collection(
      id: 'hoodies',
      name: 'Hoodies',
      description: 'Official university hoodies',
      imageUrl: 'assets/images/hoodie_collection.png',
      isLocalImage: true,
    ),
    Collection(
      id: 'tshirts',
      name: 'T-Shirts',
      description: 'Casual tees & campus shirts',
      imageUrl: 'assets/images/tshirt_collection.png',
      isLocalImage: true,
    ),
    Collection(
      id: 'accessories',
      name: 'Accessories',
      description: 'Mugs, bags, lanyards and more',
      imageUrl: 'assets/images/accessories_collection.png',
      isLocalImage: true,
    ),
    Collection(
      id: 'stationery',
      name: 'Stationery',
      description: 'Notebooks, pens and study essentials',
      imageUrl: 'assets/images/stationery_collection.png',
      isLocalImage: true,
    ),
    Collection(
      id: 'printshack',
      name: 'Print Shack',
      description: 'Custom printing & personalised gifts',
      imageUrl: 'assets/images/printshack_collection.png',
      isLocalImage: true,
    ),
  ];

  final _products = [
    Product(
      id: 'hoodie-navy',
      name: 'Classic Navy Hoodie',
      description: 'A warm, durable hoodie featuring the university crest.',
      price: 29.99,
      imageUrl: 'assets/images/hoodie_navy.png',
      isLocalImage: true,
      collectionId: 'hoodies',
      sizes: ['S', 'M', 'L', 'XL'],
      externalUrl: 'https://example.com/products/navy_hoodie',
    ),
    Product(
      id: 'hoodie-zip',
      name: 'University Zip Hoodie',
      description: 'Front-zip hoodie with embroidered university logo.',
      price: 34.99,
      imageUrl: 'assets/images/hoodie_zip.png',
      isLocalImage: true,
      collectionId: 'hoodies',
      sizes: ['S', 'M', 'L', 'XL'],
    ),
    Product(
      id: 'tee-classic',
      name: 'Classic Uni T-Shirt',
      description: 'Soft cotton tee with printed university logo.',
      price: 14.99,
      imageUrl: 'assets/images/tshirt_classic.png',
      isLocalImage: true,
      collectionId: 'tshirts',
      sizes: ['S', 'M', 'L', 'XL'],
    ),
    Product(
      id: 'tee-sport',
      name: 'Sport T-Shirt',
      description: 'Breathable sports tee for gym and outdoor activities.',
      price: 17.99,
      imageUrl: 'assets/images/tshirt_sport.png',
      isLocalImage: true,
      collectionId: 'tshirts',
      sizes: ['S', 'M', 'L', 'XL'],
    ),
    Product(
      id: 'mug-uni',
      name: 'University Mug',
      description: 'Ceramic mug featuring the university emblem.',
      price: 7.99,
      imageUrl: 'assets/images/mug_uni.png',
      isLocalImage: true,
      collectionId: 'accessories',
      sizes: [],
    ),
    Product(
      id: 'tote-campus',
      name: 'Campus Tote Bag',
      description: 'Durable tote bag with campus map design.',
      price: 9.99,
      imageUrl: 'assets/images/tote_bag.png',
      isLocalImage: true,
      collectionId: 'accessories',
      sizes: [],
    ),
    Product(
      id: 'notebook-a5',
      name: 'A5 Notebook',
      description: 'Hardcover notebook with university crest.',
      price: 5.99,
      imageUrl: 'assets/images/notebook_a5.png',
      isLocalImage: true,
      collectionId: 'stationery',
      sizes: [],
    ),
    Product(
      id: 'pen-gel',
      name: 'Official Gel Pen',
      description: 'Smooth-writing blue gel pen branded with the university logo.',
      price: 1.99,
      imageUrl: 'assets/images/pen_gel.png',
      isLocalImage: true,
      collectionId: 'stationery',
      sizes: [],
    ),
  ];

  void load() {
    appData = AppData(
      collections: _collections,
      products: _products,
    );
  }

  List<Collection> get collections => _collections;

  List<Product> get products => _products;

  Collection getCollection(String id) =>
      _collections.firstWhere((c) => c.id == id);

  Product getProduct(String id) => _products.firstWhere((p) => p.id == id);

  List<Product> getProductsForCollection(String id) =>
      _products.where((p) => p.collectionId == id).toList();
}