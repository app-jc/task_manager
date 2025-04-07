import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_coding_test/features/home/presentation/bloc/home_bloc.dart';
import 'package:task_manager_coding_test/features/home/presentation/widgets/daily_quote_card_widget.dart';
import 'package:task_manager_coding_test/features/home/presentation/widgets/favourite_quote_card.dart';
import 'package:task_manager_coding_test/features/home/presentation/widgets/favourite_quote_detail_card.dart';
import 'package:task_manager_coding_test/features/home/presentation/widgets/my_tasks_overview_widget.dart';
import 'package:task_manager_coding_test/features/home/presentation/widgets/open_container_wrapper.dart';
import 'package:task_manager_coding_test/features/tasks/presentation/bloc/task_bloc.dart';
import '../../../../routing/screen_paths.dart';
import '../../../tasks/domain/utilities/task_list_argument.dart';
import 'daily_quote_story_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<TaskBloc>(context).add(FetchTasks());
    BlocProvider.of<HomeBloc>(context).add(LoadHomeContent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (!state.isLoading) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 22.0, vertical: 22),
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
                              onTap: openContainer,
                              child: DailyQuoteCardWidget(
                                tip: state.quote,
                              ));
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
                          GestureDetector(
                            onTap: () {
                              context.push(ScreenPaths.tasks);
                            },
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                            ),
                          ),
                          Gap(22),
                        ],
                      ),
                    ],
                  ),
                ),
                MyTasksOverviewWidget(),
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
        return SizedBox();
      },
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
