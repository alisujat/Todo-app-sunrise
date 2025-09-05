import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/feature/auth/domain/repositories/auth_repositories.dart';

class UserSignOut implements UseCase<String, void > {
  final AuthRepositories authRepositories;
  UserSignOut(this.authRepositories);
  @override
  Future<String> call(Null) async {
    return await authRepositories.signOut();
  }
}
