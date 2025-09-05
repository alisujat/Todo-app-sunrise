import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/feature/auth/domain/repositories/auth_repositories.dart';

class UserSignInWithGoogle implements UseCase<String, void > {
  final AuthRepositories authRepositories;
  UserSignInWithGoogle(this.authRepositories);
  @override
  Future<String> call(Null) async {
    await authRepositories.signInWithGoogle();
    return 'User signed in with Google';
  }
}
