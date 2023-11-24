import 'package:flutter/material.dart';

class LargeText extends StatelessWidget {
  final String text;
  final Color color;

  const LargeText({super.key, required this.text, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.displayLarge?.copyWith(color: color),
    );
  }
}
