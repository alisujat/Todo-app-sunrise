import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/widets/loader.dart';
import 'package:todo_app/core/widets/reusable_text.dart';
import 'package:todo_app/feature/data/model/todo.dart';
import 'package:todo_app/feature/presentation/bloc/todo_bloc.dart';
import 'package:todo_app/feature/presentation/bloc/todo_events.dart';
import 'package:todo_app/feature/presentation/bloc/todo_states.dart';
import 'package:todo_app/feature/presentation/screens/todo.dart';
import 'package:uuid/uuid.dart';

class UpdateTodoDialog extends StatefulWidget {
  final String todoId;
  final String title;
  final String description;
  final bool isCompleted;
  const UpdateTodoDialog({
    super.key,
    required this.title,
    required this.description,
    required this.todoId,
    required this.isCompleted,
  });

  @override
  State<UpdateTodoDialog> createState() => _UpdateTodoDialogState();
}

class _UpdateTodoDialogState extends State<UpdateTodoDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  bool isComplete = false;

  @override
  void initState() {
    isComplete = widget.isCompleted;
    _titleController.text = widget.title;
    _descController.text = widget.description;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void addTodo() {
    if (_formKey.currentState!.validate()) {
      final bloc = context.read<TodoBloc>();
      final data = Todo(
        todoId: widget.todoId,
        title: _titleController.text,
        description: _descController.text,
        isCompleted: isComplete,
      );
      bloc.add(UpdateTodo(data));
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
          // Close dialog when success
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => AddTodoItems()));
          });
        }
        return AlertDialog(
          title: const Text("Edit Todo"),
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
                const SizedBox(height: 12),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isComplete = !isComplete;
                      });
                    },
                    child: Row(
                      children: [
                        ReusableText(
                          text: 'Mark as Completed',
                          fontSize: 14,
                          textColor: isComplete
                              ? Colors.green
                              : Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        isComplete
                            ? Icon(Icons.check_box, color: Colors.green)
                            : Icon(
                                Icons.check_box_outline_blank,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                      ],
                    ),
                  ),
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
