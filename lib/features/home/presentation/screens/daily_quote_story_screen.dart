import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class DailyQuoteStoryScreen extends StatelessWidget {
  const DailyQuoteStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18), topRight: Radius.circular(18)),
            image: DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1741986947217-d1a0ecc39149?q=80&w=2932&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                ),
                colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Icon(
                    Icons.close_rounded,
                    size: 18,
                  ),
                ),
                Expanded(child: SizedBox()),
                Text('Quote of the Day'),
                Gap(20),
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
                Gap(8),
                Text(
                  "Forget yesterday - it has already forgotten you. Don't sweat tomorrow - you haven't even met. Instead, open your eyes and your heart to a truly precious gift - today.",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Expanded(child: SizedBox()),
                Padding(
                  padding: const EdgeInsets.only(left: 22.0, bottom: 22),
                  child: Icon(
                    Icons.favorite_rounded,
                    size: 22,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
