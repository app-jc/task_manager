import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_manager_coding_test/features/home/presentation/widgets/daily_quote_card_widget.dart';
import 'package:task_manager_coding_test/features/home/presentation/widgets/open_container_wrapper.dart';

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
            OpenContainerWrapper(
              closedBuilder: (context, openContainer) {
                return GestureDetector(
                    onTap: openContainer, child: DailyQuoteCardWidget());
              },
              transitionType: ContainerTransitionType.fadeThrough,
              onClosed: (bool? data) {},
            )
          ],
        ),
      ),
    );
  }
}
