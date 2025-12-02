import 'package:flutter/material.dart';
import 'package:union_shop/widgets/page_shell.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _goToCollections(BuildContext context) {
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

    return PageShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Union Shop',
                  style: (isWide
                          ? Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontSize: 40)
                          : Theme.of(context).textTheme.headlineMedium)
                      ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: isWide ? 20 : 12),
                Text(
                  'Official University merchandise, clothing and accessories.',
                  style: (isWide
                          ? Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontSize: 18)
                          : Theme.of(context).textTheme.bodyLarge)
                      ?.copyWith(
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: isWide ? 32 : 20),
                SizedBox(
                  width: isWide ? 180 : double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _goToCollections(context),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(140, 48),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                    ),
                    child: const Text('Shop Now'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Text(
            'Featured Products',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Divider(
            thickness: 1,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return Column(
                  children: [
                    _FeaturedProductCard(
                      title: 'Uni Hoodie',
                      price: '£29.99',
                      onView: () => _goToProduct(context, 'uni-hoodie'),
                    ),
                    const SizedBox(height: 12),
                    _FeaturedProductCard(
                      title: 'Union T-Shirt',
                      price: '£14.99',
                      onView: () => _goToProduct(context, 'union-tshirt'),
                    ),
                    const SizedBox(height: 12),
                    _FeaturedProductCard(
                      title: 'Logo Mug',
                      price: '£9.99',
                      onView: () => _goToProduct(context, 'logo-mug'),
                    ),
                    const SizedBox(height: 12),
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
                children: [
                  _FeaturedProductCard(
                    title: 'Uni Hoodie',
                    price: '£29.99',
                    onView: () => _goToProduct(context, 'uni-hoodie'),
                  ),
                  _FeaturedProductCard(
                    title: 'Union T-Shirt',
                    price: '£14.99',
                    onView: () => _goToProduct(context, 'union-tshirt'),
                  ),
                  _FeaturedProductCard(
                    title: 'Logo Mug',
                    price: '£9.99',
                    onView: () => _goToProduct(context, 'logo-mug'),
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
            border:
                _isHovered ? Border.all(color: Colors.blue.shade200) : null,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Card(
            elevation: 2,
            shadowColor: Colors.black12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: Padding(
              padding: EdgeInsets.all(widget.padding),
              child: Row(
                children: [
                  Container(
                    width: widget.imageSize,
                    height: widget.imageSize,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
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
                                color: Colors.green.shade700,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: widget.onView,
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              foregroundColor: Colors.blue,
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
