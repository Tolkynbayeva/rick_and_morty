import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty/features/characters/presentation/state/character_notifier.dart';
import 'package:rick_and_morty/features/characters/presentation/state/favorite_notifier.dart';
import 'package:rick_and_morty/features/characters/presentation/widgets/character_card.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final characters = ref.watch(characterNotifierProvider);
    final favorites = ref.watch(favoriteNotifierProvider);

    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          ref.read(characterNotifierProvider.notifier).loadMore();
        }
        return false;
      },
      child: ListView.builder(
        itemCount: characters.length,
        itemBuilder: (context, index) {
          final character = characters[index];
          final isFav = favorites.any((c) => c.id == character.id);

          return CharacterCard(
            character: character,
            isFavorite: isFav,
            onFavoriteToggle: () {
              ref.read(favoriteNotifierProvider.notifier).toggle(character);
            },
          );
        },
      ),
    );
  }
}