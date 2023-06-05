import 'package:flutter/material.dart';
import '../theme.dart';

class Hyperlink extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const Hyperlink({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: MyTheme().detailsColor,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
