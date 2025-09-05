import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/feature/data/model/todo.dart';
import 'package:todo_app/feature/domain/repositories/todo_repositories.dart';

class AddTodoUseCase implements UseCase<String, Todo> {
  final TodoRepositories todoRepoImp;
  AddTodoUseCase(this.todoRepoImp); 

  @override
  Future<String> call(Todo todo) async{
    try {
      final response = await todoRepoImp.addTodo(todo);
      return response;
    } catch (error) {
      throw error.toString();
    }
  }
}
