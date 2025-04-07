import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_coding_test/features/home/models/daily_tips.dart';

import '../../../../main.dart';
import '../bloc/home_bloc.dart';

class FavouriteButtonWidget extends StatefulWidget {
  const FavouriteButtonWidget({super.key, required this.tip});
  final DailyTips tip;

  @override
  State<FavouriteButtonWidget> createState() => _FavouriteButtonWidgetState();
}

class _FavouriteButtonWidgetState extends State<FavouriteButtonWidget> {
  // Keep track of favorite status to avoid UI flicker
  int isFavourite = 0;
  bool isLoading = false;

  @override
  void initState() {
    isFavourite = widget.tip.isFavourite ?? 0;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FavouriteButtonWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tip != oldWidget.tip) {
      isFavourite = widget.tip.isFavourite ?? 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        key: Key(widget.tip.id.toString()),
        onTap: () async {
          setState(() {
            if (isFavourite == 1) {
              isFavourite = 0;
            } else {
              isFavourite = 1;
            }
          });
          widget.tip.isFavourite = isFavourite;
          await sqflite.updateQuoteFavouriteStatus(widget.tip);
          BlocProvider.of<HomeBloc>(context).add(LoadHomeContent());
        },
        child: Icon(
          isFavourite == 1
              ? Icons.favorite_rounded
              : Icons.favorite_border_rounded,
          size: 22,
          color: Colors.redAccent,
        ));
  }
}
