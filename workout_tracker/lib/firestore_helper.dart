import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  Future addWorkout(String email, String workoutName) async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .collection('Workouts')
        .doc(workoutName)
        .set({'nome': workoutName});
  }

  Future addExerciseToWorkout(
    String email,
    String workoutName,
    String exerciseName,
    int kg,
    int sets,
    int reps,
    int rest,
  ) async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .collection('Workouts')
        .doc(workoutName)
        .collection('Exercises')
        .doc(exerciseName)
        .set(
      {
        'Nome': exerciseName,
        'Kg': kg,
        'Sets': sets,
        'Reps': reps,
        'Rest': rest,
        'isCompleted': false,
        'timestamp': FieldValue.serverTimestamp(),
      },
    );
  }

  Stream<List<DocumentSnapshot>> getExercises(
      String email, String workoutName) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .collection('Workouts')
        .doc(workoutName)
        .collection('Exercises')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((QuerySnapshot snapshot) => snapshot.docs);
  }

  Stream<List<DocumentSnapshot>> getWorkouts(String email) {
    return FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .collection('Workouts')
        .snapshots()
        .map((QuerySnapshot snapshot) => snapshot.docs);
  }

  Future deleteExercise(
      String email, String workoutName, String exerciseName) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .collection('Workouts')
        .doc(workoutName)
        .collection('Exercises')
        .doc(exerciseName)
        .delete();
  }

  Future deleteWorkout(String email, String workoutName) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .collection('Workouts')
        .doc(workoutName)
        .delete();
  }

  Future modifyExercise(
    String email,
    String workoutName,
    String exerciseName,
    String newExerciseName,
    int kg,
    int sets,
    int reps,
    int rest,
    timestamp,
  ) async {
    deleteExercise(email, workoutName, exerciseName);
    FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .collection('Workouts')
        .doc(workoutName)
        .collection('Exercises')
        .doc(newExerciseName)
        .set(
      {
        'Nome': newExerciseName,
        'Kg': kg,
        'Sets': sets,
        'Reps': reps,
        'Rest': rest,
        'isCompleted': false,
        'timestamp': timestamp,
      },
    );
  }

  Future modifyIsCompleted(
    String email,
    String workoutName,
    String exerciseName,
    int kg,
    int sets,
    int reps,
    int rest,
    timestamp,
    bool isCompleted,
  ) async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(email)
        .collection('Workouts')
        .doc(workoutName)
        .collection('Exercises')
        .doc(exerciseName)
        .set(
      {
        'Nome': exerciseName,
        'Kg': kg,
        'Sets': sets,
        'Reps': reps,
        'Rest': rest,
        'isCompleted': isCompleted,
        'timestamp': timestamp,
      },
    );
  }
}
