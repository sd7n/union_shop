import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  void _go(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 900;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
      color: Colors.grey.shade100,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: isWide
              ? _buildWideLayout(context)
              : _buildMobileLayout(context),
        ),
      ),
    );
  }

  Widget _buildWideLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle("Customer Service"),
              _link(context, "Contact Us", "/contact"),
              _link(context, "FAQs", "/faqs"),
              _link(context, "Returns Policy", "/returns"),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle("Information"),
              _link(context, "About the Union", "/about"),
              _link(context, "Privacy Policy", "/privacy"),
              _link(context, "Terms of Service", "/terms"),
              _link(context, "Cookie Policy", "/cookies"),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle("Follow Us"),
              const SizedBox(height: 12),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.camera_alt_outlined),
                    iconSize: 22,
                    tooltip: 'Instagram',
                    onPressed: () => _launchUrl(
                      'https://www.instagram.com/portsmouthuni/',
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    icon: const Icon(Icons.email_outlined),
                    iconSize: 22,
                    tooltip: 'Twitter',
                    onPressed: () => _launchUrl('https://x.com/portsmouthuni'),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    icon: const Icon(Icons.play_circle_outline),
                    iconSize: 22,
                    tooltip: 'YouTube',
                    onPressed: () => _launchUrl(
                      'https://www.youtube.com/c/universityofportsmouth',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle("Customer Service"),
        _link(context, "Contact Us", "/contact"),
        _link(context, "FAQs", "/faqs"),
        _link(context, "Returns Policy", "/returns"),
        const SizedBox(height: 24),
        _sectionTitle("Information"),
        _link(context, "About the Union", "/about"),
        _link(context, "Privacy Policy", "/privacy"),
        _link(context, "Terms of Service", "/terms"),
        _link(context, "Cookie Policy", "/cookies"),
        const SizedBox(height: 24),
        _sectionTitle("Follow Us"),
        const SizedBox(height: 12),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.camera_alt_outlined),
              iconSize: 22,
              tooltip: 'Instagram',
              onPressed: () => _launchUrl(
                'https://www.instagram.com/portsmouthuni/',
              ),
            ),
            const SizedBox(width: 12),
            IconButton(
              icon: const Icon(Icons.email_outlined),
              iconSize: 22,
              tooltip: 'Twitter',
              onPressed: () => _launchUrl('https://x.com/portsmouthuni'),
            ),
            const SizedBox(width: 12),
            IconButton(
              icon: const Icon(Icons.play_circle_outline),
              iconSize: 22,
              tooltip: 'YouTube',
              onPressed: () => _launchUrl(
                'https://www.youtube.com/c/universityofportsmouth',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _link(BuildContext context, String text, String route) {
    return TextButton(
      onPressed: () => _go(context, route),
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        alignment: Alignment.centerLeft,
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF4d2963),
          fontSize: 15,
        ),
      ),
    );
  }
}
