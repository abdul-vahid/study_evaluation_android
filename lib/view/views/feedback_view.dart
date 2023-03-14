import 'package:flutter/material.dart';
import 'package:study_evaluation/utils/app_color.dart';
import 'package:study_evaluation/view_models/feedback_list_vm.dart';
import '../../models/feedback_model.dart';
import '../../utils/app_utils.dart';
import '../../utils/validator_util.dart';

class FeedbackView extends StatefulWidget {
  const FeedbackView({super.key});

  @override
  State<FeedbackView> createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
  final List<String> _subject = [
    'Select Review',
    'Review',
    'App Issue',
    'Payment Issue',
    'Other'
  ];
  TextEditingController textarea = TextEditingController();
  String? _selectedReason;
  String? _message;
  final GlobalKey<FormState> _feedbackFormKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _dropdownKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: const BackButton(color: Colors.white),
          title: const Text("Feedback"),
          elevation: .1,
          backgroundColor: AppColor.appBarColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _feedbackFormKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Select Reason',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.grey,
                                letterSpacing: 1)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      _getDropdown(),
                      const SizedBox(
                        height: 20,
                      ),
                      _getMessageTextBox(),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.buttonColor,
                          ),
                          onPressed: () {
                            onButtonPressed();
                          },
                          child: const Text("Sumbmit"))
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  TextFormField _getMessageTextBox() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 10,
      validator: validateFeedbackForm,
      onSaved: ((value) {
        _message = value;
      }),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Write Message....",
      ),
    );
  }

  DropdownButtonHideUnderline _getDropdown() {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<String>(
        key: _dropdownKey,
        decoration: const InputDecoration(border: OutlineInputBorder()),
        hint: const Text('Select Reason'),
        value: _selectedReason,
        isDense: true,
        isExpanded: false,
        menuMaxHeight: 350,
        validator: (value) => value == null ? 'Required' : null,
        onChanged: (newValue) {
          setState(() {
            _selectedReason = newValue;
          });
        },
        items: _subject.map((state) {
          return DropdownMenuItem(
            value: state,
            child: Text(state),
          );
        }).toList(),
      ),
    );
  }

  void onButtonPressed() {
    if (_feedbackFormKey.currentState!.validate()) {
      AppUtils.onLoading(context, "Please wait...");
      _feedbackFormKey.currentState!.save();

      FeedbackModel feedbackModel = FeedbackModel(
        studentId: "152",
        reason: _selectedReason,
        comment: _message,
        status: "Inactive",
      );
      submitFeedback(feedbackModel);
    }
  }

  void submitFeedback(FeedbackModel feedbackModel) {
    AppUtils.getLoader();
    FeedbackListViewModel().submitFeedback(feedbackModel).then((value) {
      Navigator.pop(context);
      setState(() {
        _feedbackFormKey.currentState?.reset();
        _dropdownKey.currentState?.reset();
        _selectedReason = null;
      });

      AppUtils.getAlert(context, ["Feedback Submitted Successfull!"],
          title: "Feedback Alert");
      //Navigator.push(
      //  context, MaterialPageRoute(builder: (context) => const HomeView()));
    }).catchError((onError) {
      Navigator.pop(context);
      List<String> errorMessages = AppUtils.getErrorMessages(onError);
      AppUtils.getAlert(context, errorMessages, title: "Error Alert");
    });

    //   _message = '';
  }
}
