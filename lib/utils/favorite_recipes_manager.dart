import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/recipe_model.dart';

class FavoriteRecipesManager {
  static const _favoritesKey = 'favorite_recipes';

  Future<List<Recipe>> getFavoriteRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_favoritesKey);
    if (jsonString != null) {
      List<Recipe> favoriteRecipes = (json.decode(jsonString) as List)
          .map((i) => Recipe.fromJson(i))
          .toList();
      return favoriteRecipes;
    }
    return [];
  }

  Future<void> addFavoriteRecipe(Recipe recipe) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteRecipes = await getFavoriteRecipes();
    favoriteRecipes.add(recipe);
    final jsonString =
        json.encode(favoriteRecipes.map((recipe) => recipe.toJson()).toList());
    prefs.setString(_favoritesKey, jsonString);
  }

  Future<void> removeFromFavorites(Recipe recipe) async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteRecipes = await getFavoriteRecipes();
    // favoriteRecipes.remove(recipe);
    favoriteRecipes.removeWhere((jsonString) {
      return jsonString.title == recipe.title;
    });
    final jsonString =
        json.encode(favoriteRecipes.map((recipe) => recipe.toJson()).toList());
    prefs.setString(_favoritesKey, jsonString);
  }
}
