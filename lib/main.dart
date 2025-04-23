import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty/data/local/app_storage.dart';
import 'package:rick_and_morty/features/characters/presentation/pages/favorites_page.dart';
import 'package:rick_and_morty/features/characters/presentation/pages/home_page.dart';
import 'package:rick_and_morty/features/characters/presentation/state/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppStorage.init();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);

    return MaterialApp(
      title: 'Rick and Morty',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.green[50],
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
      ),
      themeMode: themeMode,
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends ConsumerStatefulWidget {
  const MainNavigation({super.key});

  @override
  ConsumerState<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends ConsumerState<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [HomePage(), FavoritesPage()];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF00FFA3), Color(0xFF3F5EFB), Color(0xFF2F2F2F)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Rick and Morty',
            style: TextStyle(color: isDark ? Colors.white : Colors.black),
          ),
          iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
          actions: [
            IconButton(
              icon: const Icon(Icons.brightness_6),
              onPressed:
                  () => ref.read(themeNotifierProvider.notifier).toggle(),
            ),
          ],
        ),
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor:
              isDark
                  ? Colors.black.withOpacity(0.7)
                  : Colors.white.withOpacity(0.9),
          selectedItemColor: isDark ? Colors.amber : Colors.deepPurple,
          unselectedItemColor: isDark ? Colors.white70 : Colors.black54,
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Все'),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Избранное'),
          ],
        ),
      ),
    );
  }
}
