import 'package:rick_and_morty/data/api/character_api.dart';
import 'package:rick_and_morty/data/repository/character_repository.dart';
import 'package:rick_and_morty/features/characters/domain/character.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterApi api;
  CharacterRepositoryImpl(this.api);

  @override
  Future<List<Character>> getCharacters(int page) => api.fetchCharacters(page);
}
