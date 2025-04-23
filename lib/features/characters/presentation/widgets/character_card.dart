import 'package:flutter/material.dart';
import 'package:rick_and_morty/features/characters/domain/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final bool isFavorite;
  final VoidCallback? onFavoriteToggle;

  const CharacterCard({
    super.key,
    required this.character,
    this.isFavorite = false,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      color: isDark ? Colors.grey[900] : Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: isDark ? Colors.white10 : Colors.black12),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            character.image,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          character.name,
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
        ),
        subtitle: Text(
          'Status: ${character.status}',
          style: TextStyle(color: isDark ? Colors.white70 : Colors.black54),
        ),
        trailing: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder:
              (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
          child: IconButton(
            key: ValueKey<bool>(isFavorite),
            icon: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              color:
                  isFavorite
                      ? Colors.amber
                      : (isDark ? Colors.white : Colors.black45),
            ),
            onPressed: onFavoriteToggle,
          ),
        ),
      ),
    );
  }
}
