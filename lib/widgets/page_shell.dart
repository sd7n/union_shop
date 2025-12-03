import 'package:flutter/material.dart';
import 'footer.dart';
import 'navbar.dart';
import 'navbar_drawer.dart';

class PageShell extends StatelessWidget {
  final Widget child;

  final bool fullWidth;

  const PageShell({
    super.key,
    required this.child,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Navbar(),
      endDrawer: const NavbarDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: fullWidth
                    ? child
                    : Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 1200),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 24,
                            ),
                            child: child,
                          ),
                        ),
                      ),
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}