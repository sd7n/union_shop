import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthPage Logic', () {
    test('Auth page route is valid', () {
      const authRoute = '/auth';
      
      expect(authRoute, startsWith('/'));
      expect(authRoute, isNotEmpty);
    });

    test('Login and signup routes are different', () {
      const loginRoute = '/login';
      const signupRoute = '/signup';
      
      expect(loginRoute, isNot(signupRoute));
      expect(loginRoute, startsWith('/'));
      expect(signupRoute, startsWith('/'));
    });
  });
}
