import 'package:flutter/material.dart';
import 'package:todo_app/feature/data/model/todo.dart';

@immutable
sealed class TodoState {}

// Different states for the Todo application
class TodoInitial extends TodoState {}

// State when todos are being loaded
class TodoLoading extends TodoState {}


// State when todos are successfully loaded
class TodoLoaded extends TodoState {
  final List<String> todos; // Assuming todos are represented as a list of strings

  TodoLoaded(this.todos);
}

// State when there is an error loading todos
class TodoError extends TodoState {
  final String message;
  TodoError(this.message);
}

// State when a new todo is created successfully
class TodoSuccess extends TodoState {
  final String todo;
  TodoSuccess(this.todo);
}

// State when a new todo is created successfully
class TodoList extends TodoState {
  final List<Todo> todos;
  TodoList(this.todos);
}

// State when a new todo is created successfully
class TodoData extends TodoState {
  final Todo todos;
  TodoData(this.todos);
}