import 'package:flutter/material.dart';

class CharacteristicsList extends StatelessWidget {
  final int itemCount;
  final Map<String, String> characteristics;

  const CharacteristicsList({
    super.key,
    required this.itemCount,
    required this.characteristics,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: itemCount,
      separatorBuilder: (context, index) {
        if (index == 0) {
          return SizedBox();
        }
        return Divider();
      },
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Characteristics:',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          );
        }
        final entry = characteristics.entries.elementAt(index - 1);
        return Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(entry.key, style: Theme.of(context).textTheme.titleMedium),
              Text(entry.value, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        );
      },
    );
  }
}
