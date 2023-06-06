import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:workout_tracker/components/actions_timer_button.dart';
import 'package:workout_tracker/components/app_bar.dart';
import 'package:workout_tracker/components/circular_timer.dart';

import 'package:workout_tracker/theme.dart';

class MyTimer extends StatefulWidget {
  const MyTimer({super.key, required this.time});

  final int time;

  @override
  State<MyTimer> createState() => _MyTimerState();
}

class _MyTimerState extends State<MyTimer> {
  final CountDownController _countdownController = CountDownController();
  bool isRunning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        text: 'Timer',
        isHomePage: false,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: MyTheme().backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyCircularTimer(
                time: widget.time,
                countdownController: _countdownController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        MyActionTimerButton(
                          onPressed: () {
                            setState(() {
                              _countdownController.start();
                              isRunning = true;
                            });
                          },
                          icon: const Icon(Icons.play_arrow),
                        ),
                        Text(
                          'Avvia',
                          style: TextStyle(
                            color: MyTheme().detailsColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        MyActionTimerButton(
                          onPressed: () {
                            setState(() {
                              _countdownController.pause();
                              isRunning = false;
                            });
                          },
                          icon: const Icon(Icons.pause),
                        ),
                        Text(
                          'Pausa',
                          style: TextStyle(
                            color: MyTheme().detailsColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        MyActionTimerButton(
                          onPressed: () {
                            setState(() {
                              _countdownController.resume();
                              isRunning = true;
                            });
                          },
                          icon: const Icon(Icons.skip_next),
                        ),
                        Text(
                          'Riprendi',
                          style: TextStyle(
                            color: MyTheme().detailsColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        MyActionTimerButton(
                          onPressed: () {
                            setState(() {
                              _countdownController.reset();
                              isRunning = false;
                            });
                          },
                          icon: const Icon(
                              Icons.settings_backup_restore_outlined),
                        ),
                        Text(
                          'Reset',
                          style: TextStyle(
                            color: MyTheme().detailsColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
