import 'package:isar/isar.dart';
import 'package:rick_and_morty/features/characters/domain/character.dart';

part 'character_cache.g.dart';

@collection
class CharacterCache {
  Id id = Isar.autoIncrement;

  late int characterId;
  late String name;
  late String image;
  late String status;

  CharacterCache();

  CharacterCache.fromDomain(Character c) {
    characterId = c.id;
    name = c.name;
    image = c.image;
    status = c.status;
  }

  Character toDomain() =>
      Character(id: characterId, name: name, image: image, status: status);
}
