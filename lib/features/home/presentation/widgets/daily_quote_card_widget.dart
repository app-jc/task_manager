import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_manager_coding_test/features/home/models/daily_tips.dart';

class DailyQuoteCardWidget extends StatelessWidget {
  const DailyQuoteCardWidget({super.key, required this.tip});
  final DailyTips? tip;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 275,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          image: DecorationImage(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1741986947217-d1a0ecc39149?q=80&w=2932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              ),
              colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
              fit: BoxFit.cover)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Quote of the Day'),
                Image.asset(
                  'assets/icons/expand.png',
                  height: 18,
                  color: Colors.white,
                )
              ],
            ),
            Gap(20),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    'https://ui-avatars.com/api/?name=${tip!.authorName}',
                  ),
                ),
                Gap(8),
                Text(
                  tip!.authorName,
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
              ],
            ),
            Gap(8),
            Text(
              tip!.text,
              maxLines: 3,
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}
