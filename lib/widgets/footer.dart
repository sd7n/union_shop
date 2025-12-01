import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

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
        ],
      ),
    );
  }
}
