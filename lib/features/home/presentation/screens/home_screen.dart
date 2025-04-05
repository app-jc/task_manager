import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_manager_coding_test/features/home/presentation/widgets/daily_quote_card_widget.dart';
import 'package:task_manager_coding_test/features/home/presentation/widgets/open_container_wrapper.dart';
import 'package:task_manager_coding_test/features/home/presentation/widgets/task_menu_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> taskMenu = [
    {
      'label': 'Today',
      'value': '10',
      'icon': Icon(
        Icons.today,
        color: Colors.blue,
      ),
    },
    {
      'label': 'All',
      'value': '10',
      'icon': Icon(
        Icons.list_alt,
        color: Colors.deepPurple,
      ),
    },
    {
      'label': 'Due',
      'value': '10',
      'icon': Icon(
        Icons.calendar_month,
        color: Colors.red,
      ),
    },
    {
      'label': 'Completed',
      'value': '2',
      'icon': Icon(
        Icons.check_circle_rounded,
        color: Colors.green,
      ),
    },
    {
      'label': 'Incomplete',
      'value': '8',
      'icon': Icon(
        Icons.list,
        color: Colors.grey,
      ),
    },
  ];

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
                  taskMenu.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: TaskMenuCardWidget(
                      value: taskMenu[index]['value'],
                      label: taskMenu[index]['label'],
                      icon: taskMenu[index]['icon'],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
