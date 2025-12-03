import 'package:flutter/material.dart';
import '../widgets/page_shell.dart';
import '../widgets/product_tile.dart';
import '../services/data_service.dart';

class CollectionsDetailPage extends StatelessWidget {
  const CollectionsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final collectionId = ModalRoute.of(context)!.settings.arguments as String;
    final data = DataService.instance;
    final collection = data.getCollection(collectionId);
    final products = data.getProductsForCollection(collectionId);

    return PageShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            collection.name,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            collection.description,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          const SizedBox(height: 16),
          if (products.isEmpty)
            ...[
              Text('No products available in this collection.'),
              const SizedBox(height: 16),
            ],
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 600;
              final columns = isWide ? 2 : 1;

              return GridView.count(
                crossAxisCount: columns,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: isWide ? 3 / 4 : 3 / 3.8,
                children: products.map((p) {
                  return ProductTile(
                    product: p,
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/product',
                      arguments: p.id,
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

