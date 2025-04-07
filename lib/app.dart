import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_coding_test/common/theme/bloc/theme_bloc.dart';
import 'package:task_manager_coding_test/features/home/presentation/bloc/home_bloc.dart';
import 'package:task_manager_coding_test/features/tasks/data/repositories/task_repository.dart';
import 'package:task_manager_coding_test/features/tasks/presentation/bloc/task_bloc.dart';
import 'package:task_manager_coding_test/routing/app_router.dart';
import 'common/theme/app_theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    BlocProvider.of<ThemeBloc>(context).add(GetCurrentTheme());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TaskBloc>(
          create: (BuildContext context) => TaskBloc(TaskRepository()),
        ),
        BlocProvider<HomeBloc>(
          create: (BuildContext context) => HomeBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: appRouter,
          title: 'Task Manager',
          themeMode: state.themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
        );
      }),
    );
  }
}
