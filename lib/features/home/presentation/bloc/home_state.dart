part of 'home_bloc.dart';

class HomeState {
  final List<DailyTips> quotes;
  final List<DailyTips> favoriteQuotes;
  final bool isLoading;
  final String? error;

  HomeState({
    required this.quotes,
    required this.favoriteQuotes,
    required this.isLoading,
    this.error,
  });

  factory HomeState.initial() => HomeState(
        favoriteQuotes: [],
        isLoading: false,
        quotes: [],
      );

  HomeState copyWith({
    List<DailyTips>? quotes,
    List<DailyTips>? favoriteQuotes,
    bool? isLoading,
    String? error,
  }) {
    return HomeState(
      quotes: quotes ?? this.quotes,
      favoriteQuotes: favoriteQuotes ?? this.favoriteQuotes,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
