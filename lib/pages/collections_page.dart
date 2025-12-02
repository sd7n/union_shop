import 'package:flutter/material.dart';
import 'package:union_shop/widgets/page_shell.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  void _goToCollection(BuildContext context) {
    Navigator.pushNamed(context, '/collection');
  }

  @override
  Widget build(BuildContext context) {
    return PageShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Collections',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24),
          Column(
            children: [
              CollectionCard(
                title: 'Hoodies',
                subtitle: 'Official university hoodies',
                onTap: () => _goToCollection(context),
              ),
              SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }
}
