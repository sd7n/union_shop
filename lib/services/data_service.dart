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
    Collection(
      id: 'signature',
      name: 'Signature Range',
      description: 'Exclusive signature collection',
      imageUrl: 'assets/images/signature_collection.png',
      isLocalImage: true,
    ),
    Collection(
      id: 'city',
      name: 'Portsmouth City Collection',
      description: 'City-inspired designs and merchandise',
      imageUrl: 'assets/images/city_collection.png',
      isLocalImage: true,
    ),
  ];

  final _products = [
    Product(
      id: 'hoodie-navy',
      name: 'Classic Navy Hoodie',
      description: 'A warm, durable hoodie featuring the university crest.',
      price: 29.99,
      strikePrice: 39.99,
      imageUrl: 'https://images.stockx.com/images/Bape-Color-Camo-Double-Shark-Full-Zip-Hoodie-Purple.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&updated_at=1621458689',
      isLocalImage: true,
      collectionId: 'hoodies',
      sizes: ['S', 'M', 'L', 'XL'],
      images: [
        'https://images.stockx.com/images/Bape-Color-Camo-Double-Shark-Full-Zip-Hoodie-Purple.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&updated_at=1621458689',
        'assets/images/hoodie_navy_alt.png',
      ],
      colors: ['Navy', 'Black', 'Grey'],
    ),
    Product(
      id: 'hoodie-zip',
      name: 'University Zip Hoodie',
      description: 'Front-zip hoodie with embroidered university logo.',
      price: 34.99,
      strikePrice: 44.99,
      imageUrl: 'assets/images/hoodie_zip.png',
      isLocalImage: true,
      collectionId: 'hoodies',
      sizes: ['S', 'M', 'L', 'XL'],
      images: [
        'assets/images/hoodie_zip.png',
        'assets/images/hoodie_zip_alt.png',
      ],
      colors: ['Navy', 'Black', 'Grey'],
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
      images: [
        'assets/images/tshirt_classic.png',
        'assets/images/tshirt_classic_back.png',
      ],
      colors: ['White', 'Black', 'Navy'],
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
      images: [
        'assets/images/tshirt_sport.png',
        'assets/images/tshirt_sport_alt.png',
      ],
      colors: ['Black', 'Navy', 'Grey'],
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
      images: [
        'assets/images/mug_uni.png',
        'assets/images/mug_uni_alt.png',
      ],
      colors: ['White', 'Black'],
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
      images: [
        'assets/images/tote_bag.png',
        'assets/images/tote_bag_alt.png',
      ],
      colors: ['Black', 'Navy'],
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
      images: [
        'assets/images/notebook_a5.png',
        'assets/images/notebook_a5_inside.png',
      ],
      colors: ['Black', 'Navy', 'Grey'],
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
      images: [
        'assets/images/pen_gel.png',
      ],
      colors: ['Blue', 'Black'],
    ),
    Product(
      id: 'sig-hoodie',
      name: 'Signature Hoodie',
      description: 'Premium hoodie from our exclusive signature range.',
      price: 39.99,
      imageUrl: 'assets/images/sig_hoodie.png',
      isLocalImage: true,
      collectionId: 'signature',
      sizes: ['S', 'M', 'L', 'XL'],
      images: [
        'assets/images/sig_hoodie.png',
        'assets/images/sig_hoodie_alt.png',
      ],
      colors: ['Black', 'Navy', 'Burgundy'],
    ),
    Product(
      id: 'sig-tee',
      name: 'Signature T-Shirt',
      description: 'Exclusive signature collection t-shirt with premium finish.',
      price: 19.99,
      imageUrl: 'assets/images/sig_tee.png',
      isLocalImage: true,
      collectionId: 'signature',
      sizes: ['S', 'M', 'L', 'XL'],
      images: [
        'assets/images/sig_tee.png',
        'assets/images/sig_tee_alt.png',
      ],
      colors: ['White', 'Black', 'Grey'],
    ),
    Product(
      id: 'city-mug',
      name: 'Portsmouth City Mug',
      description: 'Ceramic mug featuring Portsmouth city landmarks.',
      price: 8.99,
      imageUrl: 'assets/images/city_mug.png',
      isLocalImage: true,
      collectionId: 'city',
      sizes: [],
      images: [
        'assets/images/city_mug.png',
        'assets/images/city_mug_alt.png',
      ],
      colors: ['White', 'Black'],
    ),
    Product(
      id: 'city-bag',
      name: 'Portsmouth City Bag',
      description: 'Durable tote bag with city skyline design.',
      price: 12.99,
      imageUrl: 'assets/images/city_bag.png',
      isLocalImage: true,
      collectionId: 'city',
      sizes: [],
      images: [
        'assets/images/city_bag.png',
        'assets/images/city_bag_alt.png',
      ],
      colors: ['Black', 'Navy', 'Beige'],
    ),
    Product(
      id: 'city-tee',
      name: 'Spinnaker Tower T-Shirt',
      description: 'Minimalist Spinnaker Tower print tee.',
      price: 16.99,
      imageUrl: 'assets/images/city_spinnaker_tee.png',
      isLocalImage: true,
      collectionId: 'city',
      sizes: ['S', 'M', 'L', 'XL'],
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