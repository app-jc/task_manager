import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_coding_test/features/tasks/domain/utilities/task_list_argument.dart';
import 'package:task_manager_coding_test/routing/screen_paths.dart';

import '../../../tasks/data/models/task.dart';
import '../../../tasks/presentation/bloc/task_bloc.dart';
import 'task_menu_card_widget.dart';

class MyTasksOverviewWidget extends StatefulWidget {
  const MyTasksOverviewWidget({super.key});

  @override
  State<MyTasksOverviewWidget> createState() => _MyTasksOverviewWidgetState();
}

class _MyTasksOverviewWidgetState extends State<MyTasksOverviewWidget> {
  List<Task> todayTasks = [];
  List<Task> allTasks = [];
  List<Task> dueTasks = [];
  List<Task> completedTasks = [];

  DateTime? parseTaskDate(String dateStr) {
    try {
      if (dateStr.startsWith('Today')) {
        final timePart = dateStr.replaceFirst('Today ', '');
        final now = DateTime.now();
        final fullDate = '${DateFormat('dd MMMM, yyyy').format(now)} $timePart';
        return DateFormat('dd MMMM, yyyy hh:mm a').parseStrict(fullDate);
      } else {
        return DateFormat('dd MMMM, yyyy hh:mm a').parseStrict(dateStr);
      }
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 22.0),
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            if (state is TaskLoaded) {
              todayTasks = state.tasks.where((task) {
                final taskDate = parseTaskDate(task.date);
                return task.status.toTaskStatus() != TaskStatus.completed &&
                    task.date.contains('Today') &&
                    taskDate != null &&
                    taskDate.isAfter(DateTime.now());
              }).toList();
              allTasks = state.tasks.where((task) {
                return task.status.toLowerCase().toTaskStatus() !=
                    TaskStatus.completed;
              }).toList();
              dueTasks = state.tasks.where((task) {
                final taskDate = parseTaskDate(task.date);
                return task.status.toLowerCase() ==
                        TaskStatus.incomplete.name &&
                    taskDate != null &&
                    taskDate.isBefore(DateTime.now());
              }).toList();
              completedTasks = state.tasks
                  .where((task) =>
                      task.status.toLowerCase() == TaskStatus.completed.name)
                  .toList();
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        context.push(ScreenPaths.taskList,
                            extra: TaskListArgument(
                                tasks: todayTasks, title: 'Today'));
                      },
                      child: TaskMenuCardWidget(
                        value: todayTasks.length.toString(),
                        label: "Today",
                        icon: Image.asset(
                          'assets/icons/today.png',
                          color: Colors.blue,
                          height: 22,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        context.push(ScreenPaths.taskList,
                            extra: TaskListArgument(
                                tasks: allTasks, title: 'All'));
                      },
                      child: TaskMenuCardWidget(
                        value: allTasks.length.toString(),
                        label: "All",
                        icon: Image.asset(
                          'assets/icons/all.png',
                          color: Colors.white,
                          height: 22,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        context.push(ScreenPaths.taskList,
                            extra: TaskListArgument(
                                tasks: dueTasks, title: 'Due'));
                      },
                      child: TaskMenuCardWidget(
                        value: dueTasks.length.toString(),
                        label: "Due",
                        icon: Image.asset(
                          'assets/icons/due.png',
                          color: Colors.red,
                          height: 22,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: GestureDetector(
                      onTap: () {
                        context.push(ScreenPaths.taskList,
                            extra: TaskListArgument(
                                tasks: completedTasks, title: 'Completed'));
                      },
                      child: TaskMenuCardWidget(
                        value: completedTasks.length.toString(),
                        label: "Completed",
                        icon: Image.asset(
                          'assets/icons/completed.png',
                          color: Colors.green,
                          height: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
