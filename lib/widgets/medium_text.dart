import 'package:flutter/material.dart';

class MediumText extends StatelessWidget {
  final String text;
  final Color color;

  const MediumText({super.key, required this.text, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.displaySmall?.copyWith(color: color),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}
