import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class Navbar extends StatelessWidget implements PreferredSizeWidget {
  const Navbar({super.key});

  void _go(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  void _goHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 900;

    return PreferredSize(
      preferredSize: const Size.fromHeight(110),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6),
            color: const Color(0xFF4d2963),
            child: const Text(
              'BIG SALE! OUR ESSENTIAL RANGE HAS DROPPED IN PRICE! OVER 20% OFF!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Color(0xFFDDDDDD), width: 1),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => _goHome(context),
                  child: Image.network(
                    'https://shop.upsu.net/cdn/shop/files/upsu_300x300.png?v=1614735854',
                    height: 32,
                  ),
                ),
                const Spacer(),
                if (isWide) ...[
                  _navLink(context, 'Home', '/'),
                  _navLink(context, 'Shop', '/collections'),
                  _navLink(context, 'The Print Shack', '/collections'),
                  _navLink(context, 'Sale!', '/sale'),
                  _navLink(context, 'About', '/about'),
                ],
                const SizedBox(width: 16),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                      color: const Color(0xFF5F5F5F),
                    ),
                    IconButton(
                      icon: const Icon(Icons.person_outline),
                      onPressed: () {},
                      color: const Color(0xFF5F5F5F),
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        IconButton(
                          onPressed: () => _go(context, '/cart'),
                          icon: const Icon(Icons.shopping_bag_outlined),
                          color: const Color(0xFF5F5F5F),
                        ),
                        Positioned(
                          right: 2,
                          top: 3,
                          child: Consumer<CartProvider>(
                            builder: (context, cartProvider, _) {
                              final count = cartProvider.cart.itemCount;
                              if (count == 0) return const SizedBox();
                              return Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  '$count',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    if (!isWide)
                      Builder(builder: (context) {
                        return IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () {
                            Scaffold.of(context).openEndDrawer();
                          },
                        );
                      }),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navLink(BuildContext context, String label, String route) {
    return TextButton(
      onPressed: () => _go(context, route),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF2B2B2B),
          fontSize: 14,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(110);
}
