import 'package:flutter/material.dart';
import 'package:union_shop/widgets/page_shell.dart';
import 'package:union_shop/widgets/collection_card.dart';
import '../services/data_service.dart';
import '../models/collection.dart';
import '../models/product.dart';

class CollectionsPage extends StatefulWidget {
  const CollectionsPage({super.key});

  @override
  State<CollectionsPage> createState() => _CollectionsPageState();
}

class _CollectionsPageState extends State<CollectionsPage> {
  final DataService _data = DataService.instance;

  late final List<Collection> _collections;
  late final List<Product> _allProducts;

  String _selectedCollectionId = 'all';
  String _selectedSort = 'featured';

  @override
  void initState() {
    super.initState();
    _collections = _data.collections;
    _allProducts = _data.products;
  }

  List<Product> get _visibleProducts {
    // 1. Filter
    List<Product> filtered = _allProducts.where((p) {
      if (_selectedCollectionId == 'all') return true;
      return p.collectionId == _selectedCollectionId;
    }).toList();

    // 2. Sort
    switch (_selectedSort) {
      case 'price_low':
        filtered.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_high':
        filtered.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'featured':
      default:
        break;
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final data = DataService.instance;
    final collections = data.collections;

    return PageShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Collections',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 16),
          Column(
            children: collections.map((c) {
              return Column(
                children: [
                  CollectionCard(
                    title: c.name,
                    subtitle: c.description,
                    collectionId: c.id,
                    imageUrl: c.imageUrl,
                    isLocalImage: c.isLocalImage,
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/collection',
                      arguments: c.id,
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              );
            }).toList(),
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
