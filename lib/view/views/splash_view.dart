import 'dart:async';

import 'package:flutter/material.dart';
import 'package:study_evaluation/view/views/login_home.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return initScreen(context);
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginHome()));
  }

  initScreen(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColor.buttonColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 100,
                height: 100,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/images/logo.jpg",
                      fit: BoxFit.contain,
                    ))),
            // const Padding(padding: EdgeInsets.only(top: 20.0)),
            // const CircularProgressIndicator(
            //   backgroundColor: AppColor.buttonColor,
            //   strokeWidth: 2,
            // )
          ],
        ),
      ),
    );
  }
}