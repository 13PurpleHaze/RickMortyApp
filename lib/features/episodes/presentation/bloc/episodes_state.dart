part of 'episodes_bloc.dart';

class EpisodesState {}

class EpisodesInitial extends EpisodesState {}

class EpisodesLoading extends EpisodesState {}

class EpisodesLoaded extends EpisodesState {
  final List<Episode> episodes;
  final bool canLoadMore;

  EpisodesLoaded({required this.episodes, required this.canLoadMore});
}

class EpisodesFailure extends EpisodesState {
  final Object error;

  EpisodesFailure({required this.error});
}
