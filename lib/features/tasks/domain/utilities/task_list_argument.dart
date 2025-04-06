import 'package:task_manager_coding_test/features/tasks/data/models/task.dart';

class TaskListArgument {
  List<Task> tasks;
  String title;
  TaskListArgument({required this.tasks, required this.title});
}
