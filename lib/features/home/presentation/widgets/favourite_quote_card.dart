import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FavouriteQuoteCard extends StatelessWidget {
  const FavouriteQuoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width / 1.5,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 29, 28, 37),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Forget yesterday - it has already forgotten you. Don't sweat tomorrow - you haven't even met. Instead, open your eyes and your heart to a truly precious gift - today.",
                    maxLines: 3,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Gap(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 18,
                        height: .5,
                        color: Colors.white,
                      ),
                      Gap(5),
                      Text(
                        'Steve Maraboli',
                        style: Theme.of(context).textTheme.bodySmall!,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
