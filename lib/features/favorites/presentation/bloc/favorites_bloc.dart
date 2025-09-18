import 'package:bloc/bloc.dart';
import 'package:rick_morty_app/features/character/character.dart';
import 'package:rick_morty_app/features/favorites/favorites.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoriteRepository _favoriteRepository;

  FavoritesBloc({required FavoriteRepository favoriteRepository})
    : _favoriteRepository = favoriteRepository,
      super(FavoritesInitial()) {
    on<LoadFavorites>(_load);
  }

  Future<void> _load(LoadFavorites event, Emitter<FavoritesState> emit) async {
    try {
      emit(FavoritesLoading());
      final favorites = await _favoriteRepository.loadCharacters();
      emit(FavoritesLoaded(favorites: favorites));
    } catch (e) {
      print(e);
      emit(FavoritesFailure(error: e));
    }
  }
}
