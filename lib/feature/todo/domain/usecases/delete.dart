import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/feature/todo/data/model/todo.dart';
import 'package:todo_app/feature/todo/domain/repositories/todo_repositories.dart';

class DeleteToUseCase implements UseCase<String, String> {
  final TodoRepositories todoRepositories;
  DeleteToUseCase(this.todoRepositories); 

  @override
  Future<String> call(String id) async{
    try {
      final response = await todoRepositories.deleteTodo(id);
      return response;
    } catch (error) {
      throw error.toString();
    }
  }
}
