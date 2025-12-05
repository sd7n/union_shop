import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductTile({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: product.isLocalImage
                  ? Image.asset(product.imageUrl, fit: BoxFit.cover)
                  : Image.network(product.imageUrl, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          if (product.strikePrice != null)
            Row(
              children: [
                Text(
                  '£${product.strikePrice!.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '£${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          else
            Text(
              '£${product.price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
        ],
      ),
    );
  }
}
