import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;

  AuthProvider() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser != null) {
      await _loadUserData(firebaseUser.uid);
    } else {
      _currentUser = null;
      notifyListeners();
    }
  }

  Future<void> _loadUserData(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        _currentUser = UserModel.fromMap(doc.data()!);
      } else {
        // Create a basic user model from Firebase Auth data if Firestore doc doesn't exist
        final firebaseUser = _auth.currentUser;
        if (firebaseUser != null) {
          _currentUser = UserModel(
            uid: firebaseUser.uid,
            email: firebaseUser.email ?? '',
            displayName: firebaseUser.displayName ?? 'User',
            photoUrl: firebaseUser.photoURL,
            createdAt: DateTime.now(),
            lastLogin: DateTime.now(),
          );
        }
      }
      notifyListeners();
    } catch (e) {
      // Even if Firestore fails, create a basic user from Firebase Auth
      final firebaseUser = _auth.currentUser;
      if (firebaseUser != null) {
        _currentUser = UserModel(
          uid: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          displayName: firebaseUser.displayName ?? 'User',
          photoUrl: firebaseUser.photoURL,
          createdAt: DateTime.now(),
          lastLogin: DateTime.now(),
        );
      }
      notifyListeners();
    }
  }

  Future<bool> signInWithEmailAndPassword(
      String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        try {
          await _updateLastLogin(credential.user!.uid);
        } catch (e) {
          // Firestore update failed, but login still successful
          print('Update last login failed: $e');
        }
        _isLoading = false;
        notifyListeners();
        return true;
      }
    } on FirebaseAuthException catch (e) {
      _errorMessage = _getFirebaseErrorMessage(e);
    } catch (e) {
      _errorMessage = 'An error occurred: ${e.toString()}';
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> signUpWithEmailAndPassword(
    String email,
    String password,
    String displayName,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        await credential.user!.updateDisplayName(displayName);

        final newUser = UserModel(
          uid: credential.user!.uid,
          email: email,
          displayName: displayName,
          createdAt: DateTime.now(),
          lastLogin: DateTime.now(),
        );

        // Try to save to Firestore, but don't fail if it doesn't work
        try {
          await _firestore
              .collection('users')
              .doc(credential.user!.uid)
              .set(newUser.toMap());
        } catch (e) {
          // Firestore save failed, but user is still created in Firebase Auth
          print('Firestore save failed: $e');
        }

        _currentUser = newUser;
        _isLoading = false;
        notifyListeners();
        return true;
      }
    } on FirebaseAuthException catch (e) {
      _errorMessage = _getFirebaseErrorMessage(e);
    } catch (e) {
      _errorMessage = 'An error occurred: ${e.toString()}';
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> signInWithGoogle() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        // Try to save/update in Firestore, but don't fail if it doesn't work
        try {
          final userDoc = await _firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .get();

          if (!userDoc.exists) {
            final newUser = UserModel(
              uid: userCredential.user!.uid,
              email: userCredential.user!.email!,
              displayName: userCredential.user!.displayName,
              photoUrl: userCredential.user!.photoURL,
              createdAt: DateTime.now(),
              lastLogin: DateTime.now(),
            );

            await _firestore
                .collection('users')
                .doc(userCredential.user!.uid)
                .set(newUser.toMap());
          } else {
            await _updateLastLogin(userCredential.user!.uid);
          }
        } catch (e) {
          // Silently ignore Firestore errors - authentication still succeeded
          print('Firestore operation failed (non-critical): $e');
        }

        _isLoading = false;
        notifyListeners();
        return true;
      }
    } on FirebaseAuthException catch (e) {
      _errorMessage = _getFirebaseErrorMessage(e);
    } catch (e) {
      // Only show error if it's not a Firestore issue
      if (!e.toString().contains('cloud_firestore') && 
          !e.toString().contains('unavailable')) {
        _errorMessage = 'Google sign-in failed: ${e.toString()}';
      }
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    _currentUser = null;
    notifyListeners();
  }

  Future<bool> resetPassword(String email) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _auth.sendPasswordResetEmail(email: email);
      _isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _errorMessage = _getFirebaseErrorMessage(e);
    } catch (e) {
      _errorMessage = 'An error occurred: ${e.toString()}';
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> updateProfile({
    String? displayName,
    String? phoneNumber,
    String? address,
    String? city,
    String? postcode,
    String? country,
  }) async {
    if (_currentUser == null) return false;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final updatedUser = _currentUser!.copyWith(
        displayName: displayName ?? _currentUser!.displayName,
        phoneNumber: phoneNumber ?? _currentUser!.phoneNumber,
        address: address ?? _currentUser!.address,
        city: city ?? _currentUser!.city,
        postcode: postcode ?? _currentUser!.postcode,
        country: country ?? _currentUser!.country,
      );

      await _firestore
          .collection('users')
          .doc(_currentUser!.uid)
          .update(updatedUser.toMap());

      if (displayName != null) {
        await _auth.currentUser?.updateDisplayName(displayName);
      }

      _currentUser = updatedUser;
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update profile: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> _updateLastLogin(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).update({
        'lastLogin': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      // Silently fail, not critical
    }
  }

  String _getFirebaseErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'email-already-in-use':
        return 'An account already exists with this email.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      default:
        return 'Authentication error: ${e.message}';
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
