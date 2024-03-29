
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


void showToast(String message) {
  bool isActive = true;
  if(isActive) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[800],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

void cancelToast() {
  Fluttertoast.cancel();
}


