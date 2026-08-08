import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../model/social_login_result.dart';

class GoogleAuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static bool _initialized = false;

  static Future<void> _ensureInitialized() async {
    if (_initialized) return;
    await _googleSignIn.initialize();
    // await _googleSignIn.initialize(
    //   serverClientId: '951814205337-13k5hcfo294qrkq2ktuvla63sin0j4ol.apps.googleusercontent.com'
    //   // serverClientId: 'YOUR_WEB_CLIENT_ID.apps.googleusercontent.com',
    // );
    _initialized = true;
  }

  static Future<SocialLoginResult> signInWithGoogle({required BuildContext context}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await _ensureInitialized();

      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // final GoogleSignInClientAuthorization? authorization =
      // await googleUser.authorizationClient.authorizationForScopes(['email']);

      if (googleAuth.idToken == null) {
        print('ERROR: Google ID token is null');
        return SocialLoginResult.empty;
      }

      final AuthCredential credential = GoogleAuthProvider.credential(
        //accessToken: authorization?.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      return SocialLoginResult(
        user: user,
        firstName: user?.displayName ?? '',
        lastName: '', // Google doesn't split first/last name by default
        email: user?.email ?? '',
        profilePic: user?.photoURL ?? '',
      );
    } on GoogleSignInException catch (e) {
      print("<><><><><><><><> catch GoogleSignInException : $e <><><><><><><><>");

      if (e.code != GoogleSignInExceptionCode.canceled) {
        debugPrint('GoogleSignInException: ${e.code.name} - ${e.description}');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Google sign-in failed. Try again.')),
          );
        }
      }
      return SocialLoginResult.empty;
    } on FirebaseAuthException catch (e) {
      print("<><><><><><><><> catch FirebaseAuthException : $e <><><><><><><><>");

      debugPrint('FirebaseAuthException: ${e.code}');
      return SocialLoginResult.empty;
    } catch (e) {
      print("<><><><><><><><> catch Works :$e <><><><><><><><>");

      debugPrint('Unexpected sign-in error: $e');
      return SocialLoginResult.empty;
    }
  }

  static Future<void> signOut({required BuildContext context}) async {
    try {
      await _ensureInitialized();
      await _googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error signing out. Try again.')),
        );
      }
    }
  }
}