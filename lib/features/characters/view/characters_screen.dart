import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_app/features/characters/bloc/characters_bloc.dart';
import 'package:rick_morty_app/features/characters/widgets/character_card.dart';
import 'package:rick_morty_app/features/characters/widgets/character_shimmer.dart';
import 'package:rick_morty_app/ui/widgets/widgets.dart';

@RoutePage()
class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(onScroll);
    BlocProvider.of<CharactersBloc>(context).add(LoadCharacters());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator.adaptive(
        onRefresh: _refresh,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            PlatformAppBar(
              title: 'Characters',
              onChangeSearchBarTextChange: _onChangeSearchBarText,
              onSearchableBottomTap: _onSearchableBottomTap,
            ),
            BlocBuilder<CharactersBloc, CharactersState>(
              builder: (context, state) {
                return switch (state) {
                  CharactersLoading _ => SliverFillRemaining(
                    child: PlatformBackgroundLoader(),
                  ),
                  CharactersLoaded state => SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    sliver: SliverGrid.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.8,
                          ),
                      itemCount:
                          state.characters.length % 2 == 0
                              ? state.characters.length +
                                  (state.canLoadMore ? 2 : 0)
                              : state.characters.length +
                                  (state.canLoadMore ? 3 : 0),
                      itemBuilder: (context, index) {
                        if (index >= state.characters.length) {
                          return CharacterShimmer();
                        } else {
                          final character = state.characters[index];
                          return CharacterCard(
                            name: character.name,
                            image: character.image,
                            status: character.status,
                            onTap: () => {},
                          );
                        }
                      },
                    ),
                  ),
                  // TODO: Handle this case.
                  CharactersState() => SliverFillRemaining(
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

  void onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (currentScroll >= maxScroll * 0.9) {
      _loadCharacters();
    }
  }

  void _onChangeSearchBarText(String text) {
    BlocProvider.of<CharactersBloc>(
      context,
    ).add(SearchCharacters(search: text));
  }

  void _onSearchableBottomTap(bool result) {
    if (!result) {
      BlocProvider.of<CharactersBloc>(
        context,
      ).add(SearchCharacters(search: ''));
    }
  }

  void _loadCharacters() {
    BlocProvider.of<CharactersBloc>(context).add(LoadMoreCharacters());
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    BlocProvider.of<CharactersBloc>(context).add(RefreshCharacters());
  }
}
