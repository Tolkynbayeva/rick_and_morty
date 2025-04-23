import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty/data/api/character_api.dart';
import 'package:rick_and_morty/data/local/character_cache_storage.dart';
import 'package:rick_and_morty/data/repository/character_repository.dart';
import 'package:rick_and_morty/data/repository/character_repository_impl.dart';
import 'package:rick_and_morty/features/characters/domain/character.dart';
import 'package:rick_and_morty/features/characters/domain/get_characters.dart';

class CharacterNotifier extends StateNotifier<List<Character>> {
  final GetCharacters getCharacters;
  int _page = 1;
  bool _loading = false;

  CharacterNotifier(this.getCharacters) : super([]) {
    loadMore();
  }

  Future<void> loadMore() async {
    if (_loading) return;
    _loading = true;

    try {
      final newCharacters = await getCharacters(_page++);
      state = [...state, ...newCharacters];

      await CharacterCacheStorage().saveAll(state);
    } catch (e) {
      final cached = await CharacterCacheStorage().loadAll();
      state = cached;
    }

    _loading = false;
  }
}

final characterNotifierProvider =
    StateNotifierProvider<CharacterNotifier, List<Character>>(
      (ref) => CharacterNotifier(ref.watch(getCharactersProvider)),
    );

final getCharactersProvider = Provider<GetCharacters>((ref) {
  final repo = ref.watch(characterRepositoryProvider);
  return GetCharacters(repo);
});

final characterRepositoryProvider = Provider<CharacterRepository>((ref) {
  final api = CharacterApi(Dio());
  return CharacterRepositoryImpl(api);
});
