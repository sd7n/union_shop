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

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 16),
                child: Text(
                  results.isEmpty
                      ? 'NO RESULTS FOR "$searchTerm"'
                      : '${results.length} RESULTS FOR "$searchTerm"',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: results.isEmpty
                    ? const Center(
                        child: Text(
                          'Try another search term',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : ListView.builder(
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
