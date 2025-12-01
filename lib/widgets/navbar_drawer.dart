import 'package:flutter/material.dart';

class NavbarDrawer extends StatelessWidget {
  const NavbarDrawer({super.key});

  void _go(BuildContext context, String route) {
    Navigator.pop(context); // close drawer
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Union Shop',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () => _go(context, '/'),
          ),
          ListTile(
            title: const Text('Collections'),
            onTap: () => _go(context, '/collections'),
          ),
          ListTile(
            title: const Text('Sale'),
            onTap: () => _go(context, '/sale'),
          ),
          ListTile(
            title: const Text('About'),
            onTap: () => _go(context, '/about'),
          ),
          ListTile(
            title: const Text('Sign In'),
            onTap: () => _go(context, '/auth'),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Cart'),
            onTap: () => _go(context, '/cart'),
          ),
        ],
      ),
    );
  }
}
