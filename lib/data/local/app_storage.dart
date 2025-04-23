import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../models/character_cache.dart';
import '../models/character_isar.dart';

class AppStorage {
  static late Isar isar;

  static Future<void> init() async {
    if (Isar.getInstance() != null) {
      isar = Isar.getInstance()!;
      return;
    }

    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [
        CharacterCacheSchema,
        CharacterIsarSchema,
      ],
      directory: dir.path,
    );
  }
}