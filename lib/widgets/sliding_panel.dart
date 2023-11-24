import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/recipes_list.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../models/recipe_model.dart';

class SlidingPanel extends StatelessWidget {
  final ScrollController scrollController;
  final PanelController panelController;
  late Future<List<Recipe>> recipes;

  SlidingPanel(
      {super.key,
      required this.panelController,
      required this.scrollController,
      required this.recipes});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      controller: scrollController,
      children: [
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () => panelController.isPanelOpen
              ? panelController.close()
              : panelController.open(),
          child: Center(
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.all(Radius.circular(50))),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        RecipesList(
          recipes: recipes,
        )
      ],
    );
  }
}
