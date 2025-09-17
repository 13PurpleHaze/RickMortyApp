import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

const height = 300.0;
const iconSize = 40.0;

class CustomAppBar extends StatelessWidget {
  final String imageUrl;
  final String title;

  const CustomAppBar({super.key, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: height,
      stretch: true,
      centerTitle: true,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.passthrough,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder:
                  (context, url) => Shimmer.fromColors(
                    baseColor: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.1),
                    highlightColor: Theme.of(context).primaryColor,
                    child: Container(color: Colors.white),
                  ),
              errorWidget:
                  (context, url, error) => Container(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.1),
                    child: Icon(
                      Icons.error_outline,
                      color: Theme.of(context).iconTheme.color,
                      size: iconSize,
                    ),
                  ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Theme.of(context).colorScheme.surface,
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ],
        ),
        title: Text(title),
      ),
    );
  }
}
