import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/feature/todo/data/model/todo.dart';
import 'package:todo_app/feature/todo/domain/repositories/todo_repositories.dart';

class CompleteTodoUseCase implements UseCase<String, String> {
  final TodoRepositories todoRepositories;
  CompleteTodoUseCase(this.todoRepositories); 

  @override
  Future<String> call(String id) async{
    try {
      final response = await todoRepositories.completeTodo(id);
      return response;
    } catch (error) {
      throw error.toString();
    }
  }
}
