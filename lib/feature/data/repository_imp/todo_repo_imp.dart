import 'package:todo_app/feature/data/data_source/todo_datasource.dart';
import 'package:todo_app/feature/data/model/todo.dart';
import 'package:todo_app/feature/domain/repositories/todo_repositories.dart';

class TodoRepoImp implements TodoRepositories {
  final TodoDataSource todoDataSource;
  TodoRepoImp(this.todoDataSource);
  @override
  Future<String> addTodo(Todo todo) async {
    try {
      return todoDataSource.addTodo(todo);
    } catch (e) {
      throw Exception('Failed to add todo: $e');
    }
  }

  @override
  Future<String> deleteTodo(String id) {
    try {
      return todoDataSource.deleteTodo(id);
    } catch (e) {
      throw Exception('Failed to add todo: $e');
    }
  }

  @override
  Future<List<Todo>> fetchTodos() {
    try {
      return todoDataSource.fetchTodos();
    } catch (e) {
      throw Exception('Failed to fetch todos: $e');
    }
  }

  @override
  Future<String> updateTodo(Todo todo) {
        try {
      return todoDataSource.updateTodo(todo);
    } catch (e) {
      throw Exception('Failed to update todos: $e');
    }                                                                                                             
  }

    @override
  Future<String> completeTodo(String id) {
        try {
      return todoDataSource.completeTodo(id);
    } catch (e) {
      throw Exception('Failed to update todos: $e');
    }                                                                                                             
  }

    @override
  Future<Todo>fetchTodoById (String id) {
        try {
      return todoDataSource.fetchTodoById(id);
    } catch (e) {
      throw Exception('Failed to fetch todos by Id: $e');
    }
  }

}
