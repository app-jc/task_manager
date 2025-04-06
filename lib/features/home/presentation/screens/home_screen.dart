import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_manager_coding_test/features/home/presentation/widgets/daily_quote_card_widget.dart';
import 'package:task_manager_coding_test/features/home/presentation/widgets/favourite_quote_card.dart';
import 'package:task_manager_coding_test/features/home/presentation/widgets/favourite_quote_detail_card.dart';
import 'package:task_manager_coding_test/features/home/presentation/widgets/open_container_wrapper.dart';
import 'package:task_manager_coding_test/features/home/presentation/widgets/task_menu_card_widget.dart';

import '../../models/task_menu.dart';
import 'daily_quote_story_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
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
                OpenContainerWrapper(
                  closedBuilder: (context, openContainer) {
                    return GestureDetector(
                        onTap: openContainer, child: DailyQuoteCardWidget());
                  },
                  openBuilder: (context, closeContainer) {
                    return DailyQuoteStoryScreen();
                  },
                  transitionType: ContainerTransitionType.fadeThrough,
                  onClosed: (bool? data) {},
                ),
                Gap(22),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'My Tasks',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Gap(8),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.only(left: 22.0),
              child: Row(
                children: List.generate(
                  kTaskMenu.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: TaskMenuCardWidget(
                      value: kTaskMenu[index].value,
                      label: kTaskMenu[index].label,
                      icon: kTaskMenu[index].icon,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22.0),
            child: Column(
              children: [
                Gap(22),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Favourite Quotes',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                Gap(22),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        _openDialog(context);
                      },
                      child: FavouriteQuoteCard(
                        quote:
                            "Hope is important because it can make the present moment less difficult to bear. If we believe that tomorrow will be better, we can bear a hardship today.",
                      )),
                  Gap(12),
                  FavouriteQuoteCard(
                    quote:
                        "Yesterday is history, tomorrow is a mystery, today is God's gift, that's why we call it the present",
                  ),
                  // Gap(12),
                  // FavouriteQuoteCard(),
                ],
              ),
            ),
          ),
          Gap(22)
        ],
      ),
    );
  }

  void _openDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "FadeScaleDialog",
      barrierDismissible: true,
      barrierColor: Colors.black54,
      transitionDuration: Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(child: FavouriteQuoteDetailCard()),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(
          animation: animation,
          child: child,
        );
      },
    );
  }
}
