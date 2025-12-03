import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/page_shell.dart';
import '../widgets/quantity_selector.dart';
import '../services/data_service.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String? selectedSize;
  int quantity = 1;
  String? selectedImage;

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final data = DataService.instance;
    final Product product = data.getProduct(productId);

    selectedSize ??= product.sizes.isNotEmpty ? product.sizes.first : null;

    return PageShell(
      fullWidth: true,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 900;

          if (isWide) {
            return _buildWideLayout(context, product);
          }

          return _buildMobileLayout(context, product);
        },
      ),
    );
  }

  Widget _buildWideLayout(BuildContext context, Product product) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(selectedImage ?? product.imageUrl, fit: BoxFit.cover),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: (product.images ?? [product.imageUrl])
                      .map((img) {
                    return GestureDetector(
                      onTap: () => setState(() => selectedImage = img),
                      child: Container(
                        width: 80,
                        height: 80,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: selectedImage == img
                                ? Colors.black
                                : Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: Image.network(img, fit: BoxFit.cover),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 48),
        Expanded(
          child: _buildProductDetails(context, product),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 240,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          product.name,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          '£${product.price.toStringAsFixed(2)}',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
        ),
        const SizedBox(height: 24),
        Text(
          product.description,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 24),
        if (product.sizes.isNotEmpty) ...[
          Text(
            'Size',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          DropdownButton<String>(
            value: selectedSize,
            items: product.sizes
                .map((size) => DropdownMenuItem(
                      value: size,
                      child: Text(size),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedSize = value;
              });
            },
          ),
          const SizedBox(height: 24),
        ],
        QuantitySelector(
          onChanged: (qty) {
            setState(() {
              quantity = qty;
            });
          },
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              final cartProvider = context.read<CartProvider>();
              cartProvider.add(product, quantity, selectedSize);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${product.name} added to cart'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Add to Cart'),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildProductDetails(BuildContext context, Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            if (product.strikePrice != null && product.strikePrice! > 0)
              Text(
                '£${product.strikePrice!.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey,
                ),
              ),
            if (product.strikePrice != null && product.strikePrice! > 0)
              const SizedBox(width: 12),
            Text(
              '£${product.price.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xFF4d2963),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Tax included',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 24),
        if (product.sizes.isNotEmpty) ...[
          Text(
            'Size',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          _styledDropdown(
            value: selectedSize,
            items: product.sizes,
            onChanged: (value) {
              setState(() {
                selectedSize = value;
              });
            },
          ),
          const SizedBox(height: 24),
        ],
        Text(
          'Quantity',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        QuantitySelector(
          onChanged: (qty) {
            setState(() {
              quantity = qty;
            });
          },
        ),
        const SizedBox(height: 32),
        GestureDetector(
          onTap: () {
            final cartProvider = context.read<CartProvider>();
            cartProvider.add(product, quantity, selectedSize);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${product.name} added to cart'),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.zero,
            ),
            child: const Center(
              child: Text(
                'ADD TO CART',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 48),
        Text(
          product.description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            height: 1.6,
            color: const Color(0xFF5F5F5F),
          ),
        ),
      ],
    );
  }

  Widget _styledDropdown({
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400, width: 1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButton<String>(
        value: value,
        items: items
            .map((item) => DropdownMenuItem(
          value: item,
          child: Text(item),
        ))
            .toList(),
        onChanged: onChanged,
        isExpanded: true,
        underline: const SizedBox.shrink(),
      ),
    );
  }
}
