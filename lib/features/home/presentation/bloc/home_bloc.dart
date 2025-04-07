import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:task_manager_coding_test/features/home/models/daily_tips.dart';
import 'package:task_manager_coding_test/main.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Dio _dio;

  HomeBloc()
      : _dio = _configureDio(),
        super(HomeState.initial()) {
    on<LoadHomeContent>(_onLoadHomeContent);
  }

  static Dio _configureDio() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        filter: (options, args) {
          // Don't print requests with uris containing '/posts'
          if (options.path.contains('/posts')) {
            return false;
          }
          // Don't print responses with uint8List data
          return !args.isResponse || !args.hasUint8ListData;
        }));
    return dio;
  }

  Future<void> _onLoadHomeContent(
      LoadHomeContent event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      // Fetch daily quote from API
      final dailyQuoteResponse =
          await _fetchQuote('https://zenquotes.io/api/today');
      final dailyQuote = DailyTips.fromJson(dailyQuoteResponse.data[0]);
      await sqflite.addQuote(dailyQuote);

      // Fetch random quote from API
      final randomQuoteResponse =
          await _fetchQuote('https://zenquotes.io/api/random');
      final randomQuote = DailyTips.fromJson(randomQuoteResponse.data[0]);
      await sqflite.addQuote(randomQuote);

      // Get all quotes from database
      final allQuotes = await sqflite.getAllQuotes();
      final favouriteQuotes = await sqflite.getFavouriteQuotes();

      emit(state.copyWith(
        quotes: allQuotes,
        favoriteQuotes: favouriteQuotes,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<Response> _fetchQuote(String url) async {
    try {
      return await _dio.get(url);
    } catch (e) {
      throw Exception('Failed to fetch quote: ${e.toString()}');
    }
  }
}
