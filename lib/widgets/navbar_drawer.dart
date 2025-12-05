import 'package:flutter/material.dart';

class NavbarDrawer extends StatelessWidget {
  const NavbarDrawer({super.key});

  void _go(BuildContext context, String route) {
    Navigator.pop(context);
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF4d2963)),
            child: Text(
              'Union Shop Menu',
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => _go(context, '/'),
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Collections'),
            onTap: () => _go(context, '/collection-detail'),
          ),
          ListTile(
            leading: const Icon(Icons.local_offer),
            title: const Text('Sale'),
            onTap: () => _go(context, '/sale'),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () => _go(context, '/about'),
          ),
          ListTile(
            leading: const Icon(Icons.person),
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
