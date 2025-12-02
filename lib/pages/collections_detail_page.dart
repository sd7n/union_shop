import 'package:flutter/material.dart';
import 'package:union_shop/widgets/page_shell.dart';

class CollectionsDetailPage extends StatelessWidget {
  const CollectionsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      child: const Center(
        child: Text('Collections Detail Page'),
      ),
    );
  }
}
