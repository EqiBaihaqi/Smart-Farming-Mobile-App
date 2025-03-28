import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential = await _firebaseAuth
            .signInWithCredential(credential);
        return userCredential.user;
      }
      return null;
    } catch (e) {
      throw Exception('Terjadi kesalahan saat sign in : ${e.toString()}');
    }
  }

  static Future<void> signout() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
