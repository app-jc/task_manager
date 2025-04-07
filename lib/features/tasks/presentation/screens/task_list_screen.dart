import 'package:flutter/material.dart';
import 'package:task_manager_coding_test/features/tasks/presentation/widgets/drag_drop_list_view.dart';

import '../../data/models/task.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key, required this.tasks, required this.title});
  final List<Task> tasks;
  final String title;

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: false,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 22.0),
              child: Icon(Icons.more_horiz_rounded),
            ),
          ],
        ),
        body: DragAndDropListView(
          tasks: widget.tasks,
          onStatusChanged: () {
            setState(() {});
          },
        ));
  }
}
