import 'package:json_annotation/json_annotation.dart';

part 'recipe_model.g.dart';

@JsonSerializable()
class Recipe {
  @JsonKey(name: 'Title')
  final String title;
  @JsonKey(name: 'Ingredients')
  final String ingredients;
  @JsonKey(name: 'Instructions')
  final String instructions;
  @JsonKey(name: 'Image_Name')
  final String imageName;

  Recipe(
      {required this.title,
      required this.ingredients,
      required this.instructions,
      required this.imageName});

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}
