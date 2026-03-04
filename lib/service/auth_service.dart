import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<User?> signInWithGoogle() async {
    await _googleSignIn.initialize(
      serverClientId:
          "126337099696-bp5ofsu1egp7aqmbo9t7u3p5eo15fgi0.apps.googleusercontent.com",
    );
    // clear previous session
    await _googleSignIn.signOut();
    final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
    final googleAuth = googleUser.authentication;

    //convert google token to firebase credentails
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    final userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  String? verificationId;

  // Send OTP
  Future<void> sendOtp(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,

      //Firebase automatically detect the otp from sms
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Verification Failed: ${e.message}");
      },
      codeSent: (String verId, int? resendToken) {
        verificationId = verId;
        print("OTP Sent");
      },
      //auto detects fails then firebase give the verification id
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
      },
    );
  }

  // Verify OTP
  Future<UserCredential?> verifyOtp(String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: otp,
    );
    
    return await _auth.signInWithCredential(credential);
  }
}
