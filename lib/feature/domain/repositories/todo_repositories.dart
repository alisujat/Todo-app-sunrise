import 'package:todo_app/feature/data/model/todo.dart';

abstract interface class TodoRepositories {
  Future<String> addTodo(Todo todo);
  Future<String> updateTodo(Todo todo);
  Future<String> deleteTodo(String id);
  Future<List<Todo>> fetchTodos();
  Future<Todo> fetchTodoById(String id);
  Future<String> completeTodo(String id);
}