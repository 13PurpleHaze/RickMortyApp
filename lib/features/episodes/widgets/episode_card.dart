import 'package:flutter/material.dart';

class EpisodeCard extends StatelessWidget {
  final String title;
  final String name;
  final String date;

  const EpisodeCard({
    super.key,
    required this.title,
    required this.name,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              Text(name, style: Theme.of(context).textTheme.bodyLarge),
              Text(date, style: Theme.of(context).textTheme.labelSmall),
            ],
          ),
        ],
      ),
    );
  }
}
