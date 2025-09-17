import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:rick_morty_app/features/episodes/episodes.dart';

part 'episodes_event.dart';
part 'episodes_state.dart';

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  final EpisodeRepository _episodeRepository;
  int _page = 1;
  final int _limit = 20;

  EpisodesBloc({required EpisodeRepository episodeRepository})
    : _episodeRepository = episodeRepository,
      super(EpisodesInitial()) {
    on<LoadEpisodes>(_load);
    on<LoadMoreEpisodes>(_loadMore, transformer: droppable());
    on<RefreshEpisodes>(_refresh);
  }

  Future<void> _load(LoadEpisodes event, Emitter<EpisodesState> emit) async {
    try {
      emit(EpisodesLoading());
      _page = 1;
      final episodes = await _episodeRepository.loadEpisodes(page: _page);
      emit(
        EpisodesLoaded(
          episodes: episodes,
          canLoadMore: _limit == episodes.length,
        ),
      );
    } catch (e) {
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

      final episodes = await _episodeRepository.loadEpisodes(page: ++_page);

      emit(
        EpisodesLoaded(
          episodes: [...currentState.episodes, ...episodes],
          canLoadMore: _limit == episodes.length,
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
      final episodes = await _episodeRepository.loadEpisodes(page: _page);
      emit(
        EpisodesLoaded(
          episodes: episodes,
          canLoadMore: episodes.length == _limit,
        ),
      );
    } catch (e) {
      emit(EpisodesFailure(error: e));
    } finally {
      event.completer.complete();
    }
  }
}
