import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/feature/todo/data/model/todo.dart';
import 'package:todo_app/feature/todo/domain/repositories/todo_repositories.dart';

class UpdateTodoUseCase implements UseCase<String, Todo> {
  final TodoRepositories todoRepositories;
  UpdateTodoUseCase(this.todoRepositories); 

  @override
  Future<String> call(Todo todo) async{
    try {
      final response = await todoRepositories.updateTodo(todo);
      return response;
    } catch (error) {
      throw error.toString();
    }
  }
}
