import 'package:flutter/material.dart';
import 'package:union_shop/widgets/page_shell.dart';
import 'package:union_shop/widgets/product_tile.dart';
import 'package:union_shop/widgets/hero_section.dart';
import '../services/data_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigate(BuildContext context) {
    Navigator.pushNamed(context, '/collections');
  }

  Widget _productRow(BuildContext context, List products) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Column(
            children: products
                .map((product) => Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: ProductTile(
                        product: product,
                        onTap: () => Navigator.pushNamed(
                          context,
                          '/product',
                          arguments: product.id,
                        ),
                      ),
                    ))
                .toList(),
          );
        }
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 24,
          childAspectRatio: 0.8,
          children: products
              .map((product) => ProductTile(
                    product: product,
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/product',
                      arguments: product.id,
                    ),
                  ))
              .toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = DataService.instance;
    final signature = data.getProductsForCollection('signature');
    final city = data.getProductsForCollection('city');

    return PageShell(
      fullWidth: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeroSection(
            onPressed: () => _navigate(context),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "FEATURED PRODUCTS",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Divider(
                  thickness: 1,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 24),
                _productRow(context, [
                  DataService.instance.getProduct('hoodie-navy'),
                  DataService.instance.getProduct('tee-classic'),
                  DataService.instance.getProduct('mug-uni'),
                ]),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SIGNATURE RANGE",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Divider(
                  thickness: 1,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 24),
                _productRow(context, signature),
              ],
            ),
          ),
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PORTSMOUTH CITY COLLECTION",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Divider(
                  thickness: 1,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 24),
                _productRow(context, city),
              ],
            ),
          ),
          const SizedBox(height: 64),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
