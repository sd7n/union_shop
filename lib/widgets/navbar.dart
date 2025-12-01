import 'package:flutter/material.dart';

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
          IconButton(
            onPressed: () => _go(context, '/cart'),
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      );
    }
    return AppBar(
      title: const Text('Union Shop'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
