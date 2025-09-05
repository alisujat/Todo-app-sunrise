import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/feature/data/model/todo.dart';
import 'package:todo_app/feature/domain/repositories/todo_repositories.dart';

class FetchAllTodoUseCase implements UseCase<List<Todo>, Null> {
  final TodoRepositories todoRepositories;
  FetchAllTodoUseCase(this.todoRepositories); 

  @override
  Future<List<Todo>> call(Null) async{
    try {
      final response = await todoRepositories.fetchTodos();
      return response;
    } catch (error) {
      throw error.toString();
    }
  }
}
