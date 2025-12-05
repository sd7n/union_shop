# The Union Shop 

A comprehensive Flutter e-commerce application for the University of Portsmouth Students' Union Shop, offering official university merchandise, custom printing services, and personalised gifts.

![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?style=flat&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-2.17+-0175C2?style=flat&logo=dart)
![Firebase](https://img.shields.io/badge/Firebase-Enabled-FFCA28?style=flat&logo=firebase)

##  Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Screenshots](#screenshots)
- [Installation & Setup](#installation--setup)
- [Usage Instructions](#usage-instructions)
- [Running Tests](#running-tests)
- [Project Structure](#project-structure)
- [Technologies Used](#technologies-used)
- [Known Issues & Future Improvements](#known-issues--future-improvements)
- [Contributing](#contributing)
- [Contact](#contact)

##  Overview

The Union Shop is a full-featured e-commerce Flutter application designed for the University of Portsmouth Students' Union. It provides students, staff, and alumni with easy access to:

- **Official University Merchandise** - Hoodies, t-shirts, accessories, and stationery
- **The Print Shack** - Custom printing and personalisation services
- **Collections** - Organized product categories (Clothing, Accessories, Stationery, etc.)
- **Sales & Promotions** - Special offers and discounted items
- **User Accounts** - Firebase authentication with Google Sign-In support
- **Shopping Cart** - Persistent cart with local storage
- **Search Functionality** - Quick product search across all collections

##  Key Features

###  Shopping Experience
- **Responsive Design** - Optimized for mobile, tablet, and desktop viewing
- **Hero Carousel** - Rotating promotional banners on the homepage
- **Product Collections** - Browse products by category (Hoodies, T-Shirts, Accessories, Stationery)
- **Product Details** - View product images, descriptions, prices, available sizes and colors
- **Sale Items** - Dedicated page for discounted products with strike-through pricing
- **Shopping Cart** - Add, update, and remove items with size/color selection
- **Persistent Cart** - Cart data saved locally using SharedPreferences

###  Print Shack
- **Custom Printing Services** - Heat-pressed customization on clothing
- **Personalisation Options** - Add 1-4 lines of text with dynamic pricing
- **Pricing Calculator** - Real-time price updates based on text lines and quantity
- **Service Information** - Detailed about page explaining the printing process

###  User Authentication
- **Email/Password Registration** - Standard sign-up flow
- **Google Sign-In** - Quick authentication with Google accounts
- **Firebase Authentication** - Secure user management
- **User Profiles** - Account dashboard with editable profile information
- **Profile Management** - Update display name, phone, address, and other details

###  Search & Navigation
- **Global Search** - Search products by name or description
- **Search Overlay** - Quick-access search bar in navigation
- **Smart Navigation** - Dropdown menus for collections and print shack
- **Breadcrumb Navigation** - Easy back navigation throughout the app

###  UI/UX Features
- **Custom Theme** - University-branded purple color scheme (#4d2963)
- **Responsive Layouts** - Adapts to different screen sizes
- **Navigation Drawer** - Mobile-friendly menu
- **Footer** - Comprehensive links and information
- **Loading States** - User feedback during data operations
- **Error Handling** - Graceful error messages

##  Screenshots

### Homepage
The main landing page features a hero carousel showcasing promotional content, featured product collections, and quick navigation to popular categories.
<img width="1918" height="1091" alt="image" src="https://github.com/user-attachments/assets/1eb8e801-bd5b-4460-9e5c-4c0af0565ea8" />

### Product Collections
Browse products organized by category with grid layouts that adapt to screen size. Each product displays pricing, images, and essential information.
<img width="1919" height="1087" alt="image" src="https://github.com/user-attachments/assets/88b61a36-6159-4ca8-892c-787b973a74e1" />

### Print Shack
Custom printing service page with detailed pricing information and text customization options.
<img width="1918" height="1084" alt="image" src="https://github.com/user-attachments/assets/74ff86ad-4440-452c-bc85-61f1136be860" />

##  Installation & Setup

### Prerequisites

Before you begin, ensure you have the following installed:

- **Operating System:** Windows 10/11, macOS 10.14+, or Linux
- **Flutter SDK:** Version 3.0 or higher
  - [Install Flutter](https://docs.flutter.dev/get-started/install)
- **Dart SDK:** Version 2.17 or higher (included with Flutter)
- **IDE:** 
  - [Visual Studio Code](https://code.visualstudio.com/) with Flutter extension, or
  - [Android Studio](https://developer.android.com/studio) with Flutter plugin
- **Git:** For cloning the repository
- **Firebase Account:** For authentication features (free tier available)

### Step 1: Clone the Repository

```bash
git clone https://github.com/sd7n/union_shop.git
cd union_shop
```

### Step 2: Install Dependencies

```bash
flutter pub get
```

This will install all required packages listed in `pubspec.yaml`, including:
- `provider` - State management
- `firebase_core` - Firebase initialization
- `firebase_auth` - User authentication
- `cloud_firestore` - Database
- `google_sign_in` - Google authentication
- `shared_preferences` - Local data storage
- `url_launcher` - Opening external URLs

### Step 3: Firebase Configuration

The app uses Firebase for authentication. The Firebase configuration is already included in the code, but for production use, you should:

1. Create your own Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Enable Authentication (Email/Password and Google Sign-In)
3. Enable Firestore Database
4. Update the Firebase configuration in `lib/main.dart`:

```dart
await Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: "YOUR_API_KEY",
    authDomain: "YOUR_AUTH_DOMAIN",
    projectId: "YOUR_PROJECT_ID",
    storageBucket: "YOUR_STORAGE_BUCKET",
    messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
    appId: "YOUR_APP_ID",
    measurementId: "YOUR_MEASUREMENT_ID",
  ),
);
```

### Step 4: Run the Application

#### For Web (Chrome):
```bash
flutter run -d chrome
```

#### For Desktop (Windows):
```bash
flutter run -d windows
```

#### For Mobile (Android/iOS):
```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device_id>
```

### Step 5: Hot Reload

Once running, you can use hot reload to see changes instantly:
- Press `r` in the terminal for hot reload
- Press `R` for hot restart
- Press `q` to quit

##  Usage Instructions

### Browsing Products

1. **Homepage:** Start at the homepage to view featured products and hero carousel
2. **Shop Menu:** Click "Shop" in the navigation bar to access dropdown categories
3. **Collections:** Browse products by category (Hoodies, T-Shirts, Accessories, etc.)
4. **Product Details:** Click any product to view detailed information

### Shopping Cart

1. **Add to Cart:** On product pages, select size/color and click "Add to Cart"
2. **View Cart:** Click the shopping cart icon in the navigation bar
3. **Update Quantity:** Use +/- buttons to adjust item quantities
4. **Remove Items:** Click the remove button to delete items from cart
5. **Checkout:** (Currently displays cart total - checkout flow to be implemented)

### Search Functionality

1. Click the search icon () in the navigation bar
2. Type your search query in the overlay that appears
3. Press Enter or click the search button
4. View search results filtered by product name and description

### Print Shack Services

1. Navigate to "The Print Shack" from the navigation menu
2. Click "About" to learn about custom printing services
3. Click "Personalisation" to customize text-based products
4. Select number of text lines (1-4) - pricing updates automatically
5. Enter your custom text and adjust quantity
6. Add to cart

### User Authentication

1. **Sign Up:** Click account icon  Sign Up  Fill in details
2. **Sign In:** Click account icon  Sign In  Enter credentials
3. **Google Sign-In:** Click "Sign in with Google" for quick authentication
4. **Profile Management:** Access account dashboard to view/edit profile
5. **Sign Out:** Click logout button in account dashboard

### Configuration Options

The app uses `DataService` as a singleton to manage product and collection data. To modify products or collections, edit:
- `lib/services/data_service.dart`

Cart persistence uses `shared_preferences`. Data is automatically saved and restored on app restart.

##  Running Tests

The project includes comprehensive unit and logic tests covering models, providers, services, widgets, and pages.

### Run All Tests

```bash
flutter test
```

### Run Specific Test File

```bash
flutter test test/models/product_test.dart
```

### Run Tests with Coverage

```bash
flutter test --coverage
```

### Test Structure

```
test/
 models/          # Model tests (Product, Cart, Collection, etc.)
 providers/       # State management tests (CartProvider, SearchProvider, etc.)
 services/        # Service layer tests (DataService)
 widgets/         # Widget logic tests
 pages/           # Page logic tests
```

### Test Statistics

- **Total Tests:** 238
- **Models:** 30 tests
- **Providers:** 41 tests  
- **Services:** 8 tests
- **Widgets:** 33 tests
- **Pages:** 36 tests
- **Auth:** 5 tests
- **Other:** 85 tests

All tests focus on logic validation without widget rendering or image loading to ensure reliability.

##  Project Structure

```
union_shop/
 lib/
    main.dart                 # App entry point & Firebase initialization
    models/                   # Data models
       product.dart          # Product model
       cart.dart             # Cart model
       cart_item.dart        # Cart item model
       collection.dart       # Collection model
       hero_slide.dart       # Hero carousel slide model
       app_data.dart         # App data aggregator
       user_model.dart       # User profile model
    pages/                    # Screen/page widgets
       home_page.dart        # Homepage with hero & featured products
       product_page.dart     # Product detail page
       cart_page.dart        # Shopping cart
       collections_page.dart # Collections listing
       collections_detail_page.dart # Collection products
       sale_page.dart        # Sale/discounted products
       search_results_page.dart # Search results
       printshack_about_page.dart # Print Shack info
       personalisation_product_page.dart # Custom text products
       about_page.dart       # About the union shop
       auth_page.dart        # Authentication wrapper
       login_page.dart       # Login form
       sign_up_page.dart     # Registration form
       account_dashboard_page.dart # User profile
       edit_profile_page.dart # Profile editing
    providers/                # State management (Provider pattern)
       cart_provider.dart    # Shopping cart state
       search_provider.dart  # Search state
       auth_provider.dart    # Authentication state
    services/                 # Business logic layer
       data_service.dart     # Product & collection data (singleton)
    widgets/                  # Reusable UI components
        navbar.dart           # Top navigation bar
        navbar_drawer.dart    # Mobile navigation drawer
        page_shell.dart       # Page layout wrapper
        footer.dart           # Footer with links
        hero_section.dart     # Homepage carousel
        product_tile.dart     # Product card
        product_grid_card.dart # Grid product card
        cart_list_tile.dart   # Cart item display
        collection_card.dart  # Collection card
        quantity_selector.dart # Quantity +/- buttons
        search_overlay.dart   # Search bar overlay
 test/                         # Test files (mirrors lib/ structure)
 android/                      # Android platform files
 ios/                          # iOS platform files
 web/                          # Web platform files
 windows/                      # Windows platform files
 linux/                        # Linux platform files
 macos/                        # macOS platform files
 pubspec.yaml                  # Dependencies & app configuration
 README.md                     # This file
```

### Key Files

- **`lib/main.dart`** - Application entry point, Firebase initialization, routing configuration
- **`lib/services/data_service.dart`** - Singleton service managing all products and collections
- **`lib/providers/cart_provider.dart`** - Shopping cart state management with persistence
- **`lib/widgets/page_shell.dart`** - Consistent page layout with navbar and footer
- **`pubspec.yaml`** - Project dependencies and Flutter configuration

##  Technologies Used

### Frontend Framework
- **Flutter 3.0+** - UI framework for cross-platform development
- **Dart 2.17+** - Programming language

### State Management
- **Provider 6.0+** - Lightweight state management solution
  - `CartProvider` - Shopping cart state
  - `SearchProvider` - Search functionality state
  - `AuthProvider` - User authentication state

### Backend & Services
- **Firebase Core 3.6+** - Firebase SDK initialization
- **Firebase Auth 5.3+** - User authentication and authorization
- **Cloud Firestore 5.4+** - NoSQL database for user data
- **Google Sign-In 6.2+** - Google OAuth integration

### Data Persistence
- **SharedPreferences 2.2+** - Local storage for cart data

### Utilities
- **URL Launcher 6.2+** - Opening external links
- **Cupertino Icons 1.0+** - iOS-style icons

### Development Tools
- **Flutter Lints 2.0+** - Dart code analysis and linting
- **Flutter Test** - Unit and widget testing framework

### Design Patterns
- **Singleton Pattern** - DataService for centralized data management
- **Provider Pattern** - State management across the app
- **Repository Pattern** - Data layer abstraction

### Platform Support
-  Web (Chrome, Firefox, Safari, Edge)
-  Windows Desktop
-  Android (with additional configuration)
-  iOS (with additional configuration)
-  macOS (with additional configuration)
-  Linux (with additional configuration)

##  Known Issues & Future Improvements

### Known Issues

1. **Firebase Configuration** - Currently uses development Firebase credentials (should be replaced for production)
2. **Product Images** - Some product images use external URLs which may be slow to load
3. **Checkout Flow** - Payment processing not yet implemented
4. **Order History** - User order tracking not yet implemented
5. **Inventory Management** - No stock tracking system implemented

### Planned Improvements

#### Short-term (Next Release)
- [ ] Implement complete checkout flow with payment gateway integration
- [ ] Add product reviews and ratings system
- [ ] Implement wishlist/favorites feature
- [ ] Add email verification for new accounts
- [ ] Improve image loading with caching and placeholders
- [ ] Add loading skeletons for better UX

#### Medium-term
- [ ] Order history and tracking for users
- [ ] Push notifications for order updates and promotions
- [ ] Implement inventory management system
- [ ] Add product filters (size, color, price range)
- [ ] Multi-language support
- [ ] Dark mode theme

#### Long-term
- [ ] Admin dashboard for product management
- [ ] Analytics dashboard for sales tracking
- [ ] Customer support chat integration
- [ ] Loyalty points and rewards system
- [ ] Mobile app optimization and native features
- [ ] SEO optimization for web platform

### Performance Optimizations Needed
- Implement lazy loading for product images
- Add pagination for large product lists
- Optimize build methods to reduce widget rebuilds
- Implement image caching strategy

##  Contributing

Contributions are welcome! This is a university coursework project, but improvements and bug fixes are appreciated.

### How to Contribute

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Make your changes**
4. **Run tests**
   ```bash
   flutter test
   ```
5. **Commit your changes**
   ```bash
   git commit -m "Add amazing feature"
   ```
6. **Push to your branch**
   ```bash
   git push origin feature/amazing-feature
   ```
7. **Open a Pull Request**

### Contribution Guidelines

- Follow the existing code style and structure
- Write tests for new features
- Update documentation as needed
- Ensure all tests pass before submitting PR
- Provide clear commit messages

##  Contact

**Developer:** SDedi  
**Institution:** University of Portsmouth  
**Project:** Y2 Programming Coursework - Flutter E-commerce Application

### Links
- **GitHub Repository:** [github.com/sd7n/union_shop](https://github.com/sd7n/union_shop)
- **Issue Tracker:** [Report Issues](https://github.com/sd7n/union_shop/issues)

### Support

For questions, suggestions, or issues:
- Open an issue on GitHub
- Contact via university email (available on request)

---

##  License

This project is developed as coursework for the University of Portsmouth. All rights reserved.

The University of Portsmouth Students' Union branding and assets are property of their respective owners.

---

##  Acknowledgments

- **University of Portsmouth** - For project inspiration and requirements
- **Students' Union** - For brand assets and collaboration
- **Flutter Team** - For the amazing framework
- **Firebase** - For backend services
- **Open Source Community** - For packages and support

---

Made with  using Flutter
