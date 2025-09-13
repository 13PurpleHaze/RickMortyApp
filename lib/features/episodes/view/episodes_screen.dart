import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_app/features/characters/bloc/characters_bloc.dart';
import 'package:rick_morty_app/features/episodes/bloc/episodes_bloc.dart';
import 'package:rick_morty_app/features/episodes/widgets/episode_card_shimmer.dart';
import 'package:rick_morty_app/features/episodes/widgets/widgets.dart';
import 'package:rick_morty_app/ui/widgets/widgets.dart';

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
    _scrollController.addListener(onScroll);
    BlocProvider.of<EpisodesBloc>(context).add(LoadEpisodes());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          PlatformAppBar(title: 'Episodes'),
          BlocBuilder<EpisodesBloc, EpisodesState>(
            builder: (context, state) {
              return switch (state) {
                EpisodesLoading _ => SliverFillRemaining(
                  child: PlatformBackgroundLoader(),
                ),
                EpisodesLoaded state => SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount:
                        state.episodes.length + (state.canLoadMore ? 2 : 0),
                    (context, index) {
                      if (index >= state.episodes.length) {
                        return EpisodeCardShimmer();
                      } else {
                        final episode = state.episodes[index];
                        return Column(
                          children: [
                            EpisodeCard(
                              title: episode.episode,
                              name: episode.name,
                              date: episode.airDate,
                            ),
                            const Divider(
                              height: 20,
                              thickness: 1,
                              indent: 16,
                              endIndent: 16,
                              color: Colors.black38,
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
                EpisodesFailure _ => SliverFillRemaining(
                  child: PlatformBackgroundLoader(),
                ),
                // TODO: Handle this case.
                EpisodesState() => SliverFillRemaining(
                  child: PlatformBackgroundLoader(),
                ),
              };
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (currentScroll >= maxScroll * 0.9) {
      _loadEpisodes();
    }
  }

  void _loadEpisodes() {
    BlocProvider.of<CharactersBloc>(context).add(LoadMoreCharacters());
  }

  // Future<void> _onSearchPressed() async {}

  // Future<void> _refresh() async {
  //   BlocProvider.of<CharactersBloc>(context).add(RefreshCharacters());
  // }
}
