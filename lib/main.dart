import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:task_manager_coding_test/app.dart';
import 'package:task_manager_coding_test/services/local_storage/sqlite_service.dart';
import 'common/theme/bloc/theme_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  registerSingletons();

  runApp(
    BlocProvider(
      create: (_) => ThemeBloc(),
      child: App(),
    ),
  );
}

void registerSingletons() {
  GetIt.I.registerLazySingleton<SqfliteService>(() => SqfliteService());
}

SqfliteService get sqflite => GetIt.I.get<SqfliteService>();
