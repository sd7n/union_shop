import 'package:flutter/material.dart';
import '../widgets/page_shell.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  void placeholderCallbackForButtons() {
    // This is the event handler for buttons that don't work yet
  }

  @override
  Widget build(BuildContext context) {
    return PageShell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 240,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Icon(Icons.image, size: 72),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
