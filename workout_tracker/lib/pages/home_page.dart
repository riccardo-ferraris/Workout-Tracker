import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workout_tracker/components/app_bar.dart';
import 'package:workout_tracker/components/workout_tile.dart';
import 'package:workout_tracker/firestore_helper.dart';
import 'package:workout_tracker/theme.dart';
import '../components/my_text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  final TextEditingController _workoutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme().backgroundColor,
      appBar: const MyAppBar(
        text: 'Workout Tracker',
        isHomePage: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    backgroundColor: MyTheme().backgroundColor,
                    content: MyTextField(
                      hintText: 'Nome allenamento',
                      obscureText: false,
                      prefixIcon: null,
                      suffixIcon: null,
                      controller: _workoutController,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Chiudi',
                          style: TextStyle(
                              color: MyTheme().detailsColor, fontSize: 18),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          FirestoreHelper().addWorkout(
                              user.email.toString(), _workoutController.text);
                          _workoutController.clear();
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Aggiungi',
                          style: TextStyle(
                              color: MyTheme().detailsColor, fontSize: 18),
                        ),
                      ),
                    ],
                  ));
        },
        backgroundColor: MyTheme().primaryColor,
        child: const Icon(
          Icons.add,
          size: 35,
        ),
      ),
      body: StreamBuilder<List<DocumentSnapshot>>(
          stream: FirestoreHelper().getWorkouts(user.email.toString()),
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
            List<DocumentSnapshot> workouts = snapshot.data!;

            if (workouts.isEmpty) {
              return Center(
                child: Text(
                  'Aggiungi un allenamento!',
                  style: TextStyle(color: MyTheme().detailsColor, fontSize: 23),
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.only(
                  bottom: kFloatingActionButtonMargin + 60),
              itemBuilder: (context, index) =>
                  WorkoutTile(workoutTitle: workouts[index].id),
              itemCount: workouts.length,
            );
          }),
    );
  }
}
