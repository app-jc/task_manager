import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'routing/screen_paths.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle(context)),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Icon(Icons.light_mode),
          )
        ],
      ),
      body: child,
      bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            unselectedFontSize: 14.0,
            type: BottomNavigationBarType.fixed,
            currentIndex: _calculateSelectedIndex(context),
            onTap: (int idx) => idx == 1 ? null : _onItemTapped(idx, context),
            items: [
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Image.asset(
                      'assets/icons/home.png',
                      color: GoRouterState.of(context)
                              .uri
                              .path
                              .startsWith(ScreenPaths.home)
                          ? Colors.white
                          : Colors.grey,
                      height: 25,
                    ),
                  ),
                  label: 'Home'),
              BottomNavigationBarItem(icon: SizedBox(), label: ''),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Image.asset(
                      'assets/icons/tasks.png',
                      height: 25,
                      color: GoRouterState.of(context)
                              .uri
                              .path
                              .startsWith(ScreenPaths.tasks)
                          ? Colors.white
                          : Colors.grey,
                    ),
                  ),
                  label: 'Tasks'),
            ],
          ),
          Positioned(
            top: 5,
            left: MediaQuery.of(context).size.width / 2 -
                ((kBottomNavigationBarHeight) / 2),
            child: Container(
              height: kBottomNavigationBarHeight,
              width: kBottomNavigationBarHeight,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.primary),
              child: Center(
                child: Image.asset(
                  'assets/icons/plus.png',
                  color: Colors.white,
                  height: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith(ScreenPaths.home)) {
      return 0;
    }
    if (location.startsWith(ScreenPaths.tasks)) {
      return 2;
    }

    return 0;
  }

  String _appBarTitle(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith(ScreenPaths.home)) {
      return 'Home';
    }
    if (location.startsWith(ScreenPaths.tasks)) {
      return 'Tasks';
    }

    return 'Home';
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go(ScreenPaths.home);
      case 2:
        GoRouter.of(context).go(ScreenPaths.tasks);
    }
  }
}
