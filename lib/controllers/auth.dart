import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payzero/controllers/database.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? get currerntuser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<String> signinWithgoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);

        try {
          UserCredential userCredential =
              await _firebaseAuth.signInWithCredential(credential);
          await Datamethod().initilizeuserData(userCredential.user!.uid);
        } catch (e) {
          return e
              .toString()
              .replaceAll(RegExp(r"\[(.*?)\] ", unicode: true), "");
        }
      }
    } catch (e) {
      return e.toString().replaceAll(RegExp(r"\[(.*?)\] ", unicode: true), "");
    }

    return 'success';
  }

  Future<String> signinWithEmail(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      return e.toString().replaceAll(RegExp(r"\[(.*?)\] ", unicode: true), "");
    }
    return 'success';
  }

  Future<String> createUserwith({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await user.user?.updateDisplayName(username);
      await user.user?.sendEmailVerification();
      await user.user?.updatePhotoURL(
          "https://firebasestorage.googleapis.com/v0/b/commutee-flutter-c2.appspot.com/o/woman-with-balloon-image-torn-paper-style_53876-128762.webp?alt=media&token=84acb782-6e9a-48cb-9964-839fde6fe8ef");
      await Datamethod().initilizeuserData(user.user!.uid);
    } catch (e) {
      return e.toString().replaceAll(RegExp(r"\[(.*?)\] ", unicode: true), "");
    }
    return 'success';
  }

  Future<void> signout() async {
    await _firebaseAuth.signOut();
  }
}
