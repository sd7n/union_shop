import 'package:flutter/material.dart';
import '../widgets/page_shell.dart';

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
        ],
      ),
    );
  }
}
