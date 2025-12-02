import 'package:flutter/material.dart';
import 'package:union_shop/widgets/page_shell.dart';
import 'package:union_shop/widgets/collection_card.dart';
import '../services/data_service.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

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
          SizedBox(height: 16),
          Column(
            children: collections.map((c) {
              return Column(
                children: [
                  CollectionCard(
                    title: c.name,
                    subtitle: c.description,
                    collectionId: c.id,
                    imageUrl: c.imageUrl,
                    isLocalImage: c.isLocalImage,
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/collection',
                      arguments: c.id,
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              );
            }).toList(),
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}
