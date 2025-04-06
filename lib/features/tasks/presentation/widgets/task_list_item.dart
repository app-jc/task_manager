import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../data/models/task.dart';

class TaskListItem extends StatefulWidget {
  const TaskListItem({super.key, required this.task});
  final Task task;
  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  bool itemCheck = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.task.status.toTaskStatus() == TaskStatus.completed
          ? null
          : () {
              itemCheck = !itemCheck;
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
                Text(widget.task.priority,
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
}

extension TaskPriorityColor on TaskPriority {
  Color get color {
    switch (this) {
      case TaskPriority.high:
        return Colors.red;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.low:
        return Colors.grey;
    }
  }
}

extension StringToTaskPriority on String {
  TaskPriority toTaskPriority() {
    switch (toLowerCase()) {
      case 'high':
        return TaskPriority.high;
      case 'medium':
        return TaskPriority.medium;
      case 'low':
        return TaskPriority.low;
      default:
        throw Exception('Invalid TaskPriority string: $this');
    }
  }
}

extension StringToTaskStatus on String {
  TaskStatus toTaskStatus() {
    switch (toLowerCase()) {
      case 'completed':
        return TaskStatus.completed;
      case 'incomplete':
        return TaskStatus.incomplete;
      default:
        throw Exception('Invalid TaskPriority string: $this');
    }
  }
}

extension TaskDateColorExtension on Task {
  DateTime? get parseTaskDate {
    try {
      if (date.startsWith('Today')) {
        final timePart = date.replaceFirst('Today ', '');
        final now = DateTime.now();
        final fullDate = '${DateFormat('dd MMMM, yyyy').format(now)} $timePart';
        return DateFormat('dd MMMM, yyyy hh:mm a').parseStrict(fullDate);
      } else {
        return DateFormat('dd MMMM, yyyy hh:mm a').parseStrict(date);
      }
    } catch (_) {
      return null;
    }
  }

  Color get dateColor {
    final taskDate = parseTaskDate;
    final now = DateTime.now();

    final isToday = taskDate != null &&
        taskDate.month == now.month &&
        taskDate.day == now.day;

    final statusEnum = status.toTaskStatus();

    final bool isCompleted = statusEnum == TaskStatus.completed;
    final bool isDue = statusEnum == TaskStatus.incomplete &&
        taskDate != null &&
        taskDate.isBefore(now);

    if (isCompleted) return Colors.grey;
    if (isDue) return Colors.red;
    if (isToday) return Colors.blue;
    return Colors.white;
  }
}
