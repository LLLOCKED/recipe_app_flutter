import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/widgets/recipe_card.dart';

import '../models/recipe_model.dart';

class RecipesListHoriz extends StatefulWidget {
  final Future<List<Recipe>> recipes;
  final double heightCard;

  const RecipesListHoriz(
      {super.key, required this.heightCard, required this.recipes});

  @override
  State<RecipesListHoriz> createState() => _RecipesListHorizState();
}

class _RecipesListHorizState extends State<RecipesListHoriz> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const ScrollPhysics(),
      child: FutureBuilder<List<Recipe>>(
        future: widget.recipes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.orangeAccent,
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ));
          } else if (snapshot.hasError) {
            return const Text('Помилка отримання рецептів');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('Немає рецептів');
          } else {
            return Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: AnimatedContainer(
                    height: widget.heightCard,
                    duration: const Duration(microseconds: 10),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var recipe = snapshot.data![index];
                          return SizedBox(
                            width: 300.w,
                            child: RecipeCard(
                              color: Theme.of(context).colorScheme.secondary,
                              largeTextColor: Colors.white,
                              smallTextColor:
                                  const Color.fromARGB(221, 130, 130, 130),
                              recipe: recipe,
                            ),
                          );
                        }),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
