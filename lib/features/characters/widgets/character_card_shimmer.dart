import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CharacterCardShimmer extends StatelessWidget {
  const CharacterCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 200,
      child: Shimmer.fromColors(
        baseColor: Theme.of(
          context,
        ).colorScheme.onSurface.withValues(alpha: 0.1),
        highlightColor: Theme.of(context).primaryColor,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
      ),
    );
  }
}
