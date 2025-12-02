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
              CollectionCard(
                title: 'T-Shirts',
                subtitle: 'Shirts, tees & casual wear',
                onTap: () => _goToCollection(context),
              ),
              SizedBox(height: 16),
              CollectionCard(
                title: 'Accessories',
                subtitle: 'Mugs, bags, lanyards & more',
                onTap: () => _goToCollection(context),
              ),
              SizedBox(height: 16),
              CollectionCard(
                title: 'Stationery',
                subtitle: 'Notebooks, pens & study items',
                onTap: () => _goToCollection(context),
              ),
              SizedBox(height: 16),
              CollectionCard(
                title: 'Print Shack',
                subtitle: 'Custom printing & personalised gifts',
                onTap: () => _goToCollection(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
