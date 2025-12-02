import 'package:flutter/material.dart';
import 'package:union_shop/widgets/page_shell.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      child: const Center(
        child: Text('Collections Page'),
      ),
    );
  }
}
