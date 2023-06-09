import 'package:flutter/material.dart';
import 'package:workout_tracker/components/app_bar.dart';
import 'package:workout_tracker/theme.dart';

class SingleExercisePage extends StatefulWidget {
  SingleExercisePage({super.key, required this.exerciseName});

  String exerciseName;

  @override
  State<SingleExercisePage> createState() => _SingleExercisePageState();
}

class _SingleExercisePageState extends State<SingleExercisePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(text: '', isHomePage: false),
      backgroundColor: MyTheme().backgroundColor,
      body: Center(
        child: Text(widget.exerciseName),
      ),
    );
  }
}
