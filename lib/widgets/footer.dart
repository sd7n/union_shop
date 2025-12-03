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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      color: Colors.grey.shade200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Customer Service',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {},
            child: const Text('Contact Us'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('FAQs'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Returns Policy'),
          ),
          const SizedBox(height: 16),
          Text(
            'Information',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {},
            child: const Text('About the Union'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Privacy Policy'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Terms of Service'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Cookie Policy'),
          ),
          const SizedBox(height: 16),
          Text(
            'Follow Us',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.camera_alt),
                onPressed: () => _launchUrl('https://www.instagram.com/portsmouthuni/'),
                tooltip: 'Instagram',
              ),
              IconButton(
                icon: const Icon(Icons.mail_outline),
                onPressed: () => _launchUrl('https://x.com/portsmouthuni'),
                tooltip: 'Twitter',
              ),
              IconButton(
                icon: const Icon(Icons.play_circle_outline),
                onPressed: () => _launchUrl('https://www.youtube.com/c/universityofportsmouth'),
                tooltip: 'YouTube',
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
