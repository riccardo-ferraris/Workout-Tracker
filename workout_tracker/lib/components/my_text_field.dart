import 'package:flutter/material.dart';

import '../theme.dart';

class MyTextField extends StatelessWidget {
  final dynamic controller;
  final String hintText;
  final bool obscureText;
  final dynamic prefixIcon;
  final dynamic suffixIcon;
  final TextInputType? keyboardType;
  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.prefixIcon,
    required this.suffixIcon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText ? true : false,
      decoration: InputDecoration(
        filled: true,
        fillColor: MyTheme().secondaryColor,
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: MyTheme().primaryColor,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(7),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyTheme().terziaryColor),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
