import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/user_model.dart';

void main() {
  group('UserModel', () {
    final testDate = DateTime(2025, 12, 5);
    final testLastLogin = DateTime(2025, 12, 5, 10, 30);

    test('should create UserModel with required fields', () {
      final user = UserModel(
        uid: 'test123',
        email: 'test@example.com',
        createdAt: testDate,
      );

      expect(user.uid, 'test123');
      expect(user.email, 'test@example.com');
      expect(user.createdAt, testDate);
      expect(user.displayName, isNull);
      expect(user.photoUrl, isNull);
    });

    test('should create UserModel with all fields', () {
      final user = UserModel(
        uid: 'test123',
        email: 'test@example.com',
        displayName: 'Test User',
        photoUrl: 'https://example.com/photo.jpg',
        phoneNumber: '+1234567890',
        createdAt: testDate,
        lastLogin: testLastLogin,
        preferences: {'theme': 'dark'},
        address: '123 Test St',
        city: 'Portsmouth',
        postcode: 'PO1 2AB',
        country: 'UK',
      );

      expect(user.uid, 'test123');
      expect(user.email, 'test@example.com');
      expect(user.displayName, 'Test User');
      expect(user.photoUrl, 'https://example.com/photo.jpg');
      expect(user.phoneNumber, '+1234567890');
      expect(user.createdAt, testDate);
      expect(user.lastLogin, testLastLogin);
      expect(user.preferences, {'theme': 'dark'});
      expect(user.address, '123 Test St');
      expect(user.city, 'Portsmouth');
      expect(user.postcode, 'PO1 2AB');
      expect(user.country, 'UK');
    });

    test('toMap should convert UserModel to Map correctly', () {
      final user = UserModel(
        uid: 'test123',
        email: 'test@example.com',
        displayName: 'Test User',
        photoUrl: 'https://example.com/photo.jpg',
        phoneNumber: '+1234567890',
        createdAt: testDate,
        lastLogin: testLastLogin,
        preferences: {'theme': 'dark'},
        address: '123 Test St',
        city: 'Portsmouth',
        postcode: 'PO1 2AB',
        country: 'UK',
      );

      final map = user.toMap();

      expect(map['uid'], 'test123');
      expect(map['email'], 'test@example.com');
      expect(map['displayName'], 'Test User');
      expect(map['photoUrl'], 'https://example.com/photo.jpg');
      expect(map['phoneNumber'], '+1234567890');
      expect(map['createdAt'], testDate.toIso8601String());
      expect(map['lastLogin'], testLastLogin.toIso8601String());
      expect(map['preferences'], {'theme': 'dark'});
      expect(map['address'], '123 Test St');
      expect(map['city'], 'Portsmouth');
      expect(map['postcode'], 'PO1 2AB');
      expect(map['country'], 'UK');
    });

    test('toMap should handle null optional fields', () {
      final user = UserModel(
        uid: 'test123',
        email: 'test@example.com',
        createdAt: testDate,
      );

      final map = user.toMap();

      expect(map['uid'], 'test123');
      expect(map['email'], 'test@example.com');
      expect(map['displayName'], isNull);
      expect(map['photoUrl'], isNull);
      expect(map['phoneNumber'], isNull);
      expect(map['lastLogin'], isNull);
      expect(map['preferences'], isNull);
      expect(map['address'], isNull);
      expect(map['city'], isNull);
      expect(map['postcode'], isNull);
      expect(map['country'], isNull);
    });

    test('fromMap should create UserModel from Map correctly', () {
      final map = {
        'uid': 'test123',
        'email': 'test@example.com',
        'displayName': 'Test User',
        'photoUrl': 'https://example.com/photo.jpg',
        'phoneNumber': '+1234567890',
        'createdAt': testDate.toIso8601String(),
        'lastLogin': testLastLogin.toIso8601String(),
        'preferences': {'theme': 'dark'},
        'address': '123 Test St',
        'city': 'Portsmouth',
        'postcode': 'PO1 2AB',
        'country': 'UK',
      };

      final user = UserModel.fromMap(map);

      expect(user.uid, 'test123');
      expect(user.email, 'test@example.com');
      expect(user.displayName, 'Test User');
      expect(user.photoUrl, 'https://example.com/photo.jpg');
      expect(user.phoneNumber, '+1234567890');
      expect(user.createdAt, testDate);
      expect(user.lastLogin, testLastLogin);
      expect(user.preferences, {'theme': 'dark'});
      expect(user.address, '123 Test St');
      expect(user.city, 'Portsmouth');
      expect(user.postcode, 'PO1 2AB');
      expect(user.country, 'UK');
    });

    test('fromMap should handle missing optional fields', () {
      final map = {
        'uid': 'test123',
        'email': 'test@example.com',
        'createdAt': testDate.toIso8601String(),
      };

      final user = UserModel.fromMap(map);

      expect(user.uid, 'test123');
      expect(user.email, 'test@example.com');
      expect(user.createdAt, testDate);
      expect(user.displayName, isNull);
      expect(user.photoUrl, isNull);
      expect(user.phoneNumber, isNull);
      expect(user.lastLogin, isNull);
      expect(user.preferences, isNull);
      expect(user.address, isNull);
      expect(user.city, isNull);
      expect(user.postcode, isNull);
      expect(user.country, isNull);
    });

    test('fromMap should use defaults for missing required fields', () {
      final map = <String, dynamic>{};

      final user = UserModel.fromMap(map);

      expect(user.uid, '');
      expect(user.email, '');
      expect(user.createdAt, isA<DateTime>());
    });

    test('copyWith should create new instance with updated fields', () {
      final originalUser = UserModel(
        uid: 'test123',
        email: 'test@example.com',
        displayName: 'Test User',
        createdAt: testDate,
      );

      final updatedUser = originalUser.copyWith(
        displayName: 'Updated User',
        phoneNumber: '+1234567890',
      );

      expect(updatedUser.uid, 'test123');
      expect(updatedUser.email, 'test@example.com');
      expect(updatedUser.displayName, 'Updated User');
      expect(updatedUser.phoneNumber, '+1234567890');
      expect(updatedUser.createdAt, testDate);
    });

    test('copyWith should preserve original fields when not updated', () {
      final originalUser = UserModel(
        uid: 'test123',
        email: 'test@example.com',
        displayName: 'Test User',
        phoneNumber: '+1111111111',
        createdAt: testDate,
        address: '123 Test St',
      );

      final updatedUser = originalUser.copyWith(displayName: 'Updated User');

      expect(updatedUser.uid, 'test123');
      expect(updatedUser.email, 'test@example.com');
      expect(updatedUser.displayName, 'Updated User');
      expect(updatedUser.phoneNumber, '+1111111111');
      expect(updatedUser.createdAt, testDate);
      expect(updatedUser.address, '123 Test St');
    });

    test('copyWith with no parameters should return identical copy', () {
      final originalUser = UserModel(
        uid: 'test123',
        email: 'test@example.com',
        displayName: 'Test User',
        createdAt: testDate,
      );

      final copiedUser = originalUser.copyWith();

      expect(copiedUser.uid, originalUser.uid);
      expect(copiedUser.email, originalUser.email);
      expect(copiedUser.displayName, originalUser.displayName);
      expect(copiedUser.createdAt, originalUser.createdAt);
    });

    test('toMap and fromMap should be reversible', () {
      final originalUser = UserModel(
        uid: 'test123',
        email: 'test@example.com',
        displayName: 'Test User',
        photoUrl: 'https://example.com/photo.jpg',
        phoneNumber: '+1234567890',
        createdAt: testDate,
        lastLogin: testLastLogin,
        preferences: {'theme': 'dark', 'notifications': true},
        address: '123 Test St',
        city: 'Portsmouth',
        postcode: 'PO1 2AB',
        country: 'UK',
      );

      final map = originalUser.toMap();
      final reconstructedUser = UserModel.fromMap(map);

      expect(reconstructedUser.uid, originalUser.uid);
      expect(reconstructedUser.email, originalUser.email);
      expect(reconstructedUser.displayName, originalUser.displayName);
      expect(reconstructedUser.photoUrl, originalUser.photoUrl);
      expect(reconstructedUser.phoneNumber, originalUser.phoneNumber);
      expect(reconstructedUser.createdAt, originalUser.createdAt);
      expect(reconstructedUser.lastLogin, originalUser.lastLogin);
      expect(reconstructedUser.preferences, originalUser.preferences);
      expect(reconstructedUser.address, originalUser.address);
      expect(reconstructedUser.city, originalUser.city);
      expect(reconstructedUser.postcode, originalUser.postcode);
      expect(reconstructedUser.country, originalUser.country);
    });
  });
}
