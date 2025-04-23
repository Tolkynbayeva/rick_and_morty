import 'package:rick_and_morty/features/characters/domain/character.dart';

abstract class CharacterRepository {
  Future<List<Character>> getCharacters(int page);
}