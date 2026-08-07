// social_login_result.dart
import 'package:firebase_auth/firebase_auth.dart';

class SocialLoginResult {
  final User? user;
  final String firstName;
  final String lastName;
  final String email;
  final String profilePic;

  const SocialLoginResult({
    required this.user,
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.profilePic = '',
  });

  /// Convenience for a failed/cancelled login (nothing to send to the API).
  static const SocialLoginResult empty = SocialLoginResult(user: null);

  bool get isSuccess => user != null;
}