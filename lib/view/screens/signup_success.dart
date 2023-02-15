import 'package:flutter/material.dart';

class SignupSuccess extends StatelessWidget {
  const SignupSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Signup Success"),
      ),
      body: const Center(
        child: Text("Signup Completed, Please login to continue."),
      ),
    );
  }
}
