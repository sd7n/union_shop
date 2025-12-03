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

  @override
  Widget build(BuildContext context) {
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
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 600) {
                      return Column(
                        children: [
                          ProductTile(
                            product: DataService.instance.getProduct('hoodie-navy')!,
                            onTap: () => Navigator.pushNamed(
                              context,
                              '/product',
                              arguments: 'hoodie-navy',
                            ),
                          ),
                          const SizedBox(height: 24),
                          ProductTile(
                            product: DataService.instance.getProduct('tee-classic')!,
                            onTap: () => Navigator.pushNamed(
                              context,
                              '/product',
                              arguments: 'tee-classic',
                            ),
                          ),
                          const SizedBox(height: 24),
                          ProductTile(
                            product: DataService.instance.getProduct('mug-uni')!,
                            onTap: () => Navigator.pushNamed(
                              context,
                              '/product',
                              arguments: 'mug-uni',
                            ),
                          ),
                        ],
                      );
                    }
                    return GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 24,
                      childAspectRatio: 0.8,
                      children: [
                        ProductTile(
                          product: DataService.instance.getProduct('hoodie-navy')!,
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/product',
                            arguments: 'hoodie-navy',
                          ),
                        ),
                        ProductTile(
                          product: DataService.instance.getProduct('tee-classic')!,
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/product',
                            arguments: 'tee-classic',
                          ),
                        ),
                        ProductTile(
                          product: DataService.instance.getProduct('mug-uni')!,
                          onTap: () => Navigator.pushNamed(
                            context,
                            '/product',
                            arguments: 'mug-uni',
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
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
