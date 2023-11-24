import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final double opacity;
  final Function()? onPressed;

  const AppIcon(
      {super.key,
      required this.icon,
      this.opacity = 1,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            color:
                Theme.of(context).colorScheme.secondary.withOpacity(opacity)),
        child: IconButton(
          icon: Icon(icon),
          color: Colors.white,
          onPressed: onPressed,
          padding: const EdgeInsets.all(10),
        ));
  }
}
