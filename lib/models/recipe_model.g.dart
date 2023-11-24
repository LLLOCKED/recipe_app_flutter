// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipe _$RecipeFromJson(Map<String, dynamic> json) => Recipe(
      title: json['Title'] as String,
      ingredients: json['Ingredients'] as String,
      instructions: json['Instructions'] as String,
      imageName: json['Image_Name'] as String,
    );

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'Title': instance.title,
      'Ingredients': instance.ingredients,
      'Instructions': instance.instructions,
      'Image_Name': instance.imageName,
    };
