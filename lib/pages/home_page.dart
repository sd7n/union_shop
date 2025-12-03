import 'package:flutter/material.dart';
import 'package:union_shop/widgets/page_shell.dart';
import '../services/data_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _navigate(BuildContext context) {
    Navigator.pushNamed(context, '/collections');
  }

  void _goToProduct(BuildContext context, String productId) {
    Navigator.pushNamed(
      context,
      '/product',
      arguments: productId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 600;
    final data = DataService.instance;
    final featured = [
      data.getProduct('hoodie-navy'),
      data.getProduct('tee-classic'),
      data.getProduct('mug-uni'),
    ];

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
                    ...featured.map((p) {
                      return Column(
                        children: [
                          _FeaturedProductCard(
                            title: p.name,
                            price: '£${p.price.toStringAsFixed(2)}',
                            onView: () => _goToProduct(context, p.id),
                          ),
                          const SizedBox(height: 12),
                        ],
                      );
                    }).toList(),
                  ],
                );
              }
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
                children: featured.map((p) {
                  return _FeaturedProductCard(
                    title: p.name,
                    price: '£${p.price.toStringAsFixed(2)}',
                    onView: () => _goToProduct(context, p.id),
                  );
                }).toList(),
              );
            },
          ),
          SizedBox(height: isWide ? 48 : 32),
        ],
      ),
    );
  }
}

class _FeaturedProductCard extends StatelessWidget {
  final String title;
  final String price;
  final VoidCallback onView;

  const _FeaturedProductCard({
    required this.title,
    required this.price,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final inGrid = constraints.maxWidth < 400;
        final imageSize = inGrid ? 60.0 : 72.0;
        final padding = inGrid ? 8.0 : 12.0;

        return _HoverableProductCard(
          imageSize: imageSize,
          padding: padding,
          title: title,
          price: price,
          onView: onView,
        );
      },
    );
  }
}

class _HoverableProductCard extends StatefulWidget {
  final double imageSize;
  final double padding;
  final String title;
  final String price;
  final VoidCallback onView;

  const _HoverableProductCard({
    required this.imageSize,
    required this.padding,
    required this.title,
    required this.price,
    required this.onView,
  });

  @override
  State<_HoverableProductCard> createState() => _HoverableProductCardState();
}

class _HoverableProductCardState extends State<_HoverableProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 1.0, end: _isHovered ? 1.02 : 1.0),
        duration: const Duration(milliseconds: 200),
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: child,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: _isHovered
                ? Border.all(color: Theme.of(context).colorScheme.secondary)
                : null,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Card(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: EdgeInsets.all(widget.padding),
                child: Row(
                  children: [
                    Container(
                      width: widget.imageSize,
                      height: widget.imageSize,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.image,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.price,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: widget.onView,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                foregroundColor:
                                    Theme.of(context).colorScheme.primary,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text('View'),
                                  SizedBox(width: 4),
                                  Icon(Icons.chevron_right, size: 18),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
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
