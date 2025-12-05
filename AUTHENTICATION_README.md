# Authentication System Documentation

## Overview
A complete user authentication and account management system with Firebase integration and Google Sign-In support.

## Features

### 1. **Email/Password Authentication**
- User registration with email and password
- Secure login with validation
- Password strength requirements (minimum 6 characters)
- Email confirmation matching during signup
- Password visibility toggle

### 2. **Google Sign-In Integration**
- One-click Google authentication
- Automatic account creation for new Google users
- Profile data sync (name, email, photo)

### 3. **Password Management**
- Forgot password functionality
- Password reset via email
- Secure password recovery flow

### 4. **Account Dashboard**
- User profile display with avatar
- Quick stats (orders, wishlist, reviews)
- Account information card
- Quick action buttons for common tasks

### 5. **Profile Management**
- Edit profile information
- Update personal details:
  - Display name
  - Phone number
  - Delivery address
  - City and postcode
  - Country
- Form validation
- Real-time updates

## File Structure

```
lib/
├── models/
│   └── user_model.dart              # User data model
├── providers/
│   └── auth_provider.dart           # Authentication state management
├── pages/
│   ├── login_page.dart              # Login screen
│   ├── sign_up_page.dart            # Registration screen
│   ├── account_dashboard_page.dart  # User dashboard
│   └── edit_profile_page.dart       # Profile editor
```

## Dependencies

```yaml
dependencies:
  firebase_core: ^2.24.2
  firebase_auth: ^4.15.3
  google_sign_in: ^6.1.6
  cloud_firestore: ^4.13.6
  provider: ^6.0.0
```

## Setup Instructions

### 1. Firebase Configuration

**IMPORTANT**: You need to set up Firebase for your project:

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or select existing
3. Add your Flutter app to the project
4. Download configuration files:
   - **Android**: `google-services.json` → `android/app/`
   - **iOS**: `GoogleService-Info.plist` → `ios/Runner/`
   - **Web**: Add Firebase config to `web/index.html`

5. Enable Authentication methods in Firebase Console:
   - Go to Authentication → Sign-in method
   - Enable "Email/Password"
   - Enable "Google"

6. Set up Firestore Database:
   - Go to Firestore Database
   - Create database in production mode
   - Set up security rules (see below)

### 2. Android Configuration

Add to `android/app/build.gradle`:
```gradle
apply plugin: 'com.google.gms.google-services'
```

Add to `android/build.gradle`:
```gradle
dependencies {
    classpath 'com.google.gms:google-services:4.3.15'
}
```

### 3. iOS Configuration

No additional configuration needed beyond adding `GoogleService-Info.plist`.

### 4. Web Configuration

Add Firebase SDK scripts to `web/index.html` before `</body>`:
```html
<script src="https://www.gstatic.com/firebasejs/10.7.0/firebase-app-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/10.7.0/firebase-auth-compat.js"></script>
<script src="https://www.gstatic.com/firebasejs/10.7.0/firebase-firestore-compat.js"></script>
<script>
  const firebaseConfig = {
    apiKey: "YOUR_API_KEY",
    authDomain: "YOUR_AUTH_DOMAIN",
    projectId: "YOUR_PROJECT_ID",
    storageBucket: "YOUR_STORAGE_BUCKET",
    messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
    appId: "YOUR_APP_ID"
  };
  firebase.initializeApp(firebaseConfig);
</script>
```

### 5. Firestore Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

## Usage

### Accessing Authentication

The auth system uses Provider for state management. Access it anywhere:

```dart
// Get auth provider
final authProvider = context.read<AuthProvider>();

// Check if user is logged in
if (authProvider.isAuthenticated) {
  // User is logged in
  final user = authProvider.currentUser;
}
```

### Navigation

- `/login` - Login page
- `/signup` - Registration page
- `/account` - Account dashboard (requires auth)
- `/edit-profile` - Profile editor (requires auth)

### Account Icon

The account icon in the navbar navigates to `/account`. If not logged in, it shows a prompt to sign in.

## Features Detail

### User Model Properties
- `uid` - Unique user identifier
- `email` - User email address
- `displayName` - User's display name
- `photoUrl` - Profile photo URL
- `phoneNumber` - Contact number
- `address` - Delivery address
- `city` - City name
- `postcode` - Postal code
- `country` - Country name
- `createdAt` - Account creation date
- `lastLogin` - Last login timestamp
- `preferences` - User preferences (extensible)

### Security Features
- Password strength validation
- Email format validation
- Secure Firebase authentication
- Password visibility toggle
- Session management
- Automatic token refresh

### Error Handling
- User-friendly error messages
- Firebase error translation
- Form validation feedback
- Loading states
- Network error handling

## Future Enhancements

Potential additions:
- Email verification requirement
- Two-factor authentication
- Social login (Facebook, Apple)
- Order history integration
- Wishlist functionality
- Address book management
- Profile photo upload
- Account deletion
- Export user data (GDPR compliance)

## Testing

**Note**: Firebase needs to be configured before testing authentication features.

Test accounts can be created through:
1. Sign up form
2. Firebase Console → Authentication → Users → Add user

## Troubleshooting

### Common Issues

1. **Google Sign-In not working**
   - Ensure SHA-1/SHA-256 fingerprints are added in Firebase Console
   - Check package name matches Firebase configuration

2. **Firestore permission denied**
   - Verify security rules are set correctly
   - Check user is authenticated before writing

3. **Build errors on Android**
   - Ensure `google-services.json` is in correct location
   - Check Gradle plugin version compatibility

4. **iOS build errors**
   - Verify `GoogleService-Info.plist` is added to Xcode project
   - Check minimum iOS version (11.0+)

## Support

For issues related to:
- Firebase setup: [Firebase Documentation](https://firebase.google.com/docs)
- Google Sign-In: [Google Sign-In Flutter](https://pub.dev/packages/google_sign_in)
- Provider: [Provider Package](https://pub.dev/packages/provider)
