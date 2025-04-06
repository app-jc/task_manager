import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Task {
  int? id;
  String title;
  String description;
  String priority;
  String status;
  String date;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.date,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      priority: json['priority'] ?? '',
      status: json['status'] ?? '',
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'priority': priority,
      'status': status,
      'date': date,
    };
  }
}

enum TaskStatus { completed, incomplete }

enum TaskPriority { high, medium, low }

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
