import 'package:flutter/material.dart';
import 'package:union_shop/widgets/page_shell.dart';
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
          const SizedBox(height: 24),
          Row(
            children: [
              Text(
                'FILTER BY',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: _selectedCollectionId,
                items: [
                  const DropdownMenuItem(
                    value: 'all',
                    child: Text('All products'),
                  ),
                  ..._collections.map(
                    (c) => DropdownMenuItem(
                      value: c.id,
                      child: Text(c.name),
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _selectedCollectionId = value;
                  });
                },
              ),
              const Spacer(),
              Text(
                'SORT BY',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(width: 8),
              DropdownButton<String>(
                value: _selectedSort,
                items: const [
                  DropdownMenuItem(
                    value: 'featured',
                    child: Text('Featured'),
                  ),
                  DropdownMenuItem(
                    value: 'price_low',
                    child: Text('Price: Low to High'),
                  ),
                  DropdownMenuItem(
                    value: 'price_high',
                    child: Text('Price: High to Low'),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _selectedSort = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 900;
              final crossAxisCount = isWide ? 3 : 2;

              if (products.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 48),
                  child: Center(
                    child: Text('No products found for this selection.'),
                  ),
                );
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: isWide ? 3 / 3.8 : 3 / 4.3,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductTile(
                    product: product,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/product',
                        arguments: product.id,
                      );
                    },
                  );
                },
              );
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
