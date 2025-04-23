import 'package:rick_and_morty/features/characters/domain/character.dart';

class CharacterModel extends Character {
  CharacterModel({
    required int id,
    required String name,
    required String image,
    required String status,
  }) : super(id: id, name: name, image: image, status: status);
  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
    id: json['id'],
    name: json['name'],
    image: json['image'],
    status: json['status'],
  );
}
