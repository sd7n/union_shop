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
          final searchTerm = searchProvider.searchTerm;

          if (results.isEmpty) {
            return Center(
              child: Text(
                'No results found for "$searchTerm"',
                style: const TextStyle(fontSize: 16),
              ),
            );
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  '${results.length} results for \'$searchTerm\''.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
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
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
