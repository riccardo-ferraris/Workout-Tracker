import 'package:flutter/material.dart';
import 'package:workout_tracker/theme.dart';

class MyTimerButton extends StatelessWidget {
  const MyTimerButton({super.key, required this.text, required this.onPressed});

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextButton(
        style: ButtonStyle(
          elevation: const MaterialStatePropertyAll(5),
          backgroundColor: MaterialStatePropertyAll(MyTheme().primaryColor),
          padding: const MaterialStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: MyTheme().detailsColor,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
