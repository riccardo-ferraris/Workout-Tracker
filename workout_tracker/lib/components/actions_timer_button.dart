import 'package:flutter/material.dart';
import 'package:workout_tracker/theme.dart';

class MyActionTimerButton extends StatelessWidget {
  const MyActionTimerButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  final void Function()? onPressed;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(MyTheme().detailsColor),
        iconColor: MaterialStatePropertyAll(MyTheme().primaryColor),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.all(15),
        ),
        shape: MaterialStatePropertyAll(
          CircleBorder(
            side: BorderSide(color: MyTheme().primaryColor),
          ),
        ),
        fixedSize: const MaterialStatePropertyAll(
          Size(60, 60),
        ),
      ),
      onPressed: onPressed,
      child: icon,
    );
  }
}
