import 'package:flutter/material.dart';
import 'navbar.dart';
import 'navbar_drawer.dart';
import 'footer.dart';

class PageShell extends StatelessWidget {
  final Widget child;
  const PageShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 900;

    return Scaffold(
      appBar: const Navbar(),
      endDrawer: const NavbarDrawer(),
      body: Container(
        color: Colors.grey.shade50,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isWide ? 32 : 16,
            vertical: 24,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  child,
                  const SizedBox(height: 48),
                  const Footer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}