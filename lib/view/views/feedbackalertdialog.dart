import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/utils/app_color.dart';
import 'package:study_evaluation/utils/app_utils.dart';

class FeedbackAlertDialog extends StatefulWidget {
  const FeedbackAlertDialog({super.key});

  @override
  State<FeedbackAlertDialog> createState() => _FeedbackAlertDialogState();
}

class _FeedbackAlertDialogState extends State<FeedbackAlertDialog> {
  final List<String> _subject = [
    'Select Subject',
    'Your Review',
    'App Related Issues',
    'Payment Related Issues',
    'Other'
  ]; // Option 2
  TextEditingController textarea = TextEditingController();

  String? _selectedSubject; // Option 2
  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      var userModel = AppUtils.getSessionUser(prefs);
      userModel ?? AppUtils.logout(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    return Dialog(
      elevation: 0,
      backgroundColor: const Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 50,
            color: AppColor.containerBoxColor,
            child: const Center(
                child: Text(
              'FeedBack',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            )),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Select Reason',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.grey,
                        letterSpacing: 1)),
              ),
              const SizedBox(
                height: 10,
              ),
              InputDecorator(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: const Text('Select Subject'),
                    // Not necessary for Option 1
                    value: _selectedSubject,
                    isDense: true,
                    isExpanded: true,
                    menuMaxHeight: 350,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedSubject = newValue;
                      });
                    },
                    items: _subject.map((state) {
                      return DropdownMenuItem(
                        value: state,
                        child: Text(state),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: textarea,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Write Message....",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.buttonColor,
                  ),
                  onPressed: () {},
                  child: const Text("Sumbmit"))
            ]),
          ),
        ],
      ),
    );
  }
}
