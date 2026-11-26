import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chiyagaram/screens/auth/login_screen.dart';
import 'package:chiyagaram/screens/onboarding_screen.dart';
import 'package:chiyagaram/screens/second_homescreen.dart';
import 'package:chiyagaram/screens/widget/background_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chiyagaram/responsive/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _seenOnboarding = false;
  Timer? _timeoutTimer;
  bool _isCreatingProfile = false;
  bool _isLoadingPrefs = true;
  bool _isAuthLoading = true;
  User? _user;
  StreamSubscription<User?>? _authSubscription;

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (mounted) {
        setState(() {
          _user = user;
          _isAuthLoading = false;
        });
      }
    });
  }

  Future<void> _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final seen = prefs.getBool('seenOnboarding') ?? false;
    if (mounted) {
      setState(() {
        _seenOnboarding = seen;
        _isLoadingPrefs = false;
      });
    }
  }

  void _onOnboardingComplete() {
    setState(() {
      _seenOnboarding = true;
    });
  }

  Future<void> _createMissingProfile(User user) async {
    if (_isCreatingProfile) return;
    setState(() => _isCreatingProfile = true);

    try {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'role': 'user',
        'email': user.email,
        'displayName': user.displayName,
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint("Error creating profile: $e");
    } finally {
      if (mounted) setState(() => _isCreatingProfile = false);
    }
  }

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    _authSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    SizeConfig().init(context);

    // 1. Show Splash if loading
    if (_isLoadingPrefs || _isAuthLoading) {
      return const BackgroundScaffold(body: SizedBox.shrink());
    }

    // 2. Not logged in -> Show Login/Onboarding
    if (_user == null) {
      _timeoutTimer?.cancel();
      if (!_seenOnboarding) {
        return OnboardingScreen(onComplete: _onOnboardingComplete);
      }
      return const LoginScreen();
    }

    // 3. User logged in -> Check Firestore Profile
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(_user!.uid)
          .snapshots(),
      builder: (context, roleSnapshot) {
        if (roleSnapshot.hasError) {
          return BackgroundScaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Database Error: ${roleSnapshot.error}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    child: const Text("Sign Out"),
                  ),
                ],
              ),
            ),
          );
        }

        if (roleSnapshot.hasData) {
          final doc = roleSnapshot.data!;
          if (doc.exists) {
            _timeoutTimer?.cancel();
            final data = doc.data() as Map<String, dynamic>?;
            if (data?['role'] == 'user') {
              return const SecondHomescreen();
            }
            // Add other roles handling if needed
          } else {
            // Profile missing
            if (!_isCreatingProfile) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                // Double check mounted
                if (mounted) {
                  _createMissingProfile(_user!);
                }
              });
            }
          }
        }

        // Waiting for Firestore or Profile Creation
        return const BackgroundScaffold(body: SizedBox.shrink());
      },
    );
  }
}
