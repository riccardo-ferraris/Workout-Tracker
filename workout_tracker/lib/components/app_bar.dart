import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final bool isHomePage;

  const MyAppBar({
    super.key,
    required this.text,
    required this.isHomePage,
  });

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: MyTheme().backgroundColor,
        title: Text(
          text,
          style: TextStyle(
              color: MyTheme().detailsColor,
              fontSize: 23,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          if (isHomePage)
            IconButton(
              onPressed: signUserOut,
              icon: const Icon(Icons.logout),
              color: MyTheme().detailsColor,
              iconSize: 27,
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
