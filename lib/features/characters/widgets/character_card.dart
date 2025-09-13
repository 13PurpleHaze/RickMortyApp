import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:rick_morty_app/models/character_status/character_status.dart';
import 'package:rick_morty_app/ui/widgets/widgets.dart';

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
              child: Stack(
                alignment: AlignmentGeometry.bottomLeft,
                children: [
                  CachedNetworkImage(
                    imageUrl: image,
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
                            size: 40,
                          ),
                        ),
                  ),
                  Positioned(
                    left: 8,
                    top: 8,
                    child: Tag(
                      title: status.name,
                      status: _convertCharacterStatusToTagStatus(status),
                    ),
                  ),
                  Container(
                    color: Colors.black45,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      name,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TagStatus _convertCharacterStatusToTagStatus(
    CharacterStatus characterStatus,
  ) {
    switch (status) {
      case CharacterStatus.alive:
        return TagStatus.success;
      case CharacterStatus.dead:
        return TagStatus.error;
      case CharacterStatus.unknown:
        return TagStatus.def;
    }
  }
}
