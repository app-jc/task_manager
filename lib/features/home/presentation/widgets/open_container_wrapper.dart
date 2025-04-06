import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_coding_test/features/home/presentation/screens/daily_quote_story_screen.dart';

class OpenContainerWrapper extends StatelessWidget {
  const OpenContainerWrapper({
    super.key,
    required this.closedBuilder,
    required this.transitionType,
    required this.onClosed,
    this.useRootNavigator,
    required this.openBuilder,
  });

  final CloseContainerBuilder closedBuilder;
  final OpenContainerBuilder<bool> openBuilder;
  final ContainerTransitionType transitionType;
  final ClosedCallback<bool?> onClosed;
  final bool? useRootNavigator;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      transitionDuration: Duration(milliseconds: 800),
      clipBehavior: Clip.antiAlias,
      closedElevation: 0,
      openElevation: 0,
      
      closedColor: Colors.transparent,
      openColor: Colors.transparent,
      middleColor: Colors.transparent,
      transitionType: transitionType,
      useRootNavigator: useRootNavigator ?? true,
      openBuilder: openBuilder,
      onClosed: onClosed,
      tappable: false,
      closedBuilder: closedBuilder,
    );
  }
}
