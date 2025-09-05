abstract interface class AuthRepositories {
  Future<String> signInWithGoogle();
  Future<String> signOut();
}