import 'package:recipe_app/constants.dart';
import 'package:recipe_app/models/recipe_model.dart';
import 'package:dio/dio.dart';

Dio dio = Dio();
Future<List<Recipe>> fetchRecipes(
    List<String> ingredients, int limit, int offset) async {
  final response = await Dio().get(
      '${ApiConstants.baseUrl}${ApiConstants.recipeEndpoint}',
      queryParameters: {
        'ingredients': ingredients,
        'limit': limit,
        'offset': offset
      });

  if (response.statusCode == 200) {
    // Перевірка на успішну відповідь з серверу (код 200)
    final List<dynamic> data = response.data;

    return data.map((json) => Recipe.fromJson(json)).toList();
    ; // Парсинг відповіді у об'єкт Vision
  } else {
    throw Exception('Помилка отримання рецептів');
  }
}
