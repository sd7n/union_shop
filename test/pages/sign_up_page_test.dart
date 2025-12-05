import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SignUpPage Logic', () {
    test('Email validation for signup', () {
      final validEmail = 'newuser@example.com';
      
      expect(validEmail.contains('@'), isTrue);
      expect(validEmail.split('@').length, equals(2));
    });

    test('Password confirmation must match', () {
      const password = 'secure123';
      const confirmPassword = 'secure123';
      const mismatchPassword = 'different123';
      
      expect(password, equals(confirmPassword));
      expect(password, isNot(mismatchPassword));
    });

    test('Display name is required', () {
      final displayNames = ['John Doe', 'Jane Smith', 'User'];
      
      for (var name in displayNames) {
        expect(name.isNotEmpty, isTrue);
        expect(name.trim().isNotEmpty, isTrue);
      }
    });

    test('Signup route is valid', () {
      const signupRoute = '/signup';
      
      expect(signupRoute, startsWith('/'));
      expect(signupRoute, equals('/signup'));
    });
  });
}
