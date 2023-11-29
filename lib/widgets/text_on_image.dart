import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextOnImage extends StatelessWidget {
  final double x;
  final double y;
  final String name;

  const TextOnImage(
      {super.key, required this.x, required this.y, required this.name});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: x * MediaQuery.of(context).size.width,
      top: y * MediaQuery.of(context).size.height,
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.all(Radius.circular(10.r))),
        child: Text(
          name, // Текст, який ви хочете відобразити
          style: const TextStyle(
            fontSize: 16.0, // Розмір шрифту
            color: Colors.white, // Колір тексту
          ),
        ),
      ),
    );
  }
}
