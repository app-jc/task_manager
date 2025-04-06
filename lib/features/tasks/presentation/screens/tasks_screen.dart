import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:task_manager_coding_test/features/tasks/data/models/task.dart';
import 'package:task_manager_coding_test/features/tasks/domain/utilities/task_list_argument.dart';
import 'package:task_manager_coding_test/features/tasks/presentation/bloc/task_bloc.dart';
import 'package:task_manager_coding_test/features/tasks/presentation/widgets/task_list_item.dart';
import 'package:task_manager_coding_test/routing/screen_paths.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
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
  void initState() {
    BlocProvider.of<TaskBloc>(context).add(FetchTasks());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskBloc, TaskState>(
      listener: (context, state) {},
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
            return task.status.toLowerCase() == TaskStatus.incomplete.name &&
                taskDate != null &&
                taskDate.isBefore(DateTime.now());
          }).toList();
          completedTasks = state.tasks
              .where((task) =>
                  task.status.toLowerCase() == TaskStatus.completed.name)
              .toList();
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 22.0, vertical: 22.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.push(ScreenPaths.taskSearch, extra: allTasks);
                    },
                    child: TextFormField(
                      cursorColor: Colors.white,
                      enabled: false,
                      cursorHeight: 16,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search_rounded),
                        contentPadding: EdgeInsets.all(0),
                        isDense: true,
                        filled: true,
                        fillColor: Color.fromARGB(255, 29, 28, 37),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Gap(45),
                  _buildTaskMenuItem(
                    title: 'Today',
                    count: todayTasks.length.toString(),
                    iconPath: 'assets/icons/today.png',
                    iconColor: Colors.blue,
                    context: context,
                    tasks: todayTasks,
                  ),
                  Gap(12),
                  _buildTaskMenuItem(
                    title: 'All',
                    count: allTasks.length.toString(),
                    iconPath: 'assets/icons/all.png',
                    iconColor: Colors.white,
                    context: context,
                    tasks: allTasks,
                  ),
                  Gap(12),
                  _buildTaskMenuItem(
                    title: 'Due',
                    count: dueTasks.length.toString(),
                    iconPath: 'assets/icons/due.png',
                    iconColor: Colors.red,
                    context: context,
                    tasks: dueTasks,
                  ),
                  Gap(12),
                  _buildTaskMenuItem(
                    title: 'Completed',
                    count: completedTasks.length.toString(),
                    iconPath: 'assets/icons/completed.png',
                    iconColor: Colors.green,
                    context: context,
                    tasks: completedTasks,
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
            child: SizedBox(),
          );
        }
      },
    );
  }

  Widget _buildTaskMenuItem(
      {required String title,
      required String count,
      required String iconPath,
      required Color iconColor,
      required List<Task> tasks,
      required BuildContext context}) {
    return ListTile(
      onTap: () {
        context.push(ScreenPaths.taskList,
            extra: TaskListArgument(tasks: tasks, title: title));
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      tileColor: Color.fromARGB(255, 29, 28, 37),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            count,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Gap(8),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(),
          ),
        ],
      ),
      leading: Image.asset(
        iconPath,
        color: iconColor,
        height: 22,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 18,
      ),
    );
  }
}
