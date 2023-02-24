import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/models/package_model/package.dart';
import 'package:study_evaluation/models/package_model/package_model.dart';
import 'package:study_evaluation/models/package_model/result_model.dart';
import 'package:study_evaluation/models/package_model/test_series.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/view/views/result_view.dart';
import 'package:study_evaluation/view_models/package_list_vm.dart';

import '../../utils/app_color.dart';

class PackageDetailView extends StatefulWidget {
  const PackageDetailView({super.key});

  @override
  State<PackageDetailView> createState() => _PackageDetailViewState();
}

class _PackageDetailViewState extends State<PackageDetailView> {
  PackageListViewModel? packageListVM;
  PackageModel? model;
  Package? package;
  @override
  void initState() {
    super.initState();
    //final id = ModalRoute.of(context)!.settings.arguments;
    Provider.of<PackageListViewModel>(context, listen: false)
        .fetchPackageLineItems(2);
  }

  @override
  Widget build(BuildContext context) {
    packageListVM = Provider.of<PackageListViewModel>(context);
    /* if (packageListVM != null) {
      if (packageListVM!.viewModels.isNotEmpty) {
        model = packageListVM!.viewModels[0].model;
        if (model!.isError) {
          print("Error");
          print(packageListVM!.viewModels[0].model.error);
        } else {
          package = model?.package;
        }
      }
    } */

    return Scaffold(
        appBar: AppUtil.getAppbar("Package Detail"),
        body: AppUtil.getAppBody(packageListVM!, _getBody));
  }

