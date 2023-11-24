import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchField extends StatelessWidget {
  final TextEditingController ingredientsController;
  final VoidCallback onPressed;

  const SearchField(
      {super.key,
      required this.ingredientsController,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      controller: ingredientsController,
      style: Theme.of(context).textTheme.titleMedium,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20.r),
          filled: true,
          fillColor: Theme.of(context).colorScheme.secondary,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.r))),
          hintText: 'Try "egg, chicken, onion"',
          hintStyle: Theme.of(context).textTheme.titleMedium,
          suffixIcon: IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: onPressed,
            color: Theme.of(context).colorScheme.background,
          )),
    );
  }
}
