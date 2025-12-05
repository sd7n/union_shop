import 'package:flutter/material.dart';
import 'package:union_shop/widgets/page_shell.dart';
import '../services/data_service.dart';
import '../models/collection.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final collections = DataService.instance.collections;
    final isWide = MediaQuery.of(context).size.width >= 900;

    return PageShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Collections',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isWide ? 3 : 1,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: isWide ? 1.5 : 1.2,
            ),
            itemCount: collections.length,
            itemBuilder: (context, index) {
              final collection = collections[index];
              return _buildCollectionCard(context, collection);
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildCollectionCard(BuildContext context, Collection collection) {
    final imageMap = {
      'hoodies': 'https://images.genius.com/a6da0163f5a243554270d596746d6227.1000x1000x1.png',
      'tshirts': 'https://i.ebayimg.com/images/g/fDAAAOSwgMpksbxw/s-l1200.jpg',
      'accessories': 'https://upload.wikimedia.org/wikipedia/en/1/1f/Eternal_Atake_Lil_Uzi_Vert.jpg',
      'stationery': 'https://www.rollingstone.com/wp-content/uploads/2020/02/masterofreality.jpg',
      'printshack': 'https://union.host.cs.st-andrews.ac.uk/~sd7n/images/elections_discounts.jpg',
      'signature': 'https://union.host.cs.st-andrews.ac.uk/~sd7n/images/essential_range.jpg',
      'city': 'https://union.host.cs.st-andrews.ac.uk/~sd7n/images/clothing.jpg',
    };

    final imageUrl = imageMap[collection.id] ?? 
        'https://union.host.cs.st-andrews.ac.uk/~sd7n/images/clothing.jpg';

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/collection-detail',
          arguments: collection.id,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: const Center(
                      child: Icon(Icons.image, size: 50, color: Colors.grey),
                    ),
                  );
                },
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.5),
                    ],
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    collection.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
