  import 'package:flutter/material.dart';

  class TaskCheckWidget extends StatefulWidget {
    const TaskCheckWidget({super.key});

    @override
    State<TaskCheckWidget> createState() => _TaskCheckWidgetState();
  }

  class _TaskCheckWidgetState extends State<TaskCheckWidget> {
    bool isChecked = false;

    @override
    Widget build(BuildContext context) {
      return Icon(
        Icons.radio_button_off_rounded,
        size: 18,
      );
    }
  }
