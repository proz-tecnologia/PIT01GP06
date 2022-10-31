import 'package:flutter/material.dart';

import '../../../theme/global/colors.dart';

class EditButton extends StatelessWidget {
  final String title;
  final BuildContext context;
  final Widget page;

  const EditButton({
    Key? key,
    required this.title,
    required this.context,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => page,
              ));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColor.ltPrimaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ),
    );
  }
}
