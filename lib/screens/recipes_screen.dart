import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/widgets/sliding_panel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../models/recipe_model.dart';
import '../providers/recipes_provider.dart';
import '../widgets/app_icon.dart';

class RecipesScreen extends StatefulWidget {
  final String imagePath;
  final List<String> ingredients;

  const RecipesScreen(
      {super.key, required this.imagePath, required this.ingredients});

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  late Future<List<Recipe>> _recipes;
  late int _offset = 0;

  @override
  void initState() {
    super.initState();
    _recipes = fetchRecipes(widget.ingredients, 5, _offset);
  }

  void refreshRecipes() {
    int offset = _offset + 5;
    Future<List<Recipe>> newRecipes =
        fetchRecipes(widget.ingredients, 5, offset);

    setState(() {
      _offset = offset;
      _recipes = newRecipes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final PanelController panelController = PanelController();

    return Scaffold(
      body: Stack(children: [
        SlidingUpPanel(
          backdropEnabled: true,
          color: Theme.of(context).colorScheme.background,
          minHeight: 250.h,
          controller: panelController,
          body: kIsWeb
              ? Image.network(widget.imagePath)
              : Image.file(
                  File(widget.imagePath),
                  fit: BoxFit.cover,
                ),
          panelBuilder: (controller) => Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10).r,
            child: SlidingPanel(
              panelController: panelController,
              scrollController: controller,
              recipes: _recipes,
            ),
          ),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        Positioned(
            top: 30.h,
            left: 10.w,
            right: 10.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 10.r),
              width: 1.sw,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    icon: Icons.arrow_back_ios_sharp,
                    opacity: 0.4,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            )),
        Padding(
          padding: const EdgeInsets.all(20).r,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              backgroundColor: Colors.yellow,
              shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 4, color: Colors.white),
                  borderRadius: BorderRadius.circular(100)),
              onPressed: () async {
                refreshRecipes();
              },
              // onPressed: () => visionImage(file: File(imagePath)),
              child: const Icon(Icons.repeat_sharp),
            ),
          ),
        ),
      ]),
    );
  }
}
