import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:union_shop/providers/cart_provider.dart';
import 'package:union_shop/providers/search_provider.dart';
import 'package:union_shop/providers/auth_provider.dart';
import 'package:union_shop/pages/home_page.dart';
import 'package:union_shop/pages/about_page.dart';
import 'package:union_shop/pages/collections_page.dart';
import 'package:union_shop/pages/collections_detail_page.dart';
import 'package:union_shop/pages/product_page.dart';
import 'package:union_shop/pages/sale_page.dart';
import 'package:union_shop/pages/auth_page.dart';
import 'package:union_shop/pages/cart_page.dart';
import 'package:union_shop/pages/search_results_page.dart';
import 'package:union_shop/pages/login_page.dart';
import 'package:union_shop/pages/sign_up_page.dart';
import 'package:union_shop/pages/printshack_about_page.dart';
import 'package:union_shop/pages/personalisation_product_page.dart';
import 'package:union_shop/pages/account_dashboard_page.dart';
import 'package:union_shop/pages/edit_profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDF19PvDKGpprw-4tn6DwknVQ00ks-2L50",
      authDomain: "union-shop-27cb5.firebaseapp.com",
      projectId: "union-shop-27cb5",
      storageBucket: "union-shop-27cb5.firebasestorage.app",
      messagingSenderId: "923412595450",
      appId: "1:923412595450:web:20bb5e5c577a866546bf43",
      measurementId: "G-K56ZEHHRP3",
    ),
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
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
      builder: (context, child) => child!,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/about': (context) => const AboutPage(),
        '/collection': (context) => const CollectionsPage(),
        '/collection-detail': (context) => const CollectionsDetailPage(),
        '/product': (context) => const ProductPage(),
        '/sale': (context) => const SalePage(),
        '/auth': (context) => const AuthPage(),
        '/cart': (context) => const CartPage(),
        '/search': (context) => const SearchResultsPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/printshack-about': (context) => const PrintShackAboutPage(),
        '/personalisation': (context) => const PersonalisationProductPage(),
        '/account': (context) => const AccountDashboardPage(),
        '/edit-profile': (context) => const EditProfilePage(),
      },
    );
  }
}
