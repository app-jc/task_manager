import 'package:flutter/material.dart';
import 'package:task_manager_coding_test/features/home/presentation/screens/daily_quote_story_screen.dart';

class StoryIndicatorWidget extends StatefulWidget {
  const StoryIndicatorWidget(
      {super.key, required this.determinate, required this.dailyQuoteStory});
  final bool determinate;
  final DailyQuoteStory dailyQuoteStory;
  @override
  State<StoryIndicatorWidget> createState() => _StoryIndicatorWidgetState();
}

class _StoryIndicatorWidgetState extends State<StoryIndicatorWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    if (widget.determinate) {
      controller.forward();
    }

    super.initState();
  }

  @override
  void didUpdateWidget(StoryIndicatorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.determinate != oldWidget.determinate) {
      if (widget.determinate) {
        controller.forward(from: controller.value);
      } else {
        if (widget.dailyQuoteStory != oldWidget.dailyQuoteStory) {
          controller.reset();
        } else {
          controller.stop();
        }
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      borderRadius: BorderRadius.circular(20),
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      backgroundColor: Colors.grey,
      value: controller.value,
    );
  }
}
