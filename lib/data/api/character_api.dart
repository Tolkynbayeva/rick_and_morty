import 'package:dio/dio.dart';
import 'package:rick_and_morty/data/models/character_model.dart';

class CharacterApi {
  final Dio dio;
  CharacterApi(this.dio);

  Future<List<CharacterModel>> fetchCharacters(int page) async {
    final response = await dio.get(
      'https://rickandmortyapi.com/api/character/?page=$page',
    );
    return (response.data['results'] as List)
        .map((json) => CharacterModel.fromJson(json))
        .toList();
  }
}
