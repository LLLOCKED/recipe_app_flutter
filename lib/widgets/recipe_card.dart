import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/widgets/medium_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/recipe_model.dart';
import '../screens/recipe_screen.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final Color color;
  final Color largeTextColor;
  final Color smallTextColor;

  const RecipeCard(
      {super.key,
      required this.recipe,
      this.color = Colors.white,
      this.largeTextColor = Colors.black,
      this.smallTextColor = Colors.black54});

  @override
  Widget build(BuildContext context) {
    String ingredientsString =
        recipe.ingredients.replaceAll(RegExp(r"^\[|\]$"), '');
    // List<String> ingredientsList = ingredientsString.split(', ');

    return InkWell(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RecipeScreen(
                    recipe: recipe,
                  )),
        );
      },
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(40.r), // Змініть значення за необхідності
        ),
        child: Padding(
          padding: const EdgeInsets.all(20).r,
          child: Row(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MediumText(
                      text: recipe.title,
                      color: largeTextColor,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      ingredientsString,
                      style: TextStyle(color: smallTextColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                flex: 3,
                child: Center(
                  child: SizedBox(
                    width: 200, // Розтягнути контейнер по ширині екрану
                    height: 100, // Розтягнути контейнер по висоті екрану

                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Image(
                        image: NetworkImage(
                            "${ApiConstants.baseUrl}/${recipe.imageName}.jpg"),
                        fit: BoxFit
                            .cover, // Розтягнути картинку по висоті і ширині
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
