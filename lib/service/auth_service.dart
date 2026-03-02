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

    // 🔥 Important: clear previous session
    await _googleSignIn.signOut();

    final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

    final googleAuth = googleUser.authentication;

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
}
