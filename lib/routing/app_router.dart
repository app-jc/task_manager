import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_coding_test/features/home/presentation/screens/daily_quote_story_screen.dart';
import 'package:task_manager_coding_test/features/home/presentation/screens/home_screen.dart';
import 'package:task_manager_coding_test/features/splash/presentation/splash_screen.dart';
import 'package:task_manager_coding_test/routing/screen_paths.dart';

import '../app_scaffold.dart';
import '../features/tasks/presentation/screens/tasks_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');
final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: ScreenPaths.splash,
  routes: [
    AppRoute(ScreenPaths.splash, (_) => SplashScreen(), useFade: true),
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, router, navigator) {
          return AppScaffold(child: navigator);
        },
        routes: [
          AppRoute(ScreenPaths.home, (_) => HomeScreen(), useFade: true),
          AppRoute(ScreenPaths.tasks, (_) => TasksScreen(), useFade: true),
        ]),
    AppRoute(ScreenPaths.quoteStory, (_) => DailyQuoteStoryScreen(),
        useFade: true),
  ],
);

class AppRoute extends GoRoute {
  AppRoute(String path, Widget Function(GoRouterState s) builder,
      {List<GoRoute> routes = const [],
      this.useFade = false,
      this.useScale = false})
      : super(
          path: path,
          routes: routes,
          pageBuilder: (context, state) {
            final pageContent = Scaffold(
              body: builder(state),
              resizeToAvoidBottomInset: false,
            );

            if (useFade) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: pageContent,
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              );
            }
            return CupertinoPage(child: pageContent);
          },
        );
  final bool useFade;
  final bool useScale;
}
