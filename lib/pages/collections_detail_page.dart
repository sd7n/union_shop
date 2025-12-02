import 'package:flutter/material.dart';
import '../widgets/page_shell.dart';
import '../widgets/product_grid_card.dart';

class CollectionsDetailPage extends StatelessWidget {
  const CollectionsDetailPage({super.key});

  void _goToProduct(BuildContext context) {
    Navigator.pushNamed(context, '/product');
  }

  @override
  Widget build(BuildContext context) {
    return PageShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hoodies',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Explore our range of official university hoodies.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 600;
              final columns = isWide ? 2 : 1;

              return GridView.count(
                crossAxisCount: columns,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: isWide ? 3/4 : 3/3.8,
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
                  // cards will be added next
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
