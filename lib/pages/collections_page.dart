import 'package:flutter/material.dart';
import 'package:union_shop/widgets/page_shell.dart';
import 'package:union_shop/widgets/collection_card.dart';
import '../services/data_service.dart';
import '../models/collection.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  void _goToCollection(BuildContext context) {
    Navigator.pushNamed(context, '/collection');
  }

  @override
  Widget build(BuildContext context) {
    final data = DataService.instance;
    final collections = data.collections;

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
              ...collections.map((collection) {
                return Column(
                  children: [
                    CollectionCard(
                      title: collection.name,
                      subtitle: collection.description,
                      onTap: () => _goToCollection(context),
                    ),
                    SizedBox(height: 16),
                  ],
                );
              }).toList(),
              SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }
}
