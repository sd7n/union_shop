import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/search_provider.dart';
import '../widgets/page_shell.dart';

class SearchResultsPage extends StatelessWidget {
  const SearchResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      fullWidth: true,
      child: Consumer<SearchProvider>(
        builder: (context, searchProvider, _) {
          final results = searchProvider.results;

          if (results.isEmpty) {
            return Center(
              child: Text(
                'No results found for "${searchProvider.searchTerm}"',
                style: const TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final product = results[index];
              return ListTile(
                leading: Image.network(
                  product.imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(product.name),
                subtitle: Text('£${product.price.toStringAsFixed(2)}'),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/product',
                    arguments: product.id,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
