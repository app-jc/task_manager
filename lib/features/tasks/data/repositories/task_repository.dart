import '../../../../main.dart';
import '../models/task.dart';

class TaskRepository {
  Future<List<Task>> fetchTasks() async {
    return await sqflite.getAllTasks();
  }

  Future<String?> addTask(Task task) async {
    int result = await sqflite.createTask(task);
    return result != -1 ? null : 'Failed to add task';
  }

  Future<String?> updateTask(Task task) async {
    int result = await sqflite.updateTask(task);
    return result != -1 ? null : 'Failed to update task';
  }

  Future<String?> deleteTask(int id) async {
    int result = await sqflite.deleteTask(id);
    return result != -1 ? null : 'Failed to delete task';
  }
}
