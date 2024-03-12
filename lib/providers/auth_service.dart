import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';

class AuthService {
  static String verificationId = '';
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future sentOtp({
    required String phoneNumber,
    required Function errorStep,
    required Function nextStep,
  }) async {
    await auth
        .verifyPhoneNumber(
      phoneNumber: '+91$phoneNumber',
      timeout: const Duration(seconds: 30),
      verificationCompleted: (phoneAuthCredential) async {},
      verificationFailed: (error) async {},
      codeSent: (verificationId, forceResendingToken) async {
        // Use the static variable from the class instead of a local variable
        AuthService.verificationId = verificationId;
        nextStep();
      },
      codeAutoRetrievalTimeout: (verificationId) async {},
    )
        .onError((error, stackTrace) {
      errorStep();
    });
  }

  static Future loginWithOtp({required String otp}) async {
    final cred = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);

    try {
      final user = await auth.signInWithCredential(cred);
      if (user.user != null) {
        return 'Success';
      } else {
        return 'Error';
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }

  static Future logout() async {
    await auth.signOut();
  }

  static Future<bool> isLoggedIn() async {
    var user = auth.currentUser;
    return user != null;
  }
}
