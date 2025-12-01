import 'package:flutter/material.dart';
import 'package:union_shop/pages/home_page.dart';
import 'package:union_shop/pages/about_page.dart';
import 'package:union_shop/pages/collections_page.dart';
import 'package:union_shop/pages/collections_detail_page.dart';

void main() {
  runApp(const UnionShopApp());
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
      ),
      home: const HomeScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/about': (context) => const AboutPage(),
        '/collections': (context) => const CollectionsPage(),
        '/collections-detail': (context) => const CollectionsDetailPage(),
      },
    );
  }
}
