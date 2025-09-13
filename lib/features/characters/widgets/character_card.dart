import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty_app/models/character_status/character_status.dart';
import 'package:shimmer/shimmer.dart';

class CharacterCard extends StatelessWidget {
  final String name;
  final String image;
  final CharacterStatus status;
  final void Function() onTap;

  const CharacterCard({
    super.key,
    required this.name,
    required this.image,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                placeholder:
                    (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Theme.of(context).primaryColor,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.white,
                      ),
                    ),
                errorWidget:
                    (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.error_outline,
                        color: Colors.grey,
                        size: 40,
                      ),
                    ),
              ),
            ),
          ),

          Text(name, maxLines: 1, style: TextStyle(fontFamily: 'Roboto')),
          Text(
            status.name,
            maxLines: 1,
            style: TextStyle(
              color: switch (status) {
                CharacterStatus.alive => Colors.green,
                CharacterStatus.dead => Colors.red,
                CharacterStatus.unknown => Colors.grey,
              },
            ),
          ),
        ],
      ),
    );
  }
}
