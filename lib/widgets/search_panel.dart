import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/widgets/medium_text.dart';
import 'package:recipe_app/widgets/recipes_list_horiz.dart';

import '../components/search_field.dart';
import '../models/recipe_model.dart';
import '../providers/recipes_provider.dart';
import 'large_text.dart';

class SearchPanel extends StatefulWidget {
  const SearchPanel({super.key});

  @override
  State<SearchPanel> createState() => _SearchPanelState();
}

class _SearchPanelState extends State<SearchPanel> with WidgetsBindingObserver {
  bool isKeyboardVisible = false;
  double containerHeight = 170.0;

  late int _offset = 0;
  late Future<List<Recipe>> _recipes;
  final TextEditingController _ingredientsController = TextEditingController();

  stringToList(text) {
    String clearText = text.toLowerCase().replaceAll(' ', '');
    List<String> items = clearText.split(',');
    return items;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _recipes =
        fetchRecipes(stringToList(_ingredientsController.text), 5, _offset);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final double bottomInset = EdgeInsets.fromWindowPadding(
            WidgetsBinding.instance.window.viewInsets,
            WidgetsBinding.instance.window.devicePixelRatio)
        .bottom;

    setState(() {
      isKeyboardVisible = bottomInset > 0;
      if (isKeyboardVisible) {
        containerHeight = 0.0.h;
      } else {
        containerHeight = 170.0.h;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(vertical: 30.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.r), topRight: Radius.circular(50.r)),
          color: Theme.of(context).colorScheme.primary),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const LargeText(text: "Quick search"),
                  GestureDetector(
                      onTap: () {
                        int offset = _offset + 5;
                        Future<List<Recipe>> newRecipes = fetchRecipes(
                            stringToList(_ingredientsController.text),
                            5,
                            offset);

                        setState(() {
                          _offset = offset;
                          _recipes = newRecipes;
                        });
                      },
                      child: const MediumText(text: 'Refresh'))
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            RecipesListHoriz(
                // ingredients: stringToList(_ingredientsController.text),
                recipes: _recipes,
                heightCard: containerHeight),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SearchField(
                ingredientsController: _ingredientsController,
                onPressed: () {
                  int offset = 0;
                  Future<List<Recipe>> newRecipes = fetchRecipes(
                      stringToList(_ingredientsController.text), 5, offset);

                  setState(() {
                    _offset = offset;
                    _recipes = newRecipes;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
