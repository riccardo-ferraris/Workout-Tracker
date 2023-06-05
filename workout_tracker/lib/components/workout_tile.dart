import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:workout_tracker/firestore_helper.dart';
import 'package:workout_tracker/theme.dart';
import '../pages/single_workout_page.dart';

class WorkoutTile extends StatelessWidget {
  WorkoutTile({super.key, required this.workoutTitle});

  final user = FirebaseAuth.instance.currentUser!;
  final String workoutTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      child: Card(
        elevation: 10,
        clipBehavior: Clip.hardEdge,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: MyTheme().secondaryColor),
        ),
        child: Slidable(
          endActionPane: ActionPane(motion: const ScrollMotion(), children: [
            SlidableAction(
              icon: Icons.delete,
              onPressed: (BuildContext context) {
                FirestoreHelper()
                    .deleteWorkout(user.email.toString(), workoutTitle);
              },
              backgroundColor: Colors.red,
            ),
          ]),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            leading: SizedBox(
                height: double.infinity,
                child: Image.asset(
                  'assets/icons/dumbbell.png',
                  scale: 14,
                )),
            title: Text(
              workoutTitle.toUpperCase(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: GestureDetector(
              child: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        SingleWorkoutPage(workoutName: workoutTitle),
                  ),
                );
              },
            ),
            iconColor: MyTheme().detailsColor,
            textColor: MyTheme().detailsColor,
            tileColor: MyTheme().primaryColor,
          ),
        ),
      ),
    );
  }
}
