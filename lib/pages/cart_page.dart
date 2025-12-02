import 'package:flutter/material.dart';
import 'package:union_shop/widgets/page_shell.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      child: const Center(
        child: Text('Cart Page'),
      ),
    );
  }
}
