import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe_app/models/vision_model.dart';
import 'package:recipe_app/screens/recipes_screen.dart';
import 'package:recipe_app/widgets/labels_list.dart';
import 'package:recipe_app/widgets/text_on_image.dart';
import 'package:recipe_app/widgets/top_bar.dart';

class PictureScreen extends StatefulWidget {
  final String imagePath;
  final Vision scanResult;

  const PictureScreen(
      {super.key, required this.imagePath, required this.scanResult});

  @override
  State<PictureScreen> createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen> {
  late List<String> selectedProducts;

  @override
  void initState() {
    selectedProducts = widget.scanResult.uniqueNames;
    super.initState();
  }

  void handleProductTap(String product) {
    if (selectedProducts.contains(product)) {
      setState(() {
        selectedProducts.remove(product);
      });
    } else {
      setState(() {
        selectedProducts.add(product);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String namesString = selectedProducts.join(', ');
    List<String> labels = widget.scanResult.labelsObjects;

    return Scaffold(
      body: Stack(children: [
        SizedBox(
            height: 1.sh,
            width: 1.sw,
            child: kIsWeb
                ? Image.network(widget.imagePath)
                : Image.file(
                    File(widget.imagePath),
                    fit: BoxFit.cover,
                  )),
        for (var obj in widget.scanResult.objectData)
          TextOnImage(
              x: obj.coordinates.x, y: obj.coordinates.y, name: obj.name),
        Positioned(
            top: 30.h,
            left: 10.w,
            right: 10.w,
            child: const TopBar(
              rightIcon: false,
              title: "Recipe Scanner",
            )),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
              margin: EdgeInsets.only(left: 5.w),
              width: 0.35.sw,
              child: LabelsList(
                labels: labels,
                handleProductTap: handleProductTap,
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(20).r,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      border: Border.all(color: Colors.white, width: 1.r),
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.4)),
                  child: Text(
                    namesString,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                FloatingActionButton(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 3, color: Colors.black26),
                      borderRadius: BorderRadius.circular(100)),
                  onPressed: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => RecipesScreen(
                              imagePath: widget.imagePath,
                              ingredients: selectedProducts)),
                    );
                  },
                  // onPressed: () => visionImage(file: File(imagePath)),
                  child: const Icon(Icons.all_inclusive_outlined),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
