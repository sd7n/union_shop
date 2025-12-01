import 'package:flutter/material.dart';
import 'navbar.dart';
import 'navbar_drawer.dart';
import 'footer.dart';

class PageShell extends StatelessWidget {
  final Widget child;
  const PageShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(),
      endDrawer: const NavbarDrawer(),
      body: child,
    );
  }
}