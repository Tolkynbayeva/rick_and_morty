import 'package:isar/isar.dart';
import 'package:rick_and_morty/features/characters/domain/character.dart';

part 'character_isar.g.dart';

@collection
class CharacterIsar {
  Id id = Isar.autoIncrement;

  late int characterId;
  late String name;
  late String image;
  late String status;

  CharacterIsar();

  CharacterIsar.fromDomain(Character c) {
    characterId = c.id;
    name = c.name;
    image = c.image;
    status = c.status;
  }

  Character toDomain() => Character(
        id: characterId,
        name: name,
        image: image,
        status: status,
      );
}