import 'package:flutter/material.dart';

class ProductGridCard extends StatelessWidget {
  final String title;
  final String price;
  final VoidCallback onTap;

  const ProductGridCard({
    super.key,
    required this.title,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.image),
                ),
              ),
              SizedBox(height: 12),
              Text(title,
                style: Theme.of(context).textTheme.titleMedium),
              SizedBox(height: 4),
              Text(price,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                )),
            ],
          ),
        ),
      ),
    );
  }
}
