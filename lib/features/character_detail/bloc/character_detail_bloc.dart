import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_app/features/episodes/repository/episodes_repository.dart';
import 'package:rick_morty_app/models/models.dart';
import 'package:rick_morty_app/repositories/repositories.dart';
import 'package:rick_morty_app/models/character/character.dart';

part 'character_detail_event.dart';
part 'character_detail_state.dart';

class CharacterDetailBloc
    extends Bloc<CharacterDetailEvent, CharacterDetailState> {
  final CharactersRepository charactersRepository;
  final EpisodesRepository episodesRepository;

  CharacterDetailBloc({
    required this.charactersRepository,
    required this.episodesRepository,
  }) : super(CharacterDetailInitial()) {
    on<LoadCharacterDetail>(_load);
  }

  Future<void> _load(
    LoadCharacterDetail event,
    Emitter<CharacterDetailState> emit,
  ) async {
    try {
      emit(CharacterDetailLoading());

      final character = await charactersRepository.loadCharacterById(
        id: event.id,
      );

      final episodes = await _loadAllEpisodes(character.episode);

      emit(CharacterDetailLoaded(character, episodes));
    } catch (e) {
      emit(CharacterDetailFailure(error: e));
    }
  }

  Future<List<Episode>> _loadAllEpisodes(List<String> urls) async {
    final ids =
        urls.map((url) {
          return int.parse(url.split('/').last);
        }).toList();
    return await episodesRepository.loadEpisodes(page: 1, ids: ids);
  }
}
