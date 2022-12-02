import 'package:flutter/material.dart';

class HomeTitle extends StatelessWidget {
  final String title;
  final VoidCallback onBackButtonPressed;
  final VoidCallback onForwardButtonPressed;
  const HomeTitle({
    super.key,
    required this.title,
    required this.onBackButtonPressed,
    required this.onForwardButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: onBackButtonPressed,
            icon: const Icon(Icons.arrow_circle_left_outlined)),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        IconButton(
            onPressed: onForwardButtonPressed,
            icon: const Icon(Icons.arrow_circle_right_outlined))
      ],
    );
  }
}
