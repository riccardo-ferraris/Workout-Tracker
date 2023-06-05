import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workout_tracker/auth.dart';
import 'package:workout_tracker/components/hyperlinks.dart';
import 'package:workout_tracker/components/my_button.dart';
import 'package:workout_tracker/components/my_text_field.dart';
import 'package:workout_tracker/theme.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isObscured = true;
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await Auth().signUserIn(
        email: _controllerEmail.text.trim(),
        password: _controllerPassword.text.trim(),
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      }
    }
  }

  void createUser() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    await Auth().createUser(
      email: _controllerEmail.text.trim(),
      password: _controllerPassword.text.trim(),
    );

    Navigator.pop(context);
  }

  void wrongEmailMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Email errata'),
          );
        });
  }

  void wrongPasswordMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Password errata'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme().backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/icons/weightlifter.png',
                  scale: 2,
                ),
                const SizedBox(
                  height: 100,
                ),
                Column(
                  children: [
                    MyTextField(
                      controller: _controllerEmail,
                      hintText: 'Email',
                      obscureText: false,
                      prefixIcon: const Icon(Icons.email),
                      suffixIcon: null,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    MyTextField(
                      controller: _controllerPassword,
                      hintText: 'Password',
                      obscureText: isObscured,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: GestureDetector(
                        child: isObscured
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onTap: () {
                          setState(
                            () {
                              isObscured = !isObscured;
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    isLogin
                        ? MyButton(
                            onPressed: signUserIn,
                            text: 'L O G I N',
                          )
                        : MyButton(
                            onPressed: createUser, text: 'R E G I S T R A T I'),
                    const SizedBox(
                      height: 10,
                    ),
                    isLogin
                        ? Hyperlink(
                            text: 'Non hai un account? Registrati!',
                            onTap: () {
                              setState(() {
                                isLogin = !isLogin;
                              });
                            },
                          )
                        : Hyperlink(
                            text: 'Hai già un account? Accedi!',
                            onTap: () {
                              setState(() {
                                isLogin = !isLogin;
                              });
                            }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
