import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/search_provider.dart';
import '../services/data_service.dart';
import 'package:union_shop/pages/search_results_page.dart';

class SearchOverlay extends StatelessWidget {
  final bool isVisible;

  const SearchOverlay({
    super.key,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: isVisible ? 0 : -100,
      left: 0,
      right: 0,
      height: 80,
      duration: const Duration(milliseconds: 300),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (value) {
                  context.read<SearchProvider>().setSearchTerm(value);
                },
                onSubmitted: (value) {
                  final searchProvider = context.read<SearchProvider>();
                  final allProducts = DataService.instance.products;
                  searchProvider.runSearch(allProducts);
                  Navigator.pushNamed(context, '/search');
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                final searchProvider = context.read<SearchProvider>();
                final allProducts = DataService.instance.products;
                searchProvider.runSearch(allProducts);
                Navigator.pushNamed(context, '/search');
              },
            ),
          ],
        ),
      ),
    );
  }
}
