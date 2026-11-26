import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Using .instance as it appears to be the expectation in this environment
      await GoogleSignIn.instance.initialize();

      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate();

      // Obtain the auth details
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // Create a new credential
      // idToken is the primary requirement for Firebase social auth
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      rethrow;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    await Future.wait([_auth.signOut(), GoogleSignIn.instance.signOut()]);
  }
}
