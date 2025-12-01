import 'package:flutter/material.dart';

class CollectionsDetailPage extends StatelessWidget {
  const CollectionsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collection Details'),
      ),
      body: const Center(
        child: Text('Collections Detail Page'),
      ),
    );
  }
}
