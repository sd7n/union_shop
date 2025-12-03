import 'package:flutter/material.dart';
import 'package:union_shop/widgets/page_shell.dart';
import 'package:union_shop/widgets/product_tile.dart';
import '../services/data_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigate(BuildContext context) {
    Navigator.pushNamed(context, '/collections');
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 600;

    return PageShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 420,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    'https://shop.upsu.net/cdn/shop/files/PortsmouthCityPostcard2_1024x1024@2x.jpg?v=1752232561',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.65),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "UNION SHOP",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Your official store for University of Portsmouth\nmerchandise, clothing & accessories.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 18,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: () => _navigate(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4d2963),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 28,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          child: const Text(
                            "BROWSE PRODUCTS",
                            style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
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
          SizedBox(height: isWide ? 48 : 32),
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
