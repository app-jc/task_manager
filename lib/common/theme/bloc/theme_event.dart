// ignore_for_file: public_member_api_docs

part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {
  const ThemeChanged({required this.themeMode});

  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];
}

class GetCurrentTheme extends ThemeEvent {
  const GetCurrentTheme();

  @override
  List<Object?> get props => [];
}
