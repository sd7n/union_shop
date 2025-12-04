import 'package:flutter/material.dart';
import 'package:union_shop/widgets/page_shell.dart';
import 'package:union_shop/widgets/collection_card.dart';
import 'package:union_shop/widgets/product_tile.dart';
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
    final products = _visibleProducts;

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
          Row(
            children: [
              Text('FILTER BY'),
              SizedBox(width: 8),
              DropdownButton<String>(
                value: _selectedCollectionId,
                items: [
                  DropdownMenuItem(value: 'all', child: Text('All products')),
                  ..._collections.map(
                    (c) => DropdownMenuItem(value: c.id, child: Text(c.name)),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCollectionId = value!;
                  });
                },
              ),
              Spacer(),
              Text('SORT BY'),
              SizedBox(width: 8),
              DropdownButton<String>(
                value: _selectedSort,
                items: const [
                  DropdownMenuItem(value: 'featured', child: Text('Featured')),
                  DropdownMenuItem(value: 'price_low', child: Text('Price: Low to High')),
                  DropdownMenuItem(value: 'price_high', child: Text('Price: High to Low')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedSort = value!;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 900;
              final crossAxisCount = isWide ? 3 : 2;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductTile(product: product);
                },
              );
            },
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
