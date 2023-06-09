import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class MyCircularTimer extends StatefulWidget {
  const MyCircularTimer({
    super.key,
    required this.time,
    required this.countdownController,
  });

  final double time;
  final CountDownController countdownController;

  @override
  State<MyCircularTimer> createState() => _MyCircularTimerState();
}

class _MyCircularTimerState extends State<MyCircularTimer> {
  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 3,
      duration: widget.time.toInt(),
      fillColor: MyTheme().terziaryColor,
      ringColor: MyTheme().primaryColor,
      isReverse: true,
      autoStart: false,
      controller: widget.countdownController,
      strokeWidth: 10.0,
      strokeCap: StrokeCap.round,
      textStyle: TextStyle(
        color: MyTheme().detailsColor,
        fontSize: 40,
      ),
      textFormat: CountdownTextFormat.MM_SS,
      timeFormatterFunction: (defaultFormatterFunction, duration) {
        if (duration.inSeconds == 0) {
          return "Allenati";
        } else {
          return Function.apply(defaultFormatterFunction, [duration]);
        }
      },
    );
  }
}
