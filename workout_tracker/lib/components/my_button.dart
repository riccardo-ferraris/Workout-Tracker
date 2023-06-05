import 'package:flutter/material.dart';

import '../theme.dart';

class MyButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;

  const MyButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(10),
          side: const MaterialStatePropertyAll(
            BorderSide(
              width: 1,
              color: Colors.black,
            ),
          ),
          shape: const MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(7),
              ),
            ),
          ),
          backgroundColor: MaterialStatePropertyAll(
            MyTheme().primaryColor,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: MyTheme().detailsColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
