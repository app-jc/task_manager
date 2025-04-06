import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class FavouriteQuoteDetailCard extends StatelessWidget {
  const FavouriteQuoteDetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: Color.fromARGB(255, 29, 28, 37),
      child: Container(
        padding: EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Image.asset(
                    'assets/icons/close.png',
                    color: Colors.white,
                    height: 12,
                  ),
                ),
                Icon(
                  Icons.favorite_rounded,
                  size: 22,
                  color: Colors.redAccent,
                ),
              ],
            ),
            Gap(22),
            Text(
              '''"Forget yesterday - it has already forgotten you. Don't sweat tomorrow - you haven't even met. Instead, open your eyes and your heart to a truly precious gift - today."''',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Gap(12),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://zenquotes.io/img/steve-maraboli.jpg'),
                ),
                Gap(8),
                Text(
                  'Steve Maraboli',
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
              ],
            ),
            Gap(20),
          ],
        ),
      ),
    );
  }
}
