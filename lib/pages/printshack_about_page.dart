import 'package:flutter/material.dart';
import 'package:union_shop/widgets/page_shell.dart';

class PrintShackAboutPage extends StatelessWidget {
  const PrintShackAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width >= 900;

    return PageShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title
          Text(
            'The Union Print Shack',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),

          // Image Grid
          _buildImageGrid(isWide),
          const SizedBox(height: 40),

          // Main Section
          _buildSection(
            context,
            title: 'Make It Yours at The Union Print Shack',
            content:
                'Want to add a personal touch? We\'ve got you covered with heat-pressed customisation on all our clothing. Swing by the shop - our team\'s always happy to help you pick the right gear and answer any questions.',
          ),

          // Uni Gear or Your Gear Section
          _buildSection(
            context,
            title: 'Uni Gear or Your Gear - We\'ll Personalise It',
            content:
                'Whether you\'re repping your university or putting your own spin on a hoodie you already own, we\'ve got you covered. We can personalise official uni-branded clothing and your own items - just bring them in and let\'s get creative!',
            italicText: 'and',
          ),

          // Simple Pricing Section
          _buildSection(
            context,
            title: 'Simple Pricing, No Surprises',
            content:
                'Customising your gear won\'t break the bank - just £3 for one line of text or a small chest logo, and £5 for two lines or a large back logo. Turnaround time is up to three working days, and we\'ll let you know as soon as it\'s ready to collect.',
          ),

          // Terms & Conditions Section
          _buildSection(
            context,
            title: 'Personalisation Terms & Conditions',
            content:
                'We will print your clothing exactly as you have provided it to us, whether online or in person. We are not responsible for any spelling errors. Please ensure your chosen text is clearly displayed in either capitals or lowercase. Refunds are not provided for any personalised items.',
          ),

          // Ready to Make It Yours Section
          _buildSection(
            context,
            title: 'Ready to Make It Yours?',
            content:
                'Pop in or get in touch today - let\'s create something uniquely you with our personalisation service - The Union Print Shack!',
          ),

          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildImageGrid(bool isWide) {
    final imageUrls = [
      'https://uk.rarevinyl.com/cdn/shop/files/playboy-carti-i-am-music-black-vinyl-sealed-uk-2-lp-vinyl-record-double-7814833-868119_1024x1024.jpg?v=1750953953',
      'https://union.host.cs.st-andrews.ac.uk/~sd7n/images/print_shack_logo.jpg',
      'https://union.host.cs.st-andrews.ac.uk/~sd7n/images/personalisation_1.jpg',
    ];

    if (isWide) {
      return Row(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                imageUrls[0],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(Icons.image, size: 50, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                imageUrls[1],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(Icons.image, size: 50, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                imageUrls[2],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(Icons.image, size: 50, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: imageUrls.map((url) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: AspectRatio(
              aspectRatio: 1.5,
              child: Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(Icons.image, size: 50, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          );
        }).toList(),
      );
    }
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String content,
    String? italicText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
          ),
          const SizedBox(height: 12),
          if (italicText != null)
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                      color: Colors.black87,
                    ),
                children: [
                  TextSpan(
                    text: content.split(italicText)[0],
                  ),
                  TextSpan(
                    text: italicText,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  TextSpan(
                    text: content.split(italicText)[1],
                  ),
                ],
              ),
            )
          else
            Text(
              content,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    height: 1.6,
                    color: Colors.black87,
                  ),
            ),
        ],
      ),
    );
  }
}
