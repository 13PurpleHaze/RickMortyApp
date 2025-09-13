import 'package:flutter/material.dart';

enum TagStatus { def, success, error }

class Tag extends StatelessWidget {
  final String title;
  final TagStatus status;

  const Tag({super.key, required this.title, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: _getColor(context, status),
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Text(title, style: TextStyle(color: Colors.white)),
    );
  }

  Color _getColor(BuildContext context, TagStatus status) {
    switch (status) {
      case TagStatus.def:
        return Theme.of(context).colorScheme.secondary;
      case TagStatus.success:
        return Theme.of(context).colorScheme.primary;
      case TagStatus.error:
        return Theme.of(context).colorScheme.error;
    }
  }
}
