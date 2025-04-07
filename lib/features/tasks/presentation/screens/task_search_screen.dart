import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_coding_test/features/tasks/presentation/widgets/task_list_item.dart';

import '../../data/models/task.dart';

class TaskSearchScreen extends StatefulWidget {
  const TaskSearchScreen({super.key, required this.tasks});
  final List<Task> tasks;

  @override
  State<TaskSearchScreen> createState() => _TaskSearchScreenState();
}

class _TaskSearchScreenState extends State<TaskSearchScreen> {
  List<Task> filterTasks = [];

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 10, left: 22, right: 22),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: searchController,
                  onChanged: (value) {
                    if (searchController.text.isEmpty) {
                      filterTasks.clear();
                    } else {
                      filterTasks = widget.tasks.where((task) {
                        return task.title
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            task.description
                                .toLowerCase()
                                .contains(value.toLowerCase());
                      }).toList();
                    }

                    setState(() {});
                  },
                  cursorColor: Colors.white,
                  autofocus: true,
                  cursorHeight: 16,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search_rounded),
                    contentPadding: EdgeInsets.all(0),
                    isDense: true,
                    filled: true,
                    fillColor: Color.fromARGB(255, 29, 28, 37),
                    enabledBorder: OutlineInputBorder(
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
              Gap(12),
              GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Text('Cancel'))
            ],
          ),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: filterTasks.length,
              itemBuilder: (context, index) {
                return TaskListItem(
                  task: filterTasks[index],
                  onStatusChanged: () {
                    filterTasks.removeAt(index);
                    setState(() {});
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Gap(12);
              },
            ),
          )
        ],
      ),
    );
  }
}
