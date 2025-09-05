import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/feature/data/model/todo.dart';
import 'package:todo_app/feature/presentation/bloc/todo_bloc.dart';
import 'package:todo_app/feature/presentation/bloc/todo_events.dart';
import 'package:todo_app/feature/presentation/bloc/todo_states.dart';
import 'package:todo_app/feature/presentation/widgets/add_dialog.dart';
import 'package:todo_app/feature/presentation/widgets/todo_card.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/feature/presentation/widgets/update_todo.dart';

class AddTodoItems extends StatefulWidget {
  const AddTodoItems({super.key});

  @override
  State<AddTodoItems> createState() => _AddTodoItemsState();
}

class _AddTodoItemsState extends State<AddTodoItems> {
  @override
  void initState() {
    fetchTodos();
    super.initState();
  }

  void fetchTodos() async {
    final bloc = context.read<TodoBloc>();
    bloc.add(LoadTodos());
  }

  void markAsComplete(String id) {
    final bloc = context.read<TodoBloc>();
    bloc.add(CompleteTodo(id));
    fetchTodos();
  }

    void deleteTodo(String id) {
    final bloc = context.read<TodoBloc>();
    bloc.add(DeleteTodo(id));
    fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AddTodoDialog(todoId: ""),
              );
            },
            icon: const Icon(Icons.add),
          ),
          const SizedBox(width: 8),
        ],
        title: const Text('Todo Items'),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is TodoList) {
            // if (state.todos.isEmpty) {
            //   return const Center(child: Text('No todos yet'));
            // }
            final todos = state.todos;
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return TodoCard(
                  delete: () {
                    deleteTodo(todo.todoId);
                  },
                  markComplete: () {
                    markAsComplete(todo.todoId);
                  },
                  edit: () {
                    // WidgetsBinding.instance.addPostFrameCallback((_) {
                    showDialog(
                      context: context,
                      builder: (context) => UpdateTodoDialog(
                        todoId: todo.todoId,
                        title: todo.title,
                        description: todo.description,
                        isCompleted: todo.isCompleted,
                        
                      ),
                    );
                    // });
                  },
                  title: todo.title,
                  desc: todo.description,
                  createdAt: todo.createdAt != null
                      ? DateFormat(
                          'yyyy-MM-dd',
                        ).format(todo.createdAt!.toDate())
                      : 'No Creation Date',
                  isCompleted: todo.isCompleted,
                );
              },
            );
          }
          return const Center(child: Text('No todos yet'));
        },
      ),
    );
  }
}
