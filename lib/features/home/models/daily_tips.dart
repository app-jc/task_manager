import 'package:uuid/uuid.dart';

class DailyTips {
  int id;
  String text;
  String authorName;

  DailyTips({
    required this.id,
    required this.text,
    required this.authorName,
  });

  factory DailyTips.fromJson(Map<String, dynamic> json) {
    return DailyTips(
      id: json['id'] ?? Uuid().v4(),
      text: json['q'] ?? '',
      authorName: json['a'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'q': text,
      'a': authorName,
    };
  }
}