  SingleChildScrollView _getBody() {
    model = packageListVM!.viewModels[0].model;
    package = model?.package;
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
      ),
      child: Column(children: [
        _getBuyNowButton(
          'Buy Now',
          onPressed: () {},
        ),

        _getPackageContainer(),
        for (var testSeries in model!.testSeries!)
          _getTestContainer(testSeries),
        //_getContainer3(context),
        //_getContainer4(context),
        //_getContainer5(context),
        const SizedBox(
          height: 10,
        ),
      ]),
    ));
  }

  Expanded _getTestLabelValueExpandedWidget(label, value) {
    return Expanded(
      flex: 2,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        //width: 200,
        //  color: Colors.green,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _getTestLabelValueWidget(label, value),
        ),
      ),
    );
  }

  List<Widget> _getTestLabelValueWidget(label, value) => [
        _getTextWidget(label),
        _getTestValueTextWidget(value),
      ];

  Text _getTestValueTextWidget(value) => Text(
        value,
        style: _getValueTextStyle(),
      );

  Text _getTextWidget(String label) =>
      Text(label, style: _getTextStyleForQuesLabel());

  TextStyle _getTextStyleForQuesLabel() => const TextStyle(
      fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 17);

  TextStyle _getValueTextStyle() {
    return const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15.0,
    );
  }

  Container _getTestContainer(TestSeries? testSeries) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 274,
      child: Card(
        elevation: 5,
        shape: _getTestShape(),
        child: Column(
          children: [
            Row(
              children: [
                _getTestTypeContainer(testSeries),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  height: 35,
                  width: 250,
                  decoration: BoxDecoration(
                    color: AppColor.containerBoxColor,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)),
                  ),
                  child: _getScheduleContainer(testSeries?.scheduledDate),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            _getTestTitleContainer(testSeries?.title),
            Divider(
              color: Colors.grey.shade300,
            ),
            _getQuestionInfoContainer(testSeries),
            Divider(
              color: Colors.grey.shade300,
            ),
            _getQuestionInfoButtons(testSeries?.result),
            Container(
              height: 10,
              decoration: BoxDecoration(
                color: AppColor.containerBoxColor,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _getQuestionInfoButtons(ResultModel? resultModel) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: _getButtons(resultModel),
      ),
    );
  }

  List<Widget> _getButtons(ResultModel? resultModel) {
    List<Widget> widgets = [];

    if (resultModel?.resultStatus == "In Progress") {
      widgets.add(AppUtil().getElevatedButton('Resume',
          onPressed: () {},
          buttonStyle: ElevatedButton.styleFrom(
            backgroundColor: AppColor.buttonColor, // foreground
          )));
    }
    if (resultModel?.resultStatus == "Complete") {
      widgets.add(AppUtil().getElevatedButton(
        'Re-Attempt',
        textStyle: const TextStyle(color: Colors.black),
        buttonStyle: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFfef5e6) // foreground
            ),
        onPressed: () {},
      ));
      widgets.add(AppUtil().getElevatedButton(
        'Result',
        buttonStyle: ElevatedButton.styleFrom(
            backgroundColor: AppColor.buttonColor // foreground
            ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ResultView()),
          );
        },
      ));
    }

    if (resultModel == null) {
      widgets.add(AppUtil().getElevatedButton('Start Now',
          onPressed: () {},
          buttonStyle: ElevatedButton.styleFrom(
              backgroundColor: AppColor.buttonColor // foreground
              )));
    }

    widgets.add(const SizedBox(
      width: 10,
    ));
    return widgets;
  }

  Padding _getQuestionInfoContainer(TestSeries? testSeries) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: _getTestQuestionDetailWidget(testSeries),
          ),
        ],
      ),
    );
  }

  Padding _getTestTitleContainer(title) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          child: _getTestTitle(title),
        ),
      ),
    );
  }

  Text _getTestTitle(title) {
    return Text(title,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.grey,
            letterSpacing: 1));
  }

  Center _getScheduleContainer(dateTime) {
    //'2 February 10:00 AM'
    return Center(
        child: Text(
      dateTime,
      style: const TextStyle(color: Colors.white),
    ));
  }

  Padding _getTestTypeContainer(TestSeries? testSeries) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Text((testSeries?.type)!,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: AppColor.textColor))),
    );
  }

  RoundedRectangleBorder _getTestShape() {
    return RoundedRectangleBorder(
      side: BorderSide(
        color: Theme.of(context).colorScheme.outline,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
    );
  }

  Container _getPackageContainer() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 450,
      child: Card(
        elevation: 5,
        shape: _getShape(context),
        child: Column(
          children: [
            Container(
              height: 10,
              decoration: _getBoxDecoration(),
            ),
            const SizedBox(
              height: 20,
            ),
            _getImageContainer(package?.logoUrl),
            _getPackageTitleContainer(package?.title),
            _getPackageLabelValueContainer(
                'Price', '₹${package?.originalPrice} [₹${package?.listPrice}]'),
            Divider(
              color: Colors.grey.shade300,
            ),
            _getPackageDescriptionContainer(),
            _getPackageLabelValueContainer('Validity', package?.validity),
          ],
        ),
      ),
    );
  }

  Padding _getPackageDescriptionContainer() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          (package?.description)!,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
          maxLines: 15,
        ),
      ),
    );
  }

  Padding _getPackageLabelValueContainer(label, value) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Row(
          children: _getPackageComponents(label, value),
        ),
      ),
    );
  }

  List<Widget> _getPackageComponents(label, value) {
    return [
      Text(label,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xFFc78f8f))),
      const SizedBox(
        width: 5,
      ),
      Text(value,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black)),
    ];
  }

  Padding _getPackageTitleContainer(title) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, letterSpacing: 1)),
      ),
    );
  }

  Padding _getImageContainer(logoUrl) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,

        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(AppUtil.getImageUrl(logoUrl)),
          fit: BoxFit.fill,
        )),
        //  color: Color.fromARGB(255, 209, 208, 210),
      ),
    );
  }

  BoxDecoration _getBoxDecoration() {
    return BoxDecoration(
      color: AppColor.containerBoxColor,
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(8.0), topLeft: Radius.circular(8.0)),
    );
  }

  RoundedRectangleBorder _getShape(BuildContext context) {
    return RoundedRectangleBorder(
      side: BorderSide(
        color: Theme.of(context).colorScheme.outline,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
    );
  }

  Align _getBuyNowButton(btnLabel, {required void Function()? onPressed}) {
    return Align(
        alignment: Alignment.bottomRight,
        child: AppUtil().getElevatedButton(
          btnLabel,
          onPressed: onPressed,
        ));
  }

  List<Widget> _getTestQuestionDetailWidget(TestSeries? testSeries) => [
        _getTestLabelValueExpandedWidget(
            "Question", testSeries?.totalQuestions),
        _getTestLabelValueExpandedWidget("Duration", testSeries?.duration),
        _getTestLabelValueExpandedWidget("Marks", "150"),
      ];
}
