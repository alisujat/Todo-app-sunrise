import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/feature/auth/data/data_source/auth_remote_datasource.dart';
import 'package:todo_app/feature/auth/domain/repositories/auth_repositories.dart';

class AuthRepoImpl implements AuthRepositories {
  final AuthRemoteDatasource remoteDatasource;
  AuthRepoImpl(this.remoteDatasource);

  
  @override
  Future<String> signInWithGoogle() async{
      try {
      final userData = await remoteDatasource.signInWithGoogle();
      return userData.user?.uid ?? '';
    }on FirebaseAuthException catch (e) {
      throw e.message.toString();
    }
  }

  @override
  Future<String> signOut() async{
      try {
      await remoteDatasource.signOut();
      return "user successfully logged out";
    }on FirebaseAuthException catch (e) {
      throw e.message.toString();
    }
  }
}
