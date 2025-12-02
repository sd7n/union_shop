import 'package:flutter/material.dart';
import '../widgets/page_shell.dart';
import '../widgets/product_grid_card.dart';

class SalePage extends StatelessWidget {
  const SalePage({super.key});

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
            'Sale',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Save on official university merchandise — limited offers.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.local_fire_department, color: Colors.red, size: 36),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Up to 30% off selected items!',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
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
                    title: 'Classic Navy Hoodie (Sale)',
                    price: '£24.99',
                    onTap: () => _goToProduct(context),
                  ),
                  ProductGridCard(
                    title: 'Freshers Hoodie 2025 (Sale)',
                    price: '£22.99',
                    onTap: () => _goToProduct(context),
                  ),
                  ProductGridCard(
                    title: 'University Mug (Sale)',
                    price: '£6.99',
                    onTap: () => _goToProduct(context),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
