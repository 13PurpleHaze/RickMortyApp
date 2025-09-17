import 'package:flutter/material.dart';

import 'package:rick_morty_app/features/episodes/episodes.dart';

class EpisodesList extends StatelessWidget {
  final List<Episode> episodes;

  const EpisodesList({super.key, required this.episodes});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(16),
            child: Text(
              'Episodes:',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 150,
            child: CarouselView(
              itemExtent: 250,
              itemSnapping: true,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children:
                  episodes.map((episode) {
                    return Container(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            episode.episode,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(episode.name, overflow: TextOverflow.ellipsis),
                          Text(
                            episode.airDate,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
