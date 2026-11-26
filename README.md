# 🍵 Chiyagram (Chiya Ki Tapari)

[![Flutter](https://img.shields.io/badge/Flutter-v3.10%2B-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Auth%20%7C%20Firestore%20%7C%20Storage-FFCA28?logo=firebase&logoColor=black)](https://firebase.google.com/)
[![State Management](https://img.shields.io/badge/State-Provider-blue)](https://pub.dev/packages/provider)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-success)](https://flutter.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

> **Chiyagram** (inspired by *Chiya Ki Tapari*) is an artisanal tea cafe and lounge ordering mobile application built with Flutter. It brings authentic tea culture, specialty snacks, hookah lounge menus, multi-location discovery, and real-time ordering into an elegant, reactive mobile experience powered by Firebase.

---

## ✨ Features

### ☕ 1. Curated Artisanal Menu
- **Traditional Chiya & Teas:** Matka Chiya, Masala Chiya, Special Herbal Blends, Green Tea, and cold brews with detailed flavor profiles and customization.
- **Specialty Snacks & Bites:** Fresh cafe snacks, momos, bakery items, and comboboxes.
- **Hookah Lounge Menu:** Specialty hookah flavors, charcoal selections, and lounge combos.
- **Interactive Carousel & Categories:** Hero banners, trending items, and personalized recommendations.

### 📍 2. Cafe Branch & Location Finder
- Discover nearby cafe branches with addresses, opening hours, contact details, and directions.

### 🛒 3. Cart & Streamlined Checkout
- **Reactive Shopping Cart:** Increment, decrement, and remove items with real-time subtotal and tax calculation.
- **Smooth Checkout Flow:** Delivery/dine-in selection, order summary review, and order confirmation.

### 🔐 4. Secure Authentication & Profile
- **Firebase Authentication:**
  - Email & Password registration and login.
  - Interactive **Password Strength Meter** with real-time security validation (length, cases, numbers, symbols).
  - Password reset via email (`sendPasswordResetEmail`).
  - One-tap **Google Sign-In** integration.
- **User Profile Management:**
  - Edit personal details and upload profile photos directly to Firebase Storage.
  - My Orders history and past receipts tracking.
  - In-app feedback submission, terms of service, and privacy policy views.
  - Account settings with secure password updates and account deletion.

### 🔔 5. Notifications & Offline Monitoring
- **Local Notifications:** Instant alerts for order status, special offers, and cafe announcements using `flutter_local_notifications`.
- **Network Resilience:** Real-time connectivity monitor (`connectivity_plus`) with an automatic, graceful **No Internet** screen when offline.

### 🎨 6. Modern UI & Theming
- **Dynamic Light & Dark Themes:** Smooth theme toggle backed by `ThemeProvider` and custom `AppColors`.
- **Edge-to-Edge Design:** Adaptive system navigation and status bar styling.
- **Engaging Motion:** Staggered list animations, smooth hero transitions, and Lottie animations.

---

## 🏗️ Architecture & State Management

The application is structured following clean architecture principles using the **Provider** pattern:

```text
chiyagram/
├── chiyagaram/
│   ├── android/                        # Android native configurations & manifests
│   ├── ios/                            # iOS native configurations & runner
│   ├── images/                         # App icons, banners, and asset illustrations
│   ├── lib/
│   │   ├── animations/                 # Reusable animation widgets (e.g. FadeAnimation)
│   │   ├── bottom bar screens/         # Bottom navigation tabs (Home, Cart, Locations)
│   │   ├── core/                       # Core helpers and constants
│   │   ├── menu/                       # Menu categories (Traditional Chiya, Snacks, Hookah)
│   │   ├── models/                     # Data models (CartModel, etc.)
│   │   ├── profile/                    # Profile screens, settings & password management
│   │   ├── responsive/                 # Screen dimension and sizing utilities
│   │   ├── screens/                    # Main app views:
│   │   │   ├── auth/                   # Login, Signup, Forgot Password, Auth Wrapper
│   │   │   └── widget/                 # Hero carousel, popular & recommendation cards
│   │   ├── services/                   # Business logic and external API services:
│   │   │   ├── connectivity_provider.dart
│   │   │   ├── google_auth_service.dart
│   │   │   ├── navigation_provider.dart
│   │   │   ├── notification_provider.dart
│   │   │   ├── notification_service.dart
│   │   │   └── order_service.dart
│   │   ├── theme/                      # AppTheme, AppColors, and ThemeProvider
│   │   └── main.dart                   # Application entry point & MultiProvider setup
│   ├── pubspec.yaml                    # Flutter dependencies and assets
│   └── storage.rules                   # Firebase Storage security rules
├── .gitignore                          # Excludes secrets, credentials & build artifacts
└── README.md
```

### State Providers
- **`CartModel`**: Manages shopping cart state, line items, and running total.
- **`ThemeProvider`**: Manages light/dark mode preference and system brightness synchronization.
- **`ConnectivityProvider`**: Monitors network reachability (WiFi / Cellular / Disconnected).
- **`NotificationProvider`**: In-app notifications list and badge count.
- **`NavigationProvider`**: Bottom navigation tab state and routing.

---

## 🚀 Getting Started

### Prerequisites

Ensure you have installed:
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (v3.10.3 or higher)
- [Dart SDK](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/) with Flutter plugins
- A [Firebase](https://firebase.google.com/) account to configure backend services

### Installation & Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/anishchwdhree/Chiyagram.git
   cd Chiyagram/chiyagaram
   ```

2. **Install Flutter packages:**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase:**
   - Create a new project in the [Firebase Console](https://console.firebase.google.com/).
   - Add an **Android app** with package name `com.example.chiyagaram` (or your custom package name).
   - Download `google-services.json` and place it in:
     ```text
     chiyagaram/android/app/google-services.json
     ```
     *(A reference template is available at `chiyagaram/android/app/google-services.json.example`)*
   - Enable **Authentication** (Email/Password and Google Sign-In) in the Firebase console.
   - Enable **Cloud Firestore** and **Firebase Storage**.

4. **Run the application:**
   ```bash
   # Run on connected Android device or emulator
   flutter run

   # Or specify target platform
   flutter run -d chrome
   flutter run -d windows
   ```

5. **Build release APK / App Bundle:**
   ```bash
   flutter build apk --release
   # or
   flutter build appbundle --release
   ```

---

## 🔒 Security & Best Practices

- **Zero Secret Commits:** `google-services.json`, `GoogleService-Info.plist`, API keys, `.env` files, and local keystores (`*.jks`, `*.keystore`, `key.properties`) are strictly ignored via `.gitignore`.
- **Firebase Security Rules:** Firestore and Cloud Storage enforce authenticated read/write access policies.
- **Safe Environment Variables:** Example configuration templates are provided for team setup without leaking production secrets.

---

## 📦 Key Dependencies

| Package | Purpose |
|---|---|
| `firebase_core` & `firebase_auth` | Core Firebase initialization & user authentication |
| `cloud_firestore` & `firebase_storage` | Cloud database & media storage |
| `google_sign_in` | One-tap Google social login |
| `provider` | Reactive state management |
| `flutter_local_notifications` | Push and local scheduled alerts |
| `connectivity_plus` | Real-time network reachability detection |
| `carousel_slider` & `lottie` | Hero promotional banners & smooth vector animations |
| `google_fonts` & `iconsax` | Typography & icon packs |
| `shared_preferences` | Local key-value persistent storage |

---

## 👤 Author

Developed by **[Anish Chaudhary](https://github.com/anishchwdhree)**  
GitHub: [@anishchwdhree](https://github.com/anishchwdhree)

---

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).
