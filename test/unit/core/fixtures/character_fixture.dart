import 'package:rick_morty_app/features/character/domain/domain.dart';

class CharacterFixture {
  static List<Character> list({int count = 20}) {
    return List.generate(
      count,
      (index) => Character(
        id: index + 1,
        name: 'name',
        status: CharacterStatus.alive,
        species: 'species',
        gender: CharacterGender.male,
        origin: NameLink(name: 'name', url: 'url'),
        location: NameLink(name: 'name', url: 'url'),
        image: 'image',
        episode: ['episode'],
      ),
    );
  }
}
