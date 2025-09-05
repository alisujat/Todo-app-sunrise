import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract interface class AuthRemoteDatasource {
  Future<UserCredential> signInWithGoogle();
  Future<String> signOut();
}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  AuthRemoteDatasourceImpl(this.firebaseAuth);

  @override
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      throw Exception("Google sign-in aborted");
    }

    // Get the authentication
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a Firebase credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Sign in to Firebase
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<String> signOut() async {
    try {
      await firebaseAuth.signOut();
      return 'User Logout Successfully';
    } catch (e) {
      throw (e.toString());
    }
  }
}
