import 'package:rick_and_morty/data/repository/character_repository.dart';
import 'package:rick_and_morty/features/characters/domain/character.dart';

class GetCharacters {
  final CharacterRepository repo;
  GetCharacters(this.repo);

  Future<List<Character>> call(int page) => repo.getCharacters(page);
}
