class FavouriteQuotesAndTips {
  String quoteText;
  String authorName;
  String htmlQuote;
  String type;

  FavouriteQuotesAndTips({
    required this.quoteText,
    required this.authorName,
    required this.htmlQuote,
    required this.type,
  });

  factory FavouriteQuotesAndTips.fromJson(Map<String, dynamic> json) {
    return FavouriteQuotesAndTips(
      quoteText: json['quoteText'],
      authorName: json['authorName'],
      htmlQuote: json['htmlQuote'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quoteText': quoteText,
      'authorName': authorName,
      'htmlQuote': htmlQuote,
      'type': type,
    };
  }
}
