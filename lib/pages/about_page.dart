import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'About the Union Shop',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'The Union Shop is operated by the Students\' Union and provides official University merchandise, clothing, and accessories.',
            ),
            const SizedBox(height: 12),
            const Text(
              'Every purchase supports student activities, events, and services across the University community.',
            ),
            const SizedBox(height: 12),
            const Text(
              'From hoodies and t-shirts to accessories and stationery, the Union Shop offers products for students, staff, alumni, and visitors.',
            ),
            const SizedBox(height: 24),
            Text(
              'Why shop with us?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            const Text(
              'The Union Shop is the only official source of University merchandise, ensuring authenticity and quality. We offer a wide range of products, including clothing, accessories, and stationery, all designed and produced by the University.',
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• Official university-branded merchandise'),
                const Text('• Supports student clubs and societies'),
                const Text('• Fair pricing and regular promotions'),
                const Text('• Environmentally conscious product choices'),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
