part of 'home_bloc.dart';

class HomeState {
  final DailyTips? quote;
  final DailyTips? tips;
  final List<DailyTips> favoriteQuotes;
  final bool isLoading;
  final String? error;

  HomeState({
    required this.quote,
    required this.tips,
    required this.favoriteQuotes,
    required this.isLoading,
    this.error,
  });

  factory HomeState.initial() => HomeState(
        quote: null,
        tips: null,
        favoriteQuotes: [],
        isLoading: false,
      );

  HomeState copyWith({
    DailyTips? quote,
    DailyTips? tips,
    List<DailyTips>? favoriteQuotes,
    bool? isLoading,
    String? error,
  }) {
    return HomeState(
      quote: quote ?? this.quote,
      tips: tips ?? this.tips,
      favoriteQuotes: favoriteQuotes ?? this.favoriteQuotes,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
