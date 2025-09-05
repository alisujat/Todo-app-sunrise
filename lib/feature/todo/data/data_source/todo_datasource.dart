import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/feature/todo/data/model/todo.dart';

abstract interface class TodoDataSource {
  Future<String> addTodo(Todo todo);
  Future<String> updateTodo(Todo todo);
  Future<String> deleteTodo(String id);
  Future<List<Todo>> fetchTodos();
  Future<Todo> fetchTodoById(String id);
  Future<String> completeTodo(String id);
}

class TodoDatasourceImpl extends TodoDataSource {
  final FirebaseFirestore firebaseFirestore;
  TodoDatasourceImpl(this.firebaseFirestore);
  @override
  Future<String> addTodo(Todo todo) async {
    try {
      final docRef = firebaseFirestore
          .collection('todos')
          .doc(todo.todoId); // Firestore will generate a docRef with unique ID
      final todoData = Todo(
        todoId: todo.todoId,
        title: todo.title,
        description: todo.description,
        createdAt: todo.createdAt,
        isCompleted: todo.isCompleted,
      );

      await docRef.set(todoData.toMap());
      return 'Todo Successfully Added';
    } catch (error) {
      throw error.toString();
    }
  }

  @override
  Future<String> deleteTodo(String todoId) async {
    try {
      await firebaseFirestore.collection('todos').doc(todoId).delete();
      return 'Todo deleted successfully';
    } catch (error) {
      throw error.toString();
    }
  }

  @override
  Future<List<Todo>> fetchTodos() async {
    try {
      Query query = FirebaseFirestore.instance.collection('todos');

      query = query.orderBy('createdAt', descending: true);

      final querySnapshot = await query.get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Todo(
          todoId: data['todoId'],
          title: data['title'],
          description: data['description'],
          createdAt: data['createdAt'],
          isCompleted: data['isCompleted'],
        );
      }).toList();
    } catch (e) {
      throw 'Error fetching all Todos: $e';
    }
  }

  @override
  Future<Todo> fetchTodoById(String id) async {
    try {
      // final docSnapshot =
      //     await firebaseFirestore.collection('products').doc(productId).get();

      final docSnapshot = await FirebaseFirestore.instance
          .collection('todos')
          .where('todoId', isEqualTo: id)
          .get();

      if (docSnapshot.docs.isNotEmpty) {
        return Todo(
          todoId: docSnapshot.docs.first.data()['todoId'],
          description: docSnapshot.docs.first.data()['description'],
          createdAt: docSnapshot.docs.first.data()['createdAt'],
          title: docSnapshot.docs.first.data()['title'],
          isCompleted: docSnapshot.docs.first.data()['isCompleted'],
        );
      } else {
        throw 'No Todo found by this id';
      }
    } catch (e) {
      throw 'No Todo found by this id';
    }
  }

  @override
  Future<String> updateTodo(Todo todo) async {
    try {
      await firebaseFirestore
          .collection('todos')
          .doc(todo.todoId)
          .set(todo.toMap(), SetOptions(merge: true));
      return 'User Todo updated successfully';
    } catch (error) {
      throw error.toString();
    }
  }

  @override
  Future<String> completeTodo(String id) async {
    try {
      await firebaseFirestore.collection('todos').doc(id).set({
        "isCompleted": true, 
      }, SetOptions(merge: true));
      return 'User Todo updated successfully';
    } catch (error) {
      throw error.toString();
    }
  }
}
