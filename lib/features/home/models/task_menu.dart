import 'package:flutter/material.dart';

class TaskMenu {
  String value;
  String label;
  Widget icon;
  TaskMenu({required this.value, required this.label, required this.icon});
}

List<TaskMenu> kTaskMenu = [
  TaskMenu(
    value: '10',
    label: 'Today',
    icon: Image.asset(
      'assets/icons/today.png',
      height: 22,
      color: Colors.blue,
    ),
  ),
  TaskMenu(
    value: '18',
    label: 'All',
    icon: Image.asset(
      'assets/icons/all.png',
      height: 22,
      color: Colors.white,
    ),
  ),
  TaskMenu(
    value: '0',
    label: 'Due',
    icon: Image.asset(
      'assets/icons/due.png',
      height: 22,
      color: Colors.red,
    ),
  ),
  TaskMenu(
    value: '8',
    label: 'Completed',
    icon: Image.asset(
      'assets/icons/completed.png',
      height: 22,
      color: Colors.green,
    ),
  ),
  // TaskMenu(
  //   value: '2',
  //   label: 'Incomplete',
  //   icon: Image.asset(
  //     'assets/icons/incomplete.png',
  //     height: 22,
  //     color: Colors.grey,
  //   ),
  // ),
];
