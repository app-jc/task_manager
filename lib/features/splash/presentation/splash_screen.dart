import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_coding_test/features/splash/presentation/widgets/fade_in_text_widget.dart';
import 'package:task_manager_coding_test/routing/screen_paths.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Image.asset(
            'assets/gifts/task.gif',
            height: 125,
          ),
        ),
        Gap(MediaQuery.of(context).size.height * 0.03),
        FadeInTextWidget()
      ],
    ));
  }

  @override
  void initState() {
    timer = Timer(Duration(milliseconds: 6000), () {
      context.go(ScreenPaths.home);
    });
    super.initState();
  }
}
