import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String todoId;
  final String title;
  final String description;
  final bool isCompleted;
  final Timestamp? createdAt;

  Todo({
    required this.todoId,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.createdAt,
  });

  // Convert object -> Map
  Map<String, dynamic> toMap() {
    return {
      'todoId': todoId,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': createdAt,
    };
  }

  // Convert Map -> object
  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      todoId: map['todoId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      createdAt: map['description'] ?? null,
    );
  }
}
