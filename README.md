# 🍵 Chiyagram — Self-Ordering System Mobile Application

[![Flutter](https://img.shields.io/badge/Flutter-v3.10%2B-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Auth%20%7C%20Firestore%20%7C%20Storage-FFCA28?logo=firebase&logoColor=black)](https://firebase.google.com/)
[![State Management](https://img.shields.io/badge/State-Provider-blue)](https://pub.dev/packages/provider)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-success)](https://flutter.dev)

> **Chiyagram** is a digital **Self-Ordering System Mobile Application** designed for modern cafes, artisanal tea houses, and hospitality lounges. Built with Flutter and backed by Firebase, Chiyagram streamlines table-side customer ordering: customers can browse categorized menus, customize their orders (traditional teas, snacks, hookah flavors), manage a real-time reactive cart, and complete orders directly from their devices—eliminating long wait times and paper order errors.

---

## 🌟 Self-Ordering System Highlights

- 📱 **Contactless Self-Service Ordering:** Customers browse interactive menus and place orders right from their table or on-the-go.
- ⚡ **Streamlined Cafe Operations:** Cuts down waiter dependency, speeds up order-to-kitchen turnaround, and prevents order mix-ups.
- 🛒 **Reactive Smart Cart (`CartModel`):** Dynamic item count, price calculations, and subtotal summary updated instantaneously.
- ☕ **Artisanal Tea & Specialty Lounge Menus:** Dedicated categories for Traditional Matka Chiya, Herbal Teas, Fresh Cafe Snacks, and Hookah blends.
- 🔔 **Instant Order & Promotion Notifications:** Local system notifications and an in-app alert center powered by `flutter_local_notifications`.
- 📍 **Multi-Branch Cafe Locator:** Find nearby cafe branches, operating hours, addresses, and contact info.
- 🌐 **Offline Resilience:** Continuous connectivity tracking (`connectivity_plus`) with an automatic, graceful "No Internet" status screen.
- 🎨 **Adaptive Themes:** Light & Dark mode support with smooth transitions, staggered list animations, and Lottie vector effects.

---

## ✨ Full Feature Overview

### ☕ 1. Curated Digital Menus & Categories
- **Traditional Chiya & Beverages:** Matka Chiya, Masala Chiya, Herbal Teas, Green Tea, and cold brews with detailed flavor descriptions.
- **Snacks & Dining:** Cafe favorites, momos, bakery items, and dining combos.
- **Hookah Lounge Catalog:** Flavor varieties, charcoal options, and lounge specials.
- **Hero Carousel & Discovery:** Featured promotional banners, popular picks, and recommendations.

### 📍 2. Multi-Branch Cafe Finder
- Multi-location directory showing branch addresses, open/close status, phone numbers, and navigation directions.

### 🛒 3. Cart & Checkout Engine
- Real-time cart state management with live item increments/decrements.
- Order review screen displaying breakdown, delivery/dine-in choices, and checkout submission.

### 🔐 4. Authentication & User Profile
- **Firebase Authentication:**
  - Secure Email & Password sign-up and sign-in.
  - Interactive **Password Strength Meter** evaluating length, casing, numbers, and symbols.
  - Instant password reset via email link.
  - One-tap **Google Sign-In** integration.
- **Account & Profile Center:**
  - Edit profile information with profile photo upload to Firebase Storage.
  - "My Orders" transaction history and past receipt records.
  - Feedback submission, terms of service, and privacy policy views.
  - Change password workflow and full account deletion.

### 🔔 5. Notifications & Network Handling
- Local push-style notifications for order confirmation and offers.
- Seamless network loss recovery using `ConnectivityProvider`.

### 🎨 6. UI/UX & Theming
- Native dark mode and light mode toggle backed by `ThemeProvider`.
- Edge-to-edge transparent system bars and responsive screen sizing.

---

## 🏗️ Architecture & State Management

The application is built using the **Provider** pattern for predictable, reactive state:

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

### Core Providers
- **`CartModel`**: Reactive shopping cart state, total sum, and quantity controls.
- **`ThemeProvider`**: Manages light/dark mode preference and system brightness sync.
- **`ConnectivityProvider`**: Monitors network reachability (WiFi / Mobile / Offline).
- **`NotificationProvider`**: In-app notifications list and unread badge count.
- **`NavigationProvider`**: Bottom navigation tab state and routing.

---

## 🚀 Getting Started

### Prerequisites

Ensure you have installed:
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (v3.10.3 or higher)
- [Dart SDK](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/) with Flutter plugins
- A [Firebase](https://firebase.google.com/) project configured for Android / iOS

### Installation & Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/anishchwdhree/Chiyagram-Self-Ordering-Cafe-Mobile-Application.git
   cd Chiyagram-Self-Ordering-Cafe-Mobile-Application/chiyagaram
   ```

2. **Install Flutter packages:**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase:**
   - Create a project in the [Firebase Console](https://console.firebase.google.com/).
   - Add an Android app with package name `com.example.chiyagaram`.
   - Download `google-services.json` and place it in:
     ```text
     chiyagaram/android/app/google-services.json
     ```
     *(A reference template is available at `chiyagaram/android/app/google-services.json.example`)*
   - Enable **Authentication** (Email/Password & Google Sign-In), **Firestore**, and **Storage**.

4. **Run the application:**
   ```bash
   # Run on connected device or emulator
   flutter run

   # Or target desktop/web
   flutter run -d chrome
   flutter run -d windows
   ```

5. **Build release executable / APK:**
   ```bash
   flutter build apk --release
   ```

---

## 🔒 Security & Privacy

- **Zero Secret Commits:** `google-services.json`, `GoogleService-Info.plist`, API keys, `.env` files, and local keystores (`*.jks`, `*.keystore`, `key.properties`) are strictly ignored via `.gitignore`.
- **Firebase Security Rules:** Firestore and Cloud Storage enforce authenticated read/write access policies.
- **Safe Environment Variables:** Configuration templates are provided for team setup without leaking production secrets.

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
