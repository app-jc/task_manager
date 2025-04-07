class DailyTips {
  int? id;
  String text;
  String authorName;
  int? isFavourite;

  DailyTips({
    this.id,
    required this.text,
    required this.authorName,
    this.isFavourite = 0,
  });

  factory DailyTips.fromJson(Map<String, dynamic> json) {
    return DailyTips(
        id: json['id'] ?? -1,
        text: json['q'] ?? '',
        authorName: json['a'] ?? '',
        isFavourite: json['isFavourite'] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {'q': text, 'a': authorName, 'isFavourite': isFavourite};
  }
}
