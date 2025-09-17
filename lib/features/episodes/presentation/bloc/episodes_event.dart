part of 'episodes_bloc.dart';

class EpisodesEvent {}

class LoadEpisodes extends EpisodesEvent {}

class LoadMoreEpisodes extends EpisodesEvent {}

class RefreshEpisodes extends EpisodesEvent {
  final Completer completer;

  RefreshEpisodes({required this.completer});
}
