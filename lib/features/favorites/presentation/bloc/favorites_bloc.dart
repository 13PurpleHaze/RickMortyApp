import 'package:bloc/bloc.dart';
import 'package:rick_morty_app/core/services/firebase_analitics/firebase_analytics_service.dart';
import 'package:rick_morty_app/features/character/character.dart';
import 'package:rick_morty_app/features/favorites/events/favorites_events.dart';
import 'package:rick_morty_app/features/favorites/favorites.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoriteRepository _favoriteRepository;
  final FirebaseAnalyticsService _firebaseAnalyticsService;

  FavoritesBloc({
    required FirebaseAnalyticsService firebaseAnalyticsService,
    required FavoriteRepository favoriteRepository,
  }) : _favoriteRepository = favoriteRepository,
       _firebaseAnalyticsService = firebaseAnalyticsService,
       super(FavoritesInitial()) {
    on<LoadFavorites>(_load);
    on<ToggleFavorite>(_toggle);
  }

  Future<void> _load(LoadFavorites event, Emitter<FavoritesState> emit) async {
    try {
      emit(FavoritesLoading());
      final favorites = await _favoriteRepository.loadCharacters();
      emit(
        FavoritesLoaded(
          favorites: favorites,
          favoriteIds: favorites.map((favorite) => favorite.id).toList(),
        ),
      );
    } catch (e) {
      emit(FavoritesFailure(error: e));
    }
  }

  Future<void> _toggle(
    ToggleFavorite event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      if (state is! FavoritesLoaded) {
        return;
      }
      final isFavorite = (state as FavoritesLoaded).favoriteIds.contains(
        event.character.id,
      );
      if (isFavorite) {
        await _favoriteRepository.removeFromFavorites(event.character.id);
      } else {
        await _favoriteRepository.addToFavorites(event.character);
      }
      _firebaseAnalyticsService.logEvent(ToggleFavoriteEvent());

      final favorites = await _favoriteRepository.loadCharacters();
      emit(
        FavoritesLoaded(
          favorites: favorites,
          favoriteIds: favorites.map((f) => f.id).toList(),
        ),
      );
    } catch (e) {
      emit(FavoriteToggledFailure(error: e));
    }
  }
}
