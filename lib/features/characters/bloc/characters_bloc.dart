import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_app/models/models.dart';
import 'package:rick_morty_app/repositories/repositories.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharactersRepository charactersRepository;
  int _page = 0;
  String _query = '';

  CharactersBloc({required this.charactersRepository})
    : super(CharactersInitial()) {
    on<LoadCharacters>(_load);
    on<LoadMoreCharacters>(_loadMore, transformer: droppable());
    on<RefreshCharacters>(_refresh);
    on<SearchCharacters>(_search, transformer: restartable());
  }

  Future<void> _load(
    LoadCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    try {
      emit(CharactersLoading());
      _page = 1;
      final characters = await charactersRepository.loadCharacters(page: _page);
      emit(
        CharactersLoaded(
          characters: characters,
          canLoadMore: characters.length == 20,
        ),
      );
    } catch (e) {
      emit(CharactersFailure(error: e));
    }
  }

  Future<void> _loadMore(
    LoadMoreCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    try {
      if (state is! CharactersLoaded) {
        return;
      }

      final currentState = state as CharactersLoaded;

      if (!currentState.canLoadMore) {
        return;
      }

      final characters = await charactersRepository.loadCharacters(
        page: ++_page,
      );
      emit(
        CharactersLoaded(
          characters: [...currentState.characters, ...characters],
          canLoadMore: characters.length == 20,
        ),
      );
    } catch (e) {
      emit(CharactersFailure(error: e));
    }
  }

  Future<void> _refresh(
    RefreshCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    try {
      _page = 1;
      final characters = await charactersRepository.loadCharacters(page: _page);
      emit(
        CharactersLoaded(
          characters: characters,
          canLoadMore: characters.length == 20,
        ),
      );
    } catch (e) {
      emit(CharactersFailure(error: e));
    }
  }

  Future<void> _search(
    SearchCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    try {
      _page = 1;
      _query = event.search;

      if (_query.isEmpty) {
        add(LoadCharacters());
        return;
      }

      if (_query.length < 3) {
        return;
      }

      emit(CharactersLoading());

      final characters = await charactersRepository.loadCharacters(
        page: _page,
        search: _query,
      );

      emit(
        CharactersLoaded(
          characters: characters,
          canLoadMore: characters.length == 20,
          //isSearch: true,
          //searchQuery: _currentSearch,
        ),
      );
    } catch (e) {
      emit(CharactersFailure(error: e));
    }
  }
}
