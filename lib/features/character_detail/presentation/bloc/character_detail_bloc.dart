import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_morty_app/features/character/character.dart';
import 'package:rick_morty_app/features/episodes/episodes.dart';

part 'character_detail_event.dart';
part 'character_detail_state.dart';

class CharacterDetailBloc
    extends Bloc<CharacterDetailEvent, CharacterDetailState> {
  final CharacterRepository _characterRepository;
  final EpisodeRepository _episodeRepository;

  CharacterDetailBloc({
    required CharacterRepository characterRepository,
    required EpisodeRepository episodeRepository,
  }) : _characterRepository = characterRepository,
       _episodeRepository = episodeRepository,
       super(CharacterDetailInitial()) {
    on<LoadCharacterDetail>(_load);
  }

  Future<void> _load(
    LoadCharacterDetail event,
    Emitter<CharacterDetailState> emit,
  ) async {
    try {
      emit(CharacterDetailLoading());

      final character = await _characterRepository.loadCharacterById(
        id: event.id,
      );

      final episodes = await _loadAllEpisodes(character.episode);

      emit(CharacterDetailLoaded(character, episodes));
    } catch (e) {
      print(e);
      emit(CharacterDetailFailure(error: e));
    }
  }

  Future<List<Episode>> _loadAllEpisodes(List<String> urls) async {
    final ids =
        urls.map((url) {
          return int.parse(url.split('/').last);
        }).toList();
    return await _episodeRepository.loadEpisodes(page: 1, ids: ids);
  }
}
