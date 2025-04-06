import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 22.0),
        child: Column(
          children: [
            TextFormField(
              onTap: () {},
              cursorColor: Colors.white,
              enabled: false,
              cursorHeight: 16,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search_rounded),
                contentPadding: EdgeInsets.all(0),
                isDense: true,
                filled: true,
                fillColor: Color.fromARGB(255, 29, 28, 37),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Gap(45),
            _buildTaskMenuItem(
              title: 'Today',
              count: '10',
              iconPath: 'assets/icons/today.png',
              iconColor: Colors.blue,
              context: context,
            ),
            Gap(12),
            _buildTaskMenuItem(
              title: 'All',
              count: '18',
              iconPath: 'assets/icons/all.png',
              iconColor: Colors.white,
              context: context,
            ),
            Gap(12),
            _buildTaskMenuItem(
              title: 'Due',
              count: '10',
              iconPath: 'assets/icons/due.png',
              iconColor: Colors.red,
              context: context,
            ),
            Gap(12),
            _buildTaskMenuItem(
              title: 'Completed',
              count: '8',
              iconPath: 'assets/icons/completed.png',
              iconColor: Colors.green,
              context: context,
            ),
            Gap(12),
            _buildTaskMenuItem(
              title: 'Incomplete',
              count: '1',
              iconPath: 'assets/icons/incomplete.png',
              iconColor: Colors.grey,
              context: context,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskMenuItem(
      {required String title,
      required String count,
      required String iconPath,
      required Color iconColor,
      required BuildContext context}) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      tileColor: Color.fromARGB(255, 29, 28, 37),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            count,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Gap(8),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(),
          ),
        ],
      ),
      leading: Image.asset(
        iconPath,
        color: iconColor,
        height: 22,
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 18,
      ),
    );
  }
}
