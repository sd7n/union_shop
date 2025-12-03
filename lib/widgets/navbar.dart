import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  const Navbar({super.key});

  void _go(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 600;

    if (isWide) {
      return AppBar(
        title: const Text('Union Shop'),
        actions: [
          TextButton(
            onPressed: () => _go(context, '/'),
            child: const Text(
              'Home',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () => _go(context, '/collections'),
            child: const Text(
              'Collections',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () => _go(context, '/sale'),
            child: const Text(
              'Sale',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () => _go(context, '/about'),
            child: const Text(
              'About',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () => _go(context, '/auth'),
            child: const Text(
              'Sign In',
              style: TextStyle(color: Colors.white),
            ),
          ),
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                onPressed: () => _go(context, '/cart'),
                icon: const Icon(Icons.shopping_cart),
              ),
              Consumer<CartProvider>(
                builder: (context, cartProvider, child) {
                  final itemCount = cartProvider.cart.itemCount;
                  if (itemCount == 0) return const SizedBox.shrink();
                  return Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$itemCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      );
    }
    return AppBar(
      title: const Text('Union Shop'),
      actions: [
        Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
