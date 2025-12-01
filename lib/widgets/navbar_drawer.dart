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
            child: Text('Union Shop', style: TextStyle(color: Colors.white)),
          ),
          ListTile(title: Text('Home'), onTap: () => _go(context, '/')),
          ListTile(title: Text('Collections'), onTap: () => _go(context, '/collections')),
          ListTile(title: Text('Sale'), onTap: () => _go(context, '/sale')),
          ListTile(title: Text('About'), onTap: () => _go(context, '/about')),
          ListTile(title: Text('Sign In'), onTap: () => _go(context, '/auth')),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Cart'),
            onTap: () => _go(context, '/cart'),
          ),
        ],
      ),
    );
  }
}
