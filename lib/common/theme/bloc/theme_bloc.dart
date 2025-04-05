import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_coding_test/main.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(themeMode: ThemeMode.light)) {
    on<ThemeChanged>(_onThemeChanged);
    on<GetCurrentTheme>(_onGettingTheme);
  }

  Future<void> _onThemeChanged(
      ThemeChanged event, Emitter<ThemeState> emit) async {
    String themeMode = event.themeMode.name;
    emit(state.copyWith(themeMode: event.themeMode));
    await sqflite.updateThemeMode(themeMode);
  }

  Future<void> _onGettingTheme(
      GetCurrentTheme event, Emitter<ThemeState> emit) async {
    String? currentThemeMode = await sqflite.getCurrentThemeMode();
    if (currentThemeMode != null) {
      ThemeMode themeMode = ThemeMode.values.firstWhere(
        (e) => e.name == currentThemeMode,
        orElse: () => ThemeMode.light,
      );
      emit(
        state.copyWith(themeMode: themeMode),
      );
    }
  }
}
