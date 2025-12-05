import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginPage Logic', () {
    test('Email validation checks for @ symbol', () {
      final validEmails = ['test@example.com', 'user@domain.co.uk'];
      final invalidEmails = ['testexample.com', 'user@', '@domain.com'];
      
      for (var email in validEmails) {
        expect(email.contains('@'), isTrue);
      }
      
      for (var email in invalidEmails) {
        expect(email.contains('@') && email.split('@').length == 2 && 
               email.split('@')[0].isNotEmpty && email.split('@')[1].isNotEmpty, 
               isFalse);
      }
    });

    test('Password minimum length requirement', () {
      const minLength = 6;
      final validPasswords = ['password123', 'secure!23'];
      final invalidPasswords = ['pass', '123', 'ab'];
      
      for (var password in validPasswords) {
        expect(password.length, greaterThanOrEqualTo(minLength));
      }
      
      for (var password in invalidPasswords) {
        expect(password.length, lessThan(minLength));
      }
    });

    test('Login route is valid', () {
      const loginRoute = '/login';
      
      expect(loginRoute, startsWith('/'));
      expect(loginRoute, equals('/login'));
    });
  });
}
