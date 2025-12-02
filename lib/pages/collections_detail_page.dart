import 'package:flutter/material.dart';
import '../widgets/page_shell.dart';
import '../widgets/product_grid_card.dart';
import '../services/data_service.dart';

class CollectionsDetailPage extends StatelessWidget {
  const CollectionsDetailPage({super.key});

  void _goToProduct(BuildContext context) {
    Navigator.pushNamed(context, '/product');
  }

  @override
  Widget build(BuildContext context) {
    final collectionId = ModalRoute.of(context)!.settings.arguments as String;
    final data = DataService.instance;
    final collection = data.getCollection(collectionId);

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
                children: [
                  ProductGridCard(
                    title: 'Classic Navy Hoodie',
                    price: '£29.99',
                    onTap: () => _goToProduct(context),
                  ),
                  ProductGridCard(
                    title: 'University Zip Hoodie',
                    price: '£34.99',
                    onTap: () => _goToProduct(context),
                  ),
                  ProductGridCard(
                    title: 'Sport Hoodie',
                    price: '£32.99',
                    onTap: () => _goToProduct(context),
                  ),
                  ProductGridCard(
                    title: 'Freshers Hoodie 2025',
                    price: '£28.99',
                    onTap: () => _goToProduct(context),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
