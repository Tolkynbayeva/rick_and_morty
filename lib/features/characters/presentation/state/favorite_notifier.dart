import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty/data/local/character_storage.dart';
import 'package:rick_and_morty/features/characters/domain/character.dart';

class FavoriteNotifier extends StateNotifier<List<Character>> {
  final CharacterStorage storage;

  FavoriteNotifier(this.storage) : super([]) {
    _loadFromStorage();
  }

  Future<void> _loadFromStorage() async {
    final items = await storage.getAll();
    state = items;
  }

  void toggle(Character character) async {
    final exists = state.any((c) => c.id == character.id);
    if (exists) {
      await storage.delete(character.id);
      state = state.where((c) => c.id != character.id).toList();
    } else {
      await storage.save(character);
      state = [...state, character];
    }
  }

  bool isFavorite(Character character) {
    return state.any((c) => c.id == character.id);
  }
}

final favoriteNotifierProvider = StateNotifierProvider<FavoriteNotifier, List<Character>>(
  (ref) => FavoriteNotifier(CharacterStorage()),
);