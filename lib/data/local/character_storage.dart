import 'package:isar/isar.dart';
import 'package:rick_and_morty/data/local/app_storage.dart';
import 'package:rick_and_morty/features/characters/domain/character.dart';
import '../models/character_isar.dart';

class CharacterStorage {
  final isar = AppStorage.isar;

  Future<void> save(Character c) async {
    final model = CharacterIsar.fromDomain(c);
    await isar.writeTxn(() => isar.characterIsars.put(model));
  }

  Future<void> delete(int id) async {
    final existing =
        await isar.characterIsars.filter().characterIdEqualTo(id).findFirst();
    if (existing != null) {
      await isar.writeTxn(() => isar.characterIsars.delete(existing.id));
    }
  }

  Future<List<Character>> getAll() async {
    final items = await isar.characterIsars.where().findAll();
    return items.map((e) => e.toDomain()).toList();
  }
}