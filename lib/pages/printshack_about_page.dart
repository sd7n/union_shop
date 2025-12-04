import 'package:flutter/material.dart';
import 'package:union_shop/widgets/page_shell.dart';

class PrintShackAboutPage extends StatelessWidget {
  const PrintShackAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The Print Shack',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 24),
          Text(
            'Welcome to The Print Shack, your one-stop destination for custom printed apparel and merchandise. We specialize in high-quality screen printing, embroidery, and digital printing services to bring your designs to life.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'Whether you need custom hoodies for your society, personalized t-shirts for an event, or branded merchandise for your organization, our experienced team is here to help. We use premium materials and state-of-the-art printing techniques to ensure your products look great and last long.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
