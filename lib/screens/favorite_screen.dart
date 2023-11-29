import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/widgets/large_text.dart';
import 'package:recipe_app/widgets/recipes_list.dart';
import 'package:recipe_app/widgets/top_bar.dart';

import '../models/recipe_model.dart';
import '../utils/favorite_recipes_manager.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Future<List<Recipe>> favoriteRecipes;

  @override
  void initState() {
    super.initState();
    final favoritesManager = FavoriteRecipesManager();
    favoriteRecipes = favoritesManager.getFavoriteRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
            top: 30.h,
            left: 10.w,
            right: 10.w,
            child: const TopBar(
              rightIcon: false,
              title: "Favorite Recipes",
            )),
        Container(
          margin: EdgeInsets.only(top: 90.h),
          child: Padding(
            padding: EdgeInsets.all(10.r),
            child: ListView(children: [
              Column(
                children: [
                  RecipesList(recipes: favoriteRecipes),
                ],
              ),
            ]),
          ),
        ),
      ]),
    );
  }
}
