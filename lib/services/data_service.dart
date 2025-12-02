import '../models/app_data.dart';
import '../models/collection.dart';

class DataService {
  static final DataService instance = DataService._();
  DataService._();

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
}