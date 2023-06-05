import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:workout_tracker/firestore_helper.dart';
import '../theme.dart';
import 'my_text_field.dart';

class SingleExercise extends StatefulWidget {
  SingleExercise({
    super.key,
    required this.name,
    required this.kg,
    required this.sets,
    required this.reps,
    required this.rest,
    required this.workoutName,
    required this.timestamp,
  });

  final String name;
  final String kg;
  final String sets;
  final String reps;
  final String rest;
  final String workoutName;
  final dynamic timestamp;
  final user = FirebaseAuth.instance.currentUser!;

  final TextEditingController _exerciseController = TextEditingController();
  final TextEditingController _kgController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();
  final TextEditingController _setsController = TextEditingController();
  final TextEditingController _restController = TextEditingController();

  @override
  State<SingleExercise> createState() => _SingleExerciseState();
}

class _SingleExerciseState extends State<SingleExercise> {
  bool? isChecked = false;

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
              icon: Icons.settings,
              onPressed: (BuildContext context) {
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
                          controller: widget._exerciseController,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        MyTextField(
                          hintText: 'Kg',
                          obscureText: false,
                          prefixIcon: null,
                          suffixIcon: null,
                          controller: widget._kgController,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        MyTextField(
                          hintText: 'Serie',
                          obscureText: false,
                          prefixIcon: null,
                          suffixIcon: null,
                          controller: widget._setsController,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        MyTextField(
                          hintText: 'Ripetizioni',
                          obscureText: false,
                          prefixIcon: null,
                          suffixIcon: null,
                          controller: widget._repsController,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        MyTextField(
                          hintText: 'Recupero',
                          obscureText: false,
                          prefixIcon: null,
                          suffixIcon: null,
                          controller: widget._restController,
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
                          style: TextStyle(
                              color: MyTheme().detailsColor, fontSize: 18),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          FirestoreHelper().modifyExercise(
                            widget.user.email.toString(),
                            widget.workoutName,
                            widget.name,
                            widget._exerciseController.text,
                            widget._kgController.text,
                            widget._setsController.text,
                            widget._repsController.text,
                            widget._restController.text,
                            widget.timestamp,
                          );

                          widget._exerciseController.clear();
                          widget._kgController.clear();
                          widget._setsController.clear();
                          widget._repsController.clear();
                          widget._restController.clear();
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Modifica',
                          style: TextStyle(
                              color: MyTheme().detailsColor, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                );
              },
              backgroundColor: Colors.grey,
            ),
            SlidableAction(
              icon: Icons.delete,
              onPressed: (BuildContext context) {
                FirestoreHelper().deleteExercise(widget.user.email.toString(),
                    widget.workoutName, widget.name);
              },
              backgroundColor: Colors.red,
            ),
          ]),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            title: Text(
              widget.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Wrap(
              children: [
                if (widget.kg != '')
                  Chip(
                    label: Text('${widget.kg}kg'),
                    backgroundColor: MyTheme().terziaryColor,
                  ),
                const SizedBox(
                  width: 5,
                ),
                if (widget.sets != '')
                  Chip(
                    label: Text('${widget.sets} sets'),
                    backgroundColor: MyTheme().terziaryColor,
                  ),
                const SizedBox(
                  width: 5,
                ),
                if (widget.reps != '')
                  Chip(
                    label: Text('${widget.reps} reps'),
                    backgroundColor: MyTheme().terziaryColor,
                  ),
                const SizedBox(
                  width: 5,
                ),
                if (widget.rest != '')
                  Chip(
                    label: Text('${widget.rest} mins'),
                    backgroundColor: MyTheme().terziaryColor,
                  ),
              ],
            ),
            trailing: Checkbox(
                checkColor: MyTheme().detailsColor,
                activeColor: Colors.green,
                value: isChecked,
                onChanged: (newValue) {
                  setState(() {
                    isChecked = newValue;
                  });
                  FirestoreHelper().modifyIsCompleted(
                    widget.user.email.toString(),
                    widget.workoutName,
                    widget.name,
                    widget.kg,
                    widget.sets,
                    widget.reps,
                    widget.rest,
                    widget.timestamp,
                    isChecked!,
                  );
                }),
            textColor: MyTheme().detailsColor,
            tileColor: MyTheme().primaryColor,
          ),
        ),
      ),
    );
  }
}
