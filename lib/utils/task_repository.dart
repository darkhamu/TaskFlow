import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:task_flow/models/task_model.dart';

class TaskRepository {
  final DatabaseReference _dbRef =
  FirebaseDatabase.instance.ref();

  final String _userId;

  TaskRepository() : _userId = FirebaseAuth.instance.currentUser!.uid;

  Stream<List<TaskModel>> getTasksStream() {
    return _dbRef.child('$_userId/tasks').onValue.map((event) {
      final tasksMap = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      return tasksMap.entries.map((entry) {
        return TaskModel.fromMap(
          entry.key as String,
          Map<String, dynamic>.from(entry.value as Map),
        );
      }).toList();
    });
  }

  Future<void> refreshTasks() async {
    try {
      final snapshot = await _dbRef.child('$_userId/tasks').get();

      if (!snapshot.exists) {
        throw Exception("No data available");
      }
    } catch (e) {
      throw Exception("Failed to refresh tasks: ${e.toString()}");
    }
  }

  Future<void> addTask(TaskModel task) async {
    await _dbRef.child('$_userId/tasks').push().set(task.toMap());
  }

  Future<void> updateTask(TaskModel task) async {
    await _dbRef.child('$_userId/tasks/${task.id}').update(task.toMap());
  }

  Future<void> deleteTask(String taskId) async {
    await _dbRef.child('$_userId/tasks/$taskId').remove();
  }
}