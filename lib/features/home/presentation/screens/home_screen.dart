import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_coding_test/features/home/presentation/widgets/daily_quote_widget.dart';
import 'package:task_manager_coding_test/features/home/presentation/widgets/open_container_wrapper.dart';
import 'package:task_manager_coding_test/features/splash/presentation/splash_screen.dart';
import 'package:task_manager_coding_test/routing/screen_paths.dart';

import 'daily_quote_story_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DAILY REFRESH',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.grey, letterSpacing: 1.5),
            ),
            Gap(22),
            GestureDetector(
                onTap: () {
                  context.push(ScreenPaths.quoteStory);
                },
                child: DailyQuoteCardWidget())
          ],
        ),
      ),
    );
  }
}
