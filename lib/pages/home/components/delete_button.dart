import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: null,
      child: Text(
        'Excluir',
        style: TextStyle(color: Color(0xff33272A)),
      ),
    );
  }
}
