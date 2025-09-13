import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_app/features/character_detail/bloc/character_detail_bloc.dart';
import 'package:rick_morty_app/ui/widgets/widgets.dart';
import 'package:shimmer/shimmer.dart';

@RoutePage()
class CharacterDetailScreen extends StatefulWidget {
  final int id;

  const CharacterDetailScreen({super.key, required this.id});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  @override
  void initState() {
    BlocProvider.of<CharacterDetailBloc>(
      context,
    ).add(LoadCharacterDetail(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          BlocBuilder<CharacterDetailBloc, CharacterDetailState>(
            builder: (context, state) {
              return switch (state) {
                CharacterDetailLoading _ => SliverFillRemaining(
                  child: PlatformBackgroundLoader(),
                ),
                CharacterDetailLoaded state => SliverAppBar(
                  expandedHeight: 300,
                  stretch: true,
                  centerTitle: true,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.passthrough,
                      children: [
                        CachedNetworkImage(
                          imageUrl: state.character.image,
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
                    title: Text(state.character.name),
                  ),
                ),
                CharacterDetailFailure _ => TextBanner(
                  title: "Error",
                  description: '',
                ),
                CharacterDetailState _ => SliverFillRemaining(),
              };
            },
          ),

          BlocBuilder<CharacterDetailBloc, CharacterDetailState>(
            builder: (context, state) {
              if (state is CharacterDetailLoaded) {
                return SliverList.separated(
                  itemCount: state.character.characteristics.length + 1,
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
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    final entry = state.character.characteristics.entries
                        .elementAt(index - 1);
                    return Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            entry.key,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            entry.value,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              return SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
          BlocBuilder<CharacterDetailBloc, CharacterDetailState>(
            builder: (context, state) {
              if (state is CharacterDetailLoaded) {
                return SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsGeometry.all(16),
                        child: Text(
                          'Episodes:',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 150,
                        child: CarouselView(
                          itemExtent: 250,
                          itemSnapping: true,
                          children:
                              state.episodes.map((episode) {
                                return Container(
                                  color: Colors.black26,
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        episode.episode,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        episode.name,
                                        overflow: TextOverflow.ellipsis,
                                      ),
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
              return SliverToBoxAdapter(child: SizedBox.shrink());
            },
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom,
            ),
          ),
        ],
      ),
    );
  }
}
