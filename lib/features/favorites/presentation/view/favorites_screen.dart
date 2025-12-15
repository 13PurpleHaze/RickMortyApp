import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_morty_app/core/ui/ui.dart';

import '../bloc/favorites_bloc.dart';
import '../widgets/widgets.dart';

@RoutePage()
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    BlocProvider.of<FavoritesBloc>(context).add(LoadFavorites());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          PlatformAppBar(title: "Favorites"),
          BlocConsumer<FavoritesBloc, FavoritesState>(
            listener: (context, state) {
              if (state is FavoriteToggledFailure) {
                _showDialog();
              }
            },
            buildWhen:
                (previous, current) => current is! FavoriteToggledFailure,
            builder: (context, state) {
              if (state is FavoritesLoading) {
                return SliverFillRemaining(child: PlatformBackgroundLoader());
              }
              if (state is FavoritesLoaded) {
                if (state.favorites.isNotEmpty) {
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    sliver: SliverGrid.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 500,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 2,
                      ),
                      itemCount: state.favorites.length,

                      itemBuilder: (context, index) {
                        final favorite = state.favorites[index];
                        return FavoriteCard(
                          name: favorite.name,
                          image: favorite.image,
                          status: favorite.status.name,
                          species: favorite.species,
                          gender: favorite.gender.name,
                          leading: ToggleFavoritesButton(character: favorite),
                        );
                      },
                    ),
                  );
                } else {
                  return SliverFillRemaining(
                    child: TextBanner(
                      title: 'Empty((',
                      description: 'There is nothing yet',
                    ),
                  );
                }
              }
              if (state is FavoritesFailure) {
                return SliverFillRemaining(
                  child: TextBanner(
                    title: 'Error occurred',
                    description:
                        'Sorry, something went wrong, please try again later',
                  ),
                );
              }

              return SliverFillRemaining(child: PlatformBackgroundLoader());
            },
          ),
        ],
      ),
    );
  }

  // TODO: его лучше вынести тк он должен еще появляться на деталке
  void _showDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: const Text('Error adding to favorites'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Try again later, sorry😔'),
                Text('領域展開'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
