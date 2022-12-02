import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback navigateTo;
  final String title;
  const PrimaryButton({
    super.key,
    required this.navigateTo,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          padding: const MaterialStatePropertyAll(
            EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
          ),
          fixedSize: const MaterialStatePropertyAll(Size.fromWidth(200)),
          elevation: const MaterialStatePropertyAll(4),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        onPressed: navigateTo,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ));
  }
}
