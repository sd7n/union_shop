import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductGridCard extends StatefulWidget {
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

  @override
  State<ProductGridCard> createState() => _ProductGridCardState();
}

class _ProductGridCardState extends State<ProductGridCard> {
  bool _isHovered = false;

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
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 1.0, end: _isHovered ? 1.05 : 1.0),
        duration: const Duration(milliseconds: 200),
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: _isHovered ? 8 : 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  onTap: () => Navigator.pushNamed(
                    context,
                    '/product',
                    arguments: widget.productId,
                  ),
                  onLongPress: widget.externalUrl != null ? () => _launchUrl(widget.externalUrl!) : null,
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
                              child: widget.isLocalImage
                                ? Image.asset(widget.imageUrl, fit: BoxFit.cover)
                                : Image.network(widget.imageUrl, fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.price,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
