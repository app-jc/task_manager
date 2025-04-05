import 'package:flutter/material.dart';

ColorScheme lightColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: Colors.deepPurple,
    primary: Colors.deepPurple,
    tertiary: Colors.deepPurple);

ColorScheme darkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: Colors.deepPurple,
    primary: Colors.deepPurple,
    tertiary: Colors.deepPurple);

ThemeData get lightTheme {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    colorScheme: lightColorScheme,
    fontFamily: 'SF Pro',
    textTheme: TextTheme().copyWith(
      titleMedium: TextStyle(fontSize: 18.0),
      bodyMedium: TextStyle(fontWeight: FontWeight.bold, letterSpacing: .5),
    ),
  );
}

ThemeData get darkTheme {
  return ThemeData(
    scaffoldBackgroundColor: Color(0xFF15131D),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    fontFamily: 'SF Pro',
    colorScheme: darkColorScheme,
    textTheme: TextTheme().copyWith(
      titleMedium: TextStyle(fontSize: 18.0),
      bodyMedium: TextStyle(fontWeight: FontWeight.bold, letterSpacing: .5),
    ),
    brightness: Brightness.dark,
  );
}
