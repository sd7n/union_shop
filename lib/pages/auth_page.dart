import 'package:flutter/material.dart';
import 'package:union_shop/widgets/page_shell.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      child: const Center(
        child: Text('Auth Page'),
      ),
    );
  }
}
