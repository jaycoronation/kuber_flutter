import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../model/social_login_result.dart';

class AppleAuthService {
  static String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  static String _sha256ofString(String input) {
    return sha256.convert(utf8.encode(input)).toString();
  }

  static Future<SocialLoginResult> signInWithApple({required BuildContext context}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      final String rawNonce = _generateNonce();
      final String hashedNonce = _sha256ofString(rawNonce);

      final AuthorizationCredentialAppleID appleCredential =
      await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: hashedNonce,
      );

      final OAuthCredential credential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: rawNonce,
        accessToken: appleCredential.authorizationCode,
      );

      final UserCredential userCredential = await auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      // Apple only sends name fields on the very first login — fall back
      // to whatever Firebase already has stored for returning users.
      final String firstName = appleCredential.givenName ?? '';
      final String lastName = appleCredential.familyName ?? '';
      final String email = user?.email ?? appleCredential.email ?? '';

      return SocialLoginResult(
        user: user,
        firstName: firstName,
        lastName: lastName,
        email: email,
        profilePic: '', // Apple never provides a profile picture
      );
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code != AuthorizationErrorCode.canceled) {
        debugPrint('Apple sign-in error: ${e.code} - ${e.message}');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Apple sign-in failed. Try again.')),
          );
        }
      }
      return SocialLoginResult.empty;
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.code}');
      return SocialLoginResult.empty;
    } catch (e) {
      debugPrint('Unexpected Apple sign-in error: $e');
      return SocialLoginResult.empty;
    }
  }

  static Future<void> signOut({required BuildContext context}) async {
    try {
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