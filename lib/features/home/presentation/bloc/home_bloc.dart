import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:task_manager_coding_test/features/home/models/daily_tips.dart';
import 'package:task_manager_coding_test/main.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<LoadHomeContent>(_onLoadHomeContent);
  }

  Future<void> _onLoadHomeContent(
      LoadHomeContent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      Dio dio = Dio();
      final response = await dio.get('https://zenquotes.io/api/today');
      DailyTips quote = DailyTips.fromJson(response.data);
      final response2 = await dio.get('https://zenquotes.io/api/random');
      DailyTips tip = DailyTips.fromJson(response2.data);
      List<DailyTips> favouriteQuotes = await sqflite.getFavouriteQuotes();
      emit(state.copyWith(
        quote: quote,
        tips: tip,
        favoriteQuotes: favouriteQuotes,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
