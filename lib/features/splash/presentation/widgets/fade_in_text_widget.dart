import 'package:flutter/material.dart';

class FadeInTextWidget extends StatefulWidget {
  const FadeInTextWidget({super.key});

  @override
  State<FadeInTextWidget> createState() => _FadeInTextWidgetState();
}

class _FadeInTextWidgetState extends State<FadeInTextWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeInAnimation;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeInAnimation,
      child:
          Text('FocusFlow', style: Theme.of(context).textTheme.headlineLarge),
    );
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.ease),
    );

    Future.delayed(Duration(seconds: 3), () {
      animationController.forward();
    });
  }

  @override
  void didUpdateWidget(FadeInTextWidget value) {
    super.didUpdateWidget(value);
    animationController.duration = Duration(seconds: 3);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
