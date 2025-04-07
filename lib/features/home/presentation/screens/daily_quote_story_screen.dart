import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_coding_test/features/home/models/daily_tips.dart';
import 'package:task_manager_coding_test/features/home/presentation/widgets/story_indicator_widget.dart';

import '../widgets/favourite_button_widget.dart';

enum DailyQuoteStory { motivation, productivity }

class DailyQuoteStoryScreen extends StatefulWidget {
  const DailyQuoteStoryScreen({
    super.key,
    required this.tips,
  });
  final List<DailyTips> tips;

  @override
  State<DailyQuoteStoryScreen> createState() => _DailyQuoteStoryScreenState();
}

class _DailyQuoteStoryScreenState extends State<DailyQuoteStoryScreen> {
  DailyQuoteStory currentStory = DailyQuoteStory.motivation;

  Widget _productivityTipStoryWidget() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        image: DecorationImage(
            image: CachedNetworkImageProvider(
              'https://images.unsplash.com/photo-1497321697169-1ca9f1c8a253?q=80&w=3024&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            ),
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
            fit: BoxFit.cover),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: SizedBox()),
            Text('Habit of the Day'),
            Gap(20),
            Text(
              widget.tips[1].text,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Expanded(flex: 2, child: SizedBox()),
            Padding(
                padding: const EdgeInsets.only(left: 22.0, bottom: 32),
                child: FavouriteButtonWidget(
                  tip: widget.tips[1],
                )),
          ],
        ),
      ),
    );
  }

  Widget _motivationQuoteStoryWidget() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18), topRight: Radius.circular(18)),
        image: DecorationImage(
            image: CachedNetworkImageProvider(
              'https://images.unsplash.com/photo-1741986947217-d1a0ecc39149?q=80&w=2932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            ),
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
            fit: BoxFit.cover),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: [
            //     Expanded(
            //       child: Container(
            //         height: 3,
            //         decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(20)),
            //       ),
            //     ),
            //     Gap(3),
            //     Expanded(
            //       child: Container(
            //         height: 3,
            //         decoration: BoxDecoration(
            //             color: Colors.grey,
            //             borderRadius: BorderRadius.circular(20)),
            //       ),
            //     ),
            //   ],
            // ),
            // Gap(22),
            // GestureDetector(
            //   onTap: () {
            //     context.pop();
            //   },
            //   child: Container(
            //     padding: EdgeInsets.only(top: 8),
            //     height: 44,
            //     width: 44,
            //     child: Align(
            //       alignment: Alignment.topLeft,
            //       child: Image.asset(
            //         'assets/icons/close.png',
            //         color: Colors.white,
            //         height: 12,
            //       ),
            //     ),
            //   ),
            // ),

            Expanded(child: SizedBox()),
            Text('Quote of the Day'),
            Gap(20),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    'https://ui-avatars.com/api/?name=${widget.tips[0].authorName}',
                  ),
                ),
                Gap(8),
                Text(
                  widget.tips[0].authorName,
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
              ],
            ),
            Gap(8),
            Text(
              widget.tips[0].text,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Expanded(flex: 2, child: SizedBox()),
            Padding(
                padding: const EdgeInsets.only(left: 22.0, bottom: 32),
                child: FavouriteButtonWidget(
                  tip: widget.tips[0],
                )),
          ],
        ),
      ),
    );
  }

  bool derterminate = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapUp: (details) {
          final screenWidth = MediaQuery.of(context).size.width;
          final dx = details.localPosition.dx;
          if (dx < screenWidth / 3) {
            if (currentStory != DailyQuoteStory.motivation) {
              currentStory = DailyQuoteStory.motivation;
              derterminate = false;
              setState(() {});
            }
          } else {
            currentStory = DailyQuoteStory.productivity;
            derterminate = true;
            setState(() {});
          }
        },
        onLongPressUp: () {
          if (currentStory == DailyQuoteStory.productivity) {
            derterminate = true;
          }
          setState(() {});
        },
        onLongPress: () {
          derterminate = false;
          setState(() {});
        },
        onVerticalDragEnd: (details) {
          context.pop();
        },
        child: Stack(
          children: [
            Padding(
                padding:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: currentStory == DailyQuoteStory.motivation
                    ? _motivationQuoteStoryWidget()
                    : _productivityTipStoryWidget()),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 12,
                  left: 12,
                  right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      Gap(3),
                      Expanded(
                        child: StoryIndicatorWidget(
                          determinate: derterminate,
                          dailyQuoteStory: currentStory,
                        ),
                      ),
                    ],
                  ),
                  Gap(22),
                  GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 8, left: 10),
                      height: 44,
                      width: 44,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Image.asset(
                          'assets/icons/close.png',
                          color: Colors.white,
                          height: 12,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
