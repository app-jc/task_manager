import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_manager_coding_test/main.dart';
import '../../data/models/task.dart';

class TaskListItem extends StatefulWidget {
  const TaskListItem(
      {super.key, required this.task, required this.onStatusChanged});
  final Task task;
  final void Function() onStatusChanged;
  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  bool itemCheck = false;
  bool disableButton = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.task.status.toTaskStatus() == TaskStatus.completed ||
              disableButton == true
          ? null
          : () async {
              itemCheck = !itemCheck;
              disableButton = true;
              if (itemCheck == true) {
                widget.task.status = TaskStatus.completed.name;
              } else {
                widget.task.status = TaskStatus.incomplete.name;
              }
              await sqflite.updateTask(widget.task).then((value) {
                if (value == 1) {
                  widget.onStatusChanged;
                } else {
                  disableButton = false;
                }
              });

              setState(() {});
            },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 22),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 29, 28, 37),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.task.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: widget.task.status.toTaskStatus() ==
                                          TaskStatus.completed
                                      ? Colors.grey
                                      : Colors.white)),
                      Gap(3),
                      Text(widget.task.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Gap(22),
                Icon(
                  itemCheck == true ||
                          widget.task.status.toTaskStatus() ==
                              TaskStatus.completed
                      ? Icons.radio_button_checked_rounded
                      : Icons.radio_button_off_rounded,
                  size: 18,
                  color: itemCheck == true ? Colors.blue : Colors.grey,
                )
              ],
            ),
            Gap(5),
            Divider(
              thickness: .8,
            ),
            Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '${widget.task.date}\t',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: widget.task.dateColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(capitalizeFirstLetter(widget.task.priority),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: widget.task.status.toTaskStatus() ==
                                TaskStatus.completed
                            ? Colors.grey
                            : widget.task.priority.toTaskPriority().color,
                        fontWeight: FontWeight.bold))
              ],
            )
          ],
        ),
      ),
    );
  }

  String capitalizeFirstLetter(String word) {
    if (word.isEmpty) {
      return word; // Return empty string if input is empty
    }
    return word[0].toUpperCase() + word.substring(1);
  }
}
