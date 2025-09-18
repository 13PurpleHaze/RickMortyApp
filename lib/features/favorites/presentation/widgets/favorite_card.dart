import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../widgets/widgets.dart';

class FavoriteCard extends StatelessWidget {
  final String name;
  final String image;
  final String status;
  final String gender;
  final String species;
  final Widget leading;

  const FavoriteCard({
    super.key,
    required this.name,
    required this.image,
    required this.status,
    required this.gender,
    required this.species,
    required this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Row(
        children: [
          Flexible(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    placeholder:
                        (context, url) => Shimmer.fromColors(
                          baseColor:
                              Theme.of(context).colorScheme.surfaceContainer,
                          highlightColor: Theme.of(context).primaryColor,
                          child: Container(color: Colors.white),
                        ),
                    errorWidget:
                        (context, url, error) => Container(
                          color: Theme.of(context).colorScheme.surfaceContainer,
                          child: Icon(
                            Icons.error_outline,
                            color: Theme.of(context).iconTheme.color,
                            size: 40,
                          ),
                        ),
                  ),
                ),
                Positioned(left: 0, top: 0, child: leading),
              ],
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.headlineSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  RowItem(title: 'Status', value: status),
                  RowItem(title: 'Gender', value: gender),
                  RowItem(title: 'Species', value: species),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
