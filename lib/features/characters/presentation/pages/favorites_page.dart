import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty/features/characters/domain/character.dart';
import 'package:rick_and_morty/features/characters/presentation/state/favorite_notifier.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_card.dart';

enum SortType { name, status }

class FavoritesPage extends ConsumerStatefulWidget {
  const FavoritesPage({super.key});

  @override
  ConsumerState<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends ConsumerState<FavoritesPage> {
  SortType _sortType = SortType.name;

  List<Character> _sort(List<Character> characters) {
    final sorted = [...characters];
    switch (_sortType) {
      case SortType.name:
        sorted.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortType.status:
        sorted.sort((a, b) => a.status.compareTo(b.status));
        break;
    }
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoriteNotifierProvider);
    final sortedFavorites = _sort(favorites);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: DropdownButton<SortType>(
            value: _sortType,
            onChanged: (value) => setState(() => _sortType = value!),
            items: const [
              DropdownMenuItem(
                value: SortType.name,
                child: Text('Сортировать по имени'),
              ),
              DropdownMenuItem(
                value: SortType.status,
                child: Text('Сортировать по статусу'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: sortedFavorites.length,
            itemBuilder: (context, index) {
              final character = sortedFavorites[index];
              return CharacterCard(
                character: character,
                isFavorite: true,
                onFavoriteToggle: () {
                  ref.read(favoriteNotifierProvider.notifier).toggle(character);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}