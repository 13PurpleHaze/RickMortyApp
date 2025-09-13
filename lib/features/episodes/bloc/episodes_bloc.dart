import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_app/features/episodes/repository/episodes_repository.dart';
import 'package:rick_morty_app/models/models.dart';

part 'episodes_event.dart';
part 'episodes_state.dart';

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  int _page = 1;
  final EpisodesRepository episodesRepository;

  EpisodesBloc({required this.episodesRepository}) : super(EpisodesInitial()) {
    on<LoadEpisodes>(_load);
    on<LoadMoreEpisodes>(_loadMore, transformer: droppable());
    on<RefreshEpisodes>(_refresh);
  }

  Future<void> _load(LoadEpisodes event, Emitter<EpisodesState> emit) async {
    try {
      emit(EpisodesLoading());
      _page = 1;
      final episodes = await episodesRepository.loadEpisodes(page: _page);
      emit(
        EpisodesLoaded(episodes: episodes, canLoadMore: 20 == episodes.length),
      );
    } catch (e) {
      print(e);
      emit(EpisodesFailure(error: e));
    }
  }

  Future<void> _loadMore(
    LoadMoreEpisodes event,
    Emitter<EpisodesState> emit,
  ) async {
    try {
      if (state is! EpisodesLoaded) {
        return;
      }

      final currentState = state as EpisodesLoaded;

      if (!currentState.canLoadMore) {
        return;
      }

      final episodes = await episodesRepository.loadEpisodes(page: ++_page);
      emit(
        EpisodesLoaded(
          episodes: [...currentState.episodes, ...episodes],
          canLoadMore: 20 == episodes.length,
        ),
      );
    } catch (e) {
      emit(EpisodesFailure(error: e));
    }
  }

  Future<void> _refresh(
    RefreshEpisodes event,
    Emitter<EpisodesState> emit,
  ) async {
    try {
      _page = 1;
      final episodes = await episodesRepository.loadEpisodes(page: _page);
      emit(
        EpisodesLoaded(episodes: episodes, canLoadMore: episodes.length == 20),
      );
    } catch (e) {
      emit(EpisodesFailure(error: e));
    }
  }
}
