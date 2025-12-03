import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductGridCard extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;
  final bool isLocalImage;
  final String productId;
  final String? externalUrl;

  const ProductGridCard({
    super.key,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.productId,
    this.isLocalImage = false,
    this.externalUrl,
  });

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => Navigator.pushNamed(
          context,
          '/product',
          arguments: productId,
        ),
        onLongPress: externalUrl != null ? () => _launchUrl(externalUrl!) : null,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: isLocalImage
                      ? Image.asset(imageUrl, fit: BoxFit.cover)
                      : Image.network(imageUrl, fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 4),
              Text(
                price,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
