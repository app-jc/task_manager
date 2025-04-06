import 'package:flutter/material.dart';
import 'package:task_manager_coding_test/features/tasks/presentation/widgets/task_list_item.dart';

import '../../data/models/task.dart';

class DragAndDropListView extends StatefulWidget {
  const DragAndDropListView({super.key, required this.tasks});
  final List<Task> tasks;
  @override
  State<DragAndDropListView> createState() => _DragAndDropListViewState();
}

class _DragAndDropListViewState extends State<DragAndDropListView> {
  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      padding: EdgeInsets.symmetric(
          horizontal: 22, vertical: MediaQuery.of(context).padding.bottom),
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
        });
      },
      children: List.generate(
          widget.tasks.length,
          (index) => Padding(
                key: Key(index.toString()),
                padding: const EdgeInsets.only(bottom: 12.0),
                child: TaskListItem(
                  task: widget.tasks[index],
                ),
              )),
    );
  }
}
