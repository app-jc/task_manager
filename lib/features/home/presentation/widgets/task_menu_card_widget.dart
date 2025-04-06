import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TaskMenuCardWidget extends StatelessWidget {
  const TaskMenuCardWidget(
      {super.key,
      required this.value,
      required this.label,
      required this.icon});

  final String value;
  final String label;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      height: 85,
      width: 150,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 29, 28, 37),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                label,
              ),
            ],
          ),
          Gap(12),
          icon
        ],
      ),
    );
  }
}
