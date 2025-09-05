import 'package:flutter/material.dart';
import 'package:todo_app/feature/data/model/todo.dart';

@immutable
sealed class TodoEvent {}

// Event to load todos
class LoadTodos extends TodoEvent {}

// Event to add a new todo
class AddTodo extends TodoEvent {
  final Todo todo;
  AddTodo(this.todo);
}

// Event to update an existing todo
class UpdateTodo extends TodoEvent {
  final Todo todo;
  UpdateTodo(this.todo);
}

// Event to update an existing todo
class GetTodo extends TodoEvent {
  final String id;
  GetTodo(this.id);
}

// Event to delete a todo
class DeleteTodo extends TodoEvent {
  final String id;
  DeleteTodo(this.id);
}

// Event to mark a todo as completed
class CompleteTodo extends TodoEvent {
  final String todoId;
  CompleteTodo(this.todoId);
}
