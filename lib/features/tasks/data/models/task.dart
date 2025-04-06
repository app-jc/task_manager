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
