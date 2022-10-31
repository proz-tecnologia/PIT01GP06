import 'package:flutter/material.dart';
import 'package:projeto_final_flutter/theme/global/colors.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({super.key, this.onPressed, required this.icon, required this.text});

  final VoidCallback? onPressed;
  final Icon icon;
  final String text;

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          color: MyColor.ltPrimaryColor,
          elevation: 4,
          child: 
              IconButton(
                onPressed: onPressed,
                icon: icon
              ),
          ),
          const SizedBox(height: 10,),
          Text(text, style: const TextStyle(fontWeight: FontWeight.bold),)
      ],
    ); 
  }
}