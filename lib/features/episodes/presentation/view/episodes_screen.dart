import 'dart:async';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_morty_app/core/ui/ui.dart';

import 'package:rick_morty_app/features/characters/characters.dart';
import 'package:rick_morty_app/features/episodes/presentation/bloc/episodes_bloc.dart';
import 'package:rick_morty_app/features/episodes/presentation/widgets/episode_card_shimmer.dart';
import 'package:rick_morty_app/features/episodes/presentation/widgets/widgets.dart';

@RoutePage()
class EpisodesScreen extends StatefulWidget {
  const EpisodesScreen({super.key});

  @override
  State<EpisodesScreen> createState() => _EpisodesScreenState();
}

class _EpisodesScreenState extends State<EpisodesScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    BlocProvider.of<EpisodesBloc>(context).add(LoadEpisodes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator.adaptive(
        edgeOffset: MediaQuery.of(context).padding.top,
        onRefresh: _onRefresh,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            PlatformAppBar(title: 'Episodes'),
            BlocBuilder<EpisodesBloc, EpisodesState>(
              builder: (context, state) {
                return switch (state) {
                  EpisodesLoading _ => SliverFillRemaining(
                    child: PlatformBackgroundLoader(),
                  ),
                  EpisodesLoaded state => SliverList.separated(
                    itemCount:
                        state.episodes.length + (state.canLoadMore ? 2 : 0),
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemBuilder: (context, index) {
                      if (index >= state.episodes.length) {
                        return EpisodeCardShimmer();
                      }
                      final episode = state.episodes[index];
                      return PlatformListTile(
                        title: Text(episode.episode),
                        subtitle: Text(episode.name),
                        additionalInfo: Text(episode.airDate),
                      );
                    },
                  ),
                  EpisodesFailure _ => SliverFillRemaining(
                    child: TextBanner(
                      title: 'Error occurred',
                      description:
                          'Sorry, something went wrong, please try again later',
                    ),
                  ),
                  EpisodesState() => SliverFillRemaining(
                    child: PlatformBackgroundLoader(),
                  ),
                };
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (currentScroll >= maxScroll * 0.9) {
      BlocProvider.of<EpisodesBloc>(context).add(LoadMoreEpisodes());
    }
  }

  Future<void> _onRefresh() async {
    final completer = Completer();
    BlocProvider.of<EpisodesBloc>(
      context,
    ).add(RefreshEpisodes(completer: completer));
    return completer.future;
  }
}
