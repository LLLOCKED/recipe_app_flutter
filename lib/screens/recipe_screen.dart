import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/widgets/medium_text.dart';

import '../constants.dart';
import '../models/recipe_model.dart';

class RecipeScreen extends StatelessWidget {
  final Recipe recipe;
  const RecipeScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    String ingredientsString =
        recipe.ingredients.replaceAll(RegExp(r"^\['|'\]$"), '');
    List<String> ingredientsList = ingredientsString.split('\', \'');

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(70.h),
              child: Container(
                  padding: EdgeInsets.all(15.r),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r))),
                  child: Center(
                    child: MediumText(
                      text: recipe.title,
                      color: Colors.black,
                    ),
                  )),
            ),
            pinned: true,
            // floating: true,
            expandedHeight: 300.h,
            flexibleSpace: FlexibleSpaceBar(
              // title: MediumText(text: recipe.title),
              background: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            "${ApiConstants.baseUrl}/${recipe.imageName}.jpg"))),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(15.r),
                  width: double.maxFinite,
                  color: Colors.black12,
                  child: const MediumText(
                    text: "Ingredients",
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: ingredientsList.map((ingredient) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 1.h),
                        child: Text('● $ingredient'),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15.r),
                  width: double.maxFinite,
                  color: Colors.black12,
                  child: const MediumText(
                    text: "Instructions",
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.r),
                  child: Text(
                    recipe.instructions,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 18.0, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
