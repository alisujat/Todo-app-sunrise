import 'package:todo_app/core/usecases/usecase.dart';
import 'package:todo_app/feature/data/model/todo.dart';
import 'package:todo_app/feature/domain/repositories/todo_repositories.dart';

class FetchByIdUseCase implements UseCase<Todo, String> {
  final TodoRepositories todoRepositories;
  FetchByIdUseCase(this.todoRepositories); 

  @override
  Future<Todo> call(String id) async{
    try {
      final response = await todoRepositories.fetchTodoById(id);
      return response;
    } catch (error) {
      throw error.toString();
    }
  }
}
