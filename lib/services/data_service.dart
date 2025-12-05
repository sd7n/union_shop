import '../models/app_data.dart';
import '../models/collection.dart';
import '../models/product.dart';

class DataService {
  static final DataService instance = DataService._();

  DataService._() {
    load();
  }

  late final AppData appData;

  final _collections = const [
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

  final _products = const [
    Product(
      id: 'hoodie-uni',
      name: 'Classic Uni Hoodie',
      description: 'A warm, durable hoodie featuring the university crest.',
      price: 29.99,
      strikePrice: 39.99,
      imageUrl: 'https://images.stockx.com/images/Bape-Color-Camo-Double-Shark-Full-Zip-Hoodie-Purple.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&updated_at=1621458689',
      isLocalImage: false,
      collectionId: 'hoodies',
      sizes: ['S', 'M', 'L', 'XL'],
      images: [
        'https://images.stockx.com/images/Bape-Color-Camo-Double-Shark-Full-Zip-Hoodie-Purple.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&updated_at=1621458689',
        'https://images.stockx.com/images/BAPE-Color-Camo-Shark-Full-Zip-Hoodie-SS23-Black.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&updated_at=1677221030',
        'https://images.stockx.com/images/Bape-Color-Camo-Shark-Full-Zip-Hoodie-Blue.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&updated_at=1613587108',
      ],
      colors: ['Purple', 'Black', 'Blue'],
    ),
    Product(
      id: 'hoodie-zip',
      name: 'University Zip Hoodie',
      description: 'Front-zip hoodie with embroidered university logo.',
      price: 34.99,
      strikePrice: 44.99,
      imageUrl: 'https://images.stockx.com/images/Denim-Tears-The-Cotton-Wreath-Sweatshirt-Black-ProductX.jpg?fit=fill&bg=FFFFFF&w=1200&h=857&q=60&dpr=1&trim=color&updated_at=1744142786',
      isLocalImage: false,
      collectionId: 'hoodies',
      sizes: ['S', 'M', 'L', 'XL'],
      images: [
        'https://images.stockx.com/images/Denim-Tears-The-Cotton-Wreath-Sweatshirt-Black-ProductX.jpg?fit=fill&bg=FFFFFF&w=1200&h=857&q=60&dpr=1&trim=color&updated_at=1744142786',
        'https://images.stockx.com/images/Denim-Tears-The-Cotton-Wreath-Sweatshirt-Grey-Product.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&updated_at=1744140720',
        'https://images.stockx.com/images/Denim-Tears-The-Cotton-Wreath-Sweatshirt-Pink-Product.jpg?fit=fill&bg=FFFFFF&w=1200&h=857&q=60&dpr=1&trim=color&updated_at=1744142786'
      ],
      colors: ['Black', 'Grey', 'Pink'],
    ),
    Product(
      id: 'tee-classic',
      name: 'Classic Uni T-Shirt',
      description: 'Soft cotton tee with printed university logo.',
      price: 14.99,
      imageUrl: 'https://images.stockx.com/images/Palace-x-Vivienne-Westwood-T-Shirt-Purple.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&updated_at=1725629789',
      isLocalImage: false,
      collectionId: 'tshirts',
      sizes: ['S', 'M', 'L', 'XL'],
      images: [
        'https://images.stockx.com/images/Palace-x-Vivienne-Westwood-T-Shirt-Purple.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&updated_at=1725629789',
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
      strikePrice: 9.99,
      imageUrl: 'https://i.ebayimg.com/images/g/vmYAAOSw0qZmqbFO/s-l1200.jpg',
      isLocalImage: false,
      collectionId: 'accessories',
      sizes: [],
      images: [
        'https://i.ebayimg.com/images/g/vmYAAOSw0qZmqbFO/s-l1200.jpg',
        'https://m.media-amazon.com/images/I/51vd-NSbFVL.jpg',
      ],
      colors: ['Purple', 'White'],
    ),
    Product(
      id: 'tote-campus',
      name: 'Campus Tote Bag',
      description: 'Durable tote bag with campus map design.',
      price: 9.99,
      strikePrice: 12.99,
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
      imageUrl: 'https://i.ebayimg.com/images/g/r~8AAOSwQKpntCdq/s-l1200.jpg',
      isLocalImage: false,
      collectionId: 'signature',
      sizes: ['S', 'M', 'L', 'XL'],
      images: [
        'https://i.ebayimg.com/images/g/r~8AAOSwQKpntCdq/s-l1200.jpg',
        'assets/images/sig_hoodie_alt.png',
      ],
      colors: ['Black', 'Navy', 'Burgundy'],
    ),
    Product(
      id: 'sig-tee',
      name: 'Signature T-Shirt',
      description: 'Exclusive signature collection t-shirt with premium finish.',
      price: 19.99,
      imageUrl: 'https://images.stockx.com/images/Supreme-Cross-Box-Logo-Tee-Purple.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&updated_at=1744142786',
      isLocalImage: false,
      collectionId: 'signature',
      sizes: ['S', 'M', 'L', 'XL'],
      images: [
        'https://images.stockx.com/images/Supreme-Cross-Box-Logo-Tee-Purple.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&updated_at=1744142786',
        'assets/images/sig_tee_alt.png',
      ],
      colors: ['White', 'Black', 'Grey'],
    ),
    Product(
      id: 'city-mug',
      name: 'Portsmouth City Mug',
      description: 'Ceramic mug featuring Portsmouth city landmarks.',
      price: 8.99,
      imageUrl: 'https://images.stockx.com/images/Louis-Vuitton-x-Takashi-Murakami-Monogram-Multicolor-LV-Cup-PM-White-Multicolored-Product.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&trimcolor=ffffff&updated_at=1738703544',
      isLocalImage: false,
      collectionId: 'city',
      sizes: [],
      images: [
        'https://images.stockx.com/images/Louis-Vuitton-x-Takashi-Murakami-Monogram-Multicolor-LV-Cup-PM-White-Multicolored-Product.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&trimcolor=ffffff&updated_at=1738703544',
        'https://images.stockx.com/images/Louis-Vuitton-x-Takashi-Murakami-Set-of-2-Cherry-Coffee-Cups-and-Saucers-White-Monogram-Product.jpg?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&trimcolor=ffffff&updated_at=1751058752',
      ],
      colors: ['White', 'Double'],
    ),
    Product(
      id: 'city-bag',
      name: 'Portsmouth City Bag',
      description: 'Durable tote bag with city skyline design.',
      price: 12.99,
      imageUrl: 'https://cdn.webshopapp.com/shops/89710/files/322715876/chloe-chloe-paddington-padlock-bag-in-purple.jpg',
      isLocalImage: false,
      collectionId: 'city',
      sizes: [],
      images: [
        'https://cdn.webshopapp.com/shops/89710/files/322715876/chloe-chloe-paddington-padlock-bag-in-purple.jpg',
        'https://f08c4e54.aerocdn.com/image-factory/768x768/images/products/Cc6wAWRCZL01GrTjQMDDcAPAeSBXt1buqeMM7TxQ.jpg',
        'https://f08c4e54.aerocdn.com/image-factory/768x768/images/products/VehXW4E2w5zajTZZosAyVLDuLPEbffpQUtYADIQF.jpg'
      ],
      colors: ['Purple', 'Red', 'Navy'],
    ),
    Product(
      id: 'city-tee',
      name: 'Spinnaker Tower T-Shirt',
      description: 'Minimalist Spinnaker Tower print tee.',
      price: 16.99,
      imageUrl: 'https://m.media-amazon.com/images/I/51ZBsueRaQL._AC_UY1000_.jpg',
      isLocalImage: false,
      collectionId: 'city',
      sizes: ['S', 'M', 'L', 'XL'],
      images: [
        'https://m.media-amazon.com/images/I/51ZBsueRaQL._AC_UY1000_.jpg',
        'https://image-cdn.hypb.st/https%3A%2F%2Fs3.store.hypebeast.com%2Fmedia%2Fimage%2F07%2Ffe%2Ftshirt-3-1-d6c4c.jpg?fit=max&w=720&q=90',
      ],
      colors: ['White', 'Black'],
    ),
    Product(
      id: 'notebook-a5-purple',
      name: 'A5 Notepad',
      description: 'Purple A5 notepad with university branding.',
      price: 4.99,
      imageUrl: 'https://union.host.cs.st-andrews.ac.uk/~sd7n/images/a5_notepad.jpg',
      isLocalImage: false,
      collectionId: 'stationery',
      sizes: [],
    ),
    Product(
      id: 'sweatshirt-neutral-sand',
      name: 'Classic Sweatshirts - Neutral',
      description: 'Comfortable neutral colored sweatshirt with university branding.',
      price: 10.99,
      strikePrice: 17.00,
      imageUrl: 'https://union.host.cs.st-andrews.ac.uk/~sd7n/images/sweatshirt_sand.jpg',
      isLocalImage: false,
      collectionId: 'hoodies',
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['Sand', 'Cream'],
    ),
    Product(
      id: 'recycled-notebook',
      name: 'Recycled Notebook',
      description: 'Eco-friendly recycled notebook with colorful pens.',
      price: 1.80,
      imageUrl: 'https://union.host.cs.st-andrews.ac.uk/~sd7n/images/recycled_notebook.jpg',
      isLocalImage: false,
      collectionId: 'stationery',
      sizes: [],
    ),
    Product(
      id: 'iphone-cable',
      name: 'iPhone 5/6 Charge & Sync Cable',
      description: 'Premium charging cable for iPhone 5/6.',
      price: 1.50,
      strikePrice: 3.00,
      imageUrl: 'https://union.host.cs.st-andrews.ac.uk/~sd7n/images/iphone_cable.jpg',
      isLocalImage: false,
      collectionId: 'accessories',
      sizes: [],
    ),
    Product(
      id: 'typec-cable',
      name: 'Type C Charge & Sync Cable',
      description: 'High-speed Type C charging cable.',
      price: 1.50,
      strikePrice: 3.00,
      imageUrl: 'https://union.host.cs.st-andrews.ac.uk/~sd7n/images/typec_cable.jpg',
      isLocalImage: false,
      collectionId: 'accessories',
      sizes: [],
    ),
    Product(
      id: 'usb-cable',
      name: 'USB to USB Charge & Sync Cables',
      description: 'Universal USB charging cables.',
      price: 1.50,
      strikePrice: 3.00,
      imageUrl: 'https://union.host.cs.st-andrews.ac.uk/~sd7n/images/usb_cable.jpg',
      isLocalImage: false,
      collectionId: 'accessories',
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
      _collections.firstWhere(
        (c) => c.id == id,
        orElse: () => _collections.first,
      );

  Product getProduct(String id) => _products.firstWhere(
        (p) => p.id == id,
        orElse: () => _products.first,
      );

  List<Product> getProductsForCollection(String id) =>
      _products.where((p) => p.collectionId == id).toList();
}