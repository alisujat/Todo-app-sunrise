import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/feature/todo/domain/usecases/add_todo.dart';
import 'package:todo_app/feature/todo/domain/usecases/complete_todo.dart';
import 'package:todo_app/feature/todo/domain/usecases/delete.dart';
import 'package:todo_app/feature/todo/domain/usecases/fetch_all.dart';
import 'package:todo_app/feature/todo/domain/usecases/fetch_by_id.dart';
import 'package:todo_app/feature/todo/domain/usecases/update.dart';
import 'todo_events.dart';
import 'todo_states.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final AddTodoUseCase _addTodoUseCase;
  final FetchAllTodoUseCase _fetchAllTodoUseCase;
  final FetchByIdUseCase _fetchByIdUseCase;
  final DeleteToUseCase _deleteToUseCase;
  final UpdateTodoUseCase _updateTodoUseCase;
  final CompleteTodoUseCase _completeTodo;
  TodoBloc({
    required AddTodoUseCase addTodoUseCase,
    required FetchAllTodoUseCase fetchAllTodoUseCase,
    required final FetchByIdUseCase fetchByIdUseCase,
    required final DeleteToUseCase deleteToUseCase,
    required final UpdateTodoUseCase updateTodoUseCase,
    required final CompleteTodoUseCase completeTodo,
  }) : _addTodoUseCase = addTodoUseCase,
       _fetchAllTodoUseCase = fetchAllTodoUseCase,
       _fetchByIdUseCase = fetchByIdUseCase,
       _deleteToUseCase = deleteToUseCase,
       _updateTodoUseCase = updateTodoUseCase,
       _completeTodo = completeTodo,
       super(TodoInitial()) {
    on<AddTodo>((event, emit) async {
      emit(TodoLoading());
      try {
        final res = await _addTodoUseCase(event.todo);
        return emit(TodoSuccess(res));
      } catch (error) {
        throw TodoError(error.toString());
      }
    });

    on<LoadTodos>((event, emit) async {
      emit(TodoLoading());
      try {
        final res = await _fetchAllTodoUseCase(null);
        return emit(TodoList(res));
      } catch (error) {
        throw error.toString();
      }
    });
    on<DeleteTodo>((event, emit) async {
      emit(TodoLoading());
      try {
        final res = await _deleteToUseCase(event.id);
        return emit(TodoSuccess(res));
      } catch (error) {
        throw error.toString();
      }
    });

    on<UpdateTodo>((event, emit) async {
      emit(TodoLoading());
      try {
        final res = await _updateTodoUseCase(event.todo);
        return emit(TodoSuccess(res));
      } catch (error) {
        throw error.toString();
      }
    });

    on<CompleteTodo>((event, emit) async {
      emit(TodoLoading());
      try {
        final res = await _completeTodo(event.todoId);
        return emit(TodoSuccess(res));
      } catch (error) {
        throw error.toString();
      }
    });

    on<GetTodo>((event, emit) async {
      emit(TodoLoading());
      try {
        final res = await _fetchByIdUseCase(event.id);
        return emit(TodoData(res));
      } catch (error) {
        throw error.toString();
      }
    });
  }
}
