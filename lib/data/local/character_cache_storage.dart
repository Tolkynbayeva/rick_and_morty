import 'package:isar/isar.dart';
import 'package:rick_and_morty/data/local/app_storage.dart';
import 'package:rick_and_morty/features/characters/domain/character.dart';
import '../models/character_cache.dart';

class CharacterCacheStorage {
  final isar = AppStorage.isar;

  Future<void> saveAll(List<Character> characters) async {
    final data = characters.map((c) => CharacterCache.fromDomain(c)).toList();
    await isar.writeTxn(() async {
      await isar.characterCaches.clear();
      await isar.characterCaches.putAll(data);
    });
  }

  Future<List<Character>> loadAll() async {
    final cached = await isar.characterCaches.where().findAll();
    return cached.map((e) => e.toDomain()).toList();
  }
}