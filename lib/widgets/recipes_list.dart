import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/widgets/recipe_card.dart';

import '../models/recipe_model.dart';
import 'large_text.dart';

class RecipesList extends StatefulWidget {
  late Future<List<Recipe>> recipes;

  RecipesList({super.key, required this.recipes});

  @override
  State<RecipesList> createState() => _RecipesListState();
}

class _RecipesListState extends State<RecipesList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: FutureBuilder<List<Recipe>>(
        future: widget.recipes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.orangeAccent[200],
              backgroundColor: Colors.amberAccent[100],
            ));
          } else if (snapshot.hasError) {
            return const Text('Помилка отримання рецептів');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('Немає рецептів');
          } else {
            return Column(
              children: <Widget>[
                snapshot.data != null
                    ? Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: LargeText(
                            text: '${snapshot.data!.length} Recipes found 💫',
                            color: Colors.black),
                      )
                    : Container(),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var recipe = snapshot.data![index];
                      return RecipeCard(color: Colors.white, recipe: recipe);
                    })
              ],
            );
          }
        },
      ),
    );
  }
}
