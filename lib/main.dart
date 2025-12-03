import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/providers/cart_provider.dart';
import 'package:union_shop/pages/home_page.dart';
import 'package:union_shop/pages/about_page.dart';
import 'package:union_shop/pages/collections_page.dart';
import 'package:union_shop/pages/collections_detail_page.dart';
import 'package:union_shop/pages/product_page.dart';
import 'package:union_shop/pages/sale_page.dart';
import 'package:union_shop/pages/auth_page.dart';
import 'package:union_shop/pages/cart_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: const UnionShopApp(),
    ),
  );
}

class UnionShopApp extends StatelessWidget {
  const UnionShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Union Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4d2963)),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/about': (context) => const AboutPage(),
        '/collections': (context) => const CollectionsPage(),
        '/collection': (context) => const CollectionsDetailPage(),
        '/product': (context) => const ProductPage(),
        '/sale': (context) => const SalePage(),
        '/auth': (context) => const AuthPage(),
        '/cart': (context) => const CartPage(),
      },
    );
  }
}
