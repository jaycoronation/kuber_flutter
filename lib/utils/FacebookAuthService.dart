import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../model/social_login_result.dart';

class FacebookAuthService {
  static Future<SocialLoginResult> signInWithFacebook({required BuildContext context}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['public_profile', 'email'],
      );

      if (result.status == LoginStatus.success) {
        final AccessToken token = result.accessToken!;

        final OAuthCredential credential = token is LimitedToken
            ? OAuthProvider('facebook.com').credential(idToken: token.tokenString)
            : FacebookAuthProvider.credential(token.tokenString);

        final UserCredential userCredential = await auth.signInWithCredential(credential);
        final User? user = userCredential.user;

        final Map<String, dynamic> profile =
        token is! LimitedToken ? await FacebookAuth.instance.getUserData() : {};

        final String fullName = user?.displayName ?? profile['name'] ?? '';
        final List<String> nameParts = fullName.trim().split(' ');
        final String firstName = nameParts.isNotEmpty ? nameParts.first : '';
        final String lastName = nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '';

        return SocialLoginResult(
          user: user,
          firstName: firstName,
          lastName: lastName,
          email: user?.email ?? profile['email'] ?? '',
          profilePic: user?.photoURL ?? profile['picture']?['data']?['url'] ?? '',
        );
      } else if (result.status == LoginStatus.cancelled) {
        return SocialLoginResult.empty;
      } else {
        debugPrint('Facebook login failed: ${result.status} - ${result.message}');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Facebook sign-in failed. Try again.')),
          );
        }
        return SocialLoginResult.empty;
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException: ${e.code}');
      return SocialLoginResult.empty;
    } catch (e) {
      debugPrint('Unexpected Facebook sign-in error: $e');
      return SocialLoginResult.empty;
    }
  }

  static Future<void> signOut({required BuildContext context}) async {
    try {
      await FacebookAuth.instance.logOut();
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