import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workout_tracker/components/app_bar.dart';
import 'package:workout_tracker/components/single_exercise_tile.dart';
import 'package:workout_tracker/firestore_helper.dart';
import 'package:workout_tracker/theme.dart';
import '../components/my_text_field.dart';

class SingleWorkoutPage extends StatelessWidget {
  SingleWorkoutPage({super.key, required this.workoutName});

  final String workoutName;
  final TextEditingController _exerciseController = TextEditingController();
  final TextEditingController _kgController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();
  final TextEditingController _setsController = TextEditingController();
  final TextEditingController _restController = TextEditingController();

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(text: workoutName, isHomePage: false),
      body: StreamBuilder<List<DocumentSnapshot>>(
          stream: FirestoreHelper()
              .getExercises(user.email.toString(), workoutName),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Si è verificato un errore',
                  style: TextStyle(color: MyTheme().detailsColor),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            List<DocumentSnapshot> exercises = snapshot.data!;

            if (exercises.isEmpty) {
              return Center(
                child: Text(
                  'Aggiungi un esercizio!',
                  style: TextStyle(color: MyTheme().detailsColor, fontSize: 23),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.only(
                  bottom: kFloatingActionButtonMargin + 60),
              itemBuilder: (context, index) => SingleExercise(
                name: exercises[index]['Nome'],
                kg: exercises[index]['Kg'],
                sets: exercises[index]['Sets'],
                reps: exercises[index]['Reps'],
                rest: exercises[index]['Rest'],
                workoutName: workoutName,
                timestamp: exercises[index]['timestamp'],
              ),
              itemCount: exercises.length,
            );
          }),
      backgroundColor: MyTheme().backgroundColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: MyTheme().backgroundColor,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MyTextField(
                    hintText: 'Nome esercizio',
                    obscureText: false,
                    prefixIcon: null,
                    suffixIcon: null,
                    controller: _exerciseController,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  MyTextField(
                    keyboardType: TextInputType.number,
                    hintText: 'Kg',
                    obscureText: false,
                    prefixIcon: null,
                    suffixIcon: null,
                    controller: _kgController,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  MyTextField(
                    keyboardType: TextInputType.number,
                    hintText: 'Serie',
                    obscureText: false,
                    prefixIcon: null,
                    suffixIcon: null,
                    controller: _setsController,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  MyTextField(
                    keyboardType: TextInputType.number,
                    hintText: 'Ripetizioni',
                    obscureText: false,
                    prefixIcon: null,
                    suffixIcon: null,
                    controller: _repsController,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  MyTextField(
                    keyboardType: TextInputType.number,
                    hintText: 'Recupero',
                    obscureText: false,
                    prefixIcon: null,
                    suffixIcon: null,
                    controller: _restController,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Chiudi',
                    style:
                        TextStyle(color: MyTheme().detailsColor, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    FirestoreHelper().addExerciseToWorkout(
                      user.email.toString(),
                      workoutName,
                      _exerciseController.text,
                      _kgController.text,
                      _setsController.text,
                      _repsController.text,
                      double.parse(_restController.text),
                    );
                    _exerciseController.clear();
                    _kgController.clear();
                    _setsController.clear();
                    _repsController.clear();
                    _restController.clear();
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Aggiungi',
                    style:
                        TextStyle(color: MyTheme().detailsColor, fontSize: 18),
                  ),
                ),
              ],
            ),
          );
        },
        backgroundColor: MyTheme().detailsColor,
        child: Icon(
          Icons.add,
          size: 35,
          color: MyTheme().primaryColor,
        ),
      ),
    );
  }
}
