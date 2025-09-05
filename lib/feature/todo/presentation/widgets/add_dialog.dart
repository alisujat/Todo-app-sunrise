import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/widets/loader.dart';
import 'package:todo_app/feature/todo/data/model/todo.dart';
import 'package:todo_app/feature/todo/presentation/bloc/todo_bloc.dart';
import 'package:todo_app/feature/todo/presentation/bloc/todo_events.dart';
import 'package:todo_app/feature/todo/presentation/bloc/todo_states.dart';
import 'package:todo_app/feature/todo/presentation/screens/todo.dart';
import 'package:uuid/uuid.dart';

class AddTodoDialog extends StatefulWidget {
  final bool? isEdit;
  final String todoId;
  const AddTodoDialog({super.key, this.isEdit = false, required this.todoId});

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void addTodo() {
    if (_formKey.currentState!.validate()) {
      final uuid = const Uuid().v4();
      final bloc = context.read<TodoBloc>();
      final data = Todo(
        todoId: uuid,
        title: _titleController.text,
        description: _descController.text,
        createdAt: Timestamp.now(),
        isCompleted: false,
      );
      bloc.add(AddTodo(data));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoLoading) {
          return const Center(child: Loader());
        }
        if (state is TodoError) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(state.message),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Close"),
              ),
            ],
          );
        }

        if (state is TodoSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // Close dialog when success
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => AddTodoItems()));
          });
        }
        return AlertDialog(
          title: widget.isEdit == true
              ? const Text("Edit Todo")
              : const Text("Add Todo"),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter a title";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _descController,
                  decoration: const InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter a description";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            ElevatedButton(onPressed: addTodo, child: const Text("Save")),
          ],
        );
      },
    );
  }
}
