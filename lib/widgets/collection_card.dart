import 'package:flutter/material.dart';

class CollectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String collectionId;
  final String imageUrl;
  final bool isLocalImage;
  final VoidCallback onTap;

  const CollectionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.collectionId,
    required this.imageUrl,
    required this.isLocalImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // image box
              Container(
                width: 72,
                height: 72,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: isLocalImage
                    ? Image.asset(imageUrl, fit: BoxFit.cover)
                    : Image.network(imageUrl, fit: BoxFit.cover),
              ),
              SizedBox(width: 16),

              // text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
