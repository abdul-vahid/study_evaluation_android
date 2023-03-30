import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TimerWidget extends StatefulWidget {
  Duration duration;
  void Function(String value) callBack;
  void Function({String status, String timerUP}) onSubmit;
  TimerWidget(
      {super.key,
      required this.duration,
      required this.callBack,
      required this.onSubmit});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Timer? countdownTimer;
  String hours = "0";
  String minutes = "0";
  String seconds = "0";
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "$hours:$minutes:$seconds",
      style: const TextStyle(color: Colors.white),
    );
  }

  void startTimer() {
    if (countdownTimer != null) {
    } else {
      countdownTimer ??=
          Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
    }
  }

  void stopTimer() {
    if (mounted) {
      setState(() => countdownTimer!.cancel());
    }
  }

  // Step 6
  void setCountDown() {
    const reduceSecondsBy = 1;

    final seconds1 = widget.duration.inSeconds - reduceSecondsBy;
    if (seconds1 < 0) {
      //timeUP = "Time UP!";
      stopTimer();
      widget.onSubmit(timerUP: "Timer UP!");
    } else {
      widget.duration = Duration(seconds: seconds1);
    }
    //print("$seconds1 == ${myDuration!.inSeconds}");
    if (mounted) {
      setState(() {
        String strDigits(int n) => n.toString().padLeft(2, '0');
        hours = strDigits(widget.duration.inHours.remainder(24));
        minutes = strDigits(widget.duration.inMinutes.remainder(60));
        seconds = strDigits(widget.duration.inSeconds.remainder(60));
        widget.callBack(timerText);
      });
    }
  }

  String get timerText {
    return '$hours:$minutes:$seconds';
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }
}
