import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/models/package_model/package.dart';
import 'package:study_evaluation/models/package_model/package_model.dart';
import 'package:study_evaluation/models/package_model/result_model.dart';
import 'package:study_evaluation/models/package_model/test_series.dart';
import 'package:study_evaluation/models/user_model.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/utils/function_lib.dart';
import 'package:study_evaluation/view/views/exam_view.dart';
import 'package:study_evaluation/view/views/place_order_view.dart';
import 'package:study_evaluation/view/views/result_view.dart';
import 'package:study_evaluation/view/views/signup_success.dart';
import 'package:study_evaluation/view_models/order_list_vm.dart';
import 'package:study_evaluation/view_models/package_list_vm.dart';
import 'package:study_evaluation/view_models/exam_list_vm.dart';
import 'package:study_evaluation/view_models/result_list_vm.dart';
import '../../utils/app_color.dart';
import '../../view_models/order_payment_list_vm.dart';

class PackageDetailView extends StatefulWidget {
  final String packageLineItemId;

  const PackageDetailView({super.key, required this.packageLineItemId});

  @override
  State<PackageDetailView> createState() => _PackageDetailViewState();
}

class _PackageDetailViewState extends State<PackageDetailView> {
  UserModel? userModel;
  PackageListViewModel? packageListVM;
  PackageModel? model;
  Package? package;
  String? _selectedFont = "15";
  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      userModel = AppUtils.getSessionUser(prefs);
      debug("userrole = ${userModel?.role}");
    });

    super.initState();
    //final id = ModalRoute.of(context)!.settings.arguments;
    Provider.of<PackageListViewModel>(context, listen: false)
        .fetchPackageLineItems(widget.packageLineItemId);
  }

  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    packageListVM = Provider.of<PackageListViewModel>(context);
    return Scaffold(
        appBar: AppUtils.getAppbar("Package Detail"),
        body: AppUtils.getAppBody(packageListVM!, _getBody, context: context));
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
        userModel?.role?.toLowerCase() == "student" &&
                package?.validityStatus != "purchased"
            ? _getBuyNowButton(
                'Buy Now',
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MultiProvider(
                                providers: [
                                  ChangeNotifierProvider(
                                      create: (context) => OrderListViewModel())
                                ],
                                child: PlaceOrderView(
                                  packageId: (package?.id)!,
                                  amount: (package?.listPrice)!,
                                ),
                              )));
                },
              )
            : Container(),

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
            _getQuestionInfoButtons(testSeries!),
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

  Padding _getQuestionInfoButtons(TestSeries testSeries) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: _getButtons(testSeries),
      ),
    );
  }

  List<Widget> _getButtons(TestSeries testSeries) {
    List<Widget> widgets = [];
    ResultModel? resultModel = testSeries.result;
    if (resultModel?.resultStatus == ResultStatus.inProgress) {
      widgets.add(AppUtils.getElevatedButton('Resume',
          onPressed: () => _submitPage(testSeries),
          buttonStyle: ElevatedButton.styleFrom(
            backgroundColor: AppColor.buttonColor, // foreground
          )));
    }
    if (resultModel?.resultStatus == ResultStatus.completed) {
      widgets.add(AppUtils.getElevatedButton(
        'Re-Attempt',
        textStyle: const TextStyle(color: Colors.black),
        buttonStyle: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFfef5e6) // foreground
            ),
        onPressed: () => _submitPage(testSeries, reAttempt: true),
      ));
      widgets.add(AppUtils.getElevatedButton(
        'Result',
        buttonStyle: ElevatedButton.styleFrom(
            backgroundColor: AppColor.buttonColor // foreground
            ),
        onPressed: () {
          AppUtils.viewPush(
              context,
              MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (_) => ResultListViewModel(),
                    )
                  ],
                  child: ResultView(
                      resultId: (testSeries.result?.id)!,
                      userId: (userModel?.id)!)));
        },
      ));
    }

    if (resultModel == null) {
      var scheduleDT = DateFormat('dd-MM-yyyy HH:mm aaa')
          .parse((model?.testSeries?[0].scheduledDate)!);

      var currentDT = DateTime.now();
      AppUtils.printDebug("$currentDT ==== $scheduleDT");
      if (currentDT.compareTo(scheduleDT) > 0) {
        widgets.add(AppUtils.getElevatedButton('Start Now',
            onPressed: () => _submitPage(testSeries),
            buttonStyle: ElevatedButton.styleFrom(
                backgroundColor: AppColor.buttonColor // foreground
                )));
      }
    }

    widgets.add(const SizedBox(
      width: 10,
    ));
    return widgets;
  }

  void _submitPage(testSeries, {bool reAttempt = false}) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (_) => ExamListViewModel())
                  ],
                  child: ExamView(
                    examId: testSeries.examId ?? "",
                    userId: (userModel?.id)!,
                    reAttempt: reAttempt,
                  ))),
    ).then((value) {
      if (value == "reload") {
        Provider.of<PackageListViewModel>(context, listen: false)
            .fetchPackageLineItems(widget.packageLineItemId);
        packageListVM =
            Provider.of<PackageListViewModel>(context, listen: false);
      }
    });
  }

  void onPressed(examId) {
    AppUtils.viewPush(
        context,
        MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => ExamListViewModel())
            ],
            child: ExamView(
              examId: examId,
              userId: (userModel?.studentId)!,
            )));
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
      constraints: const BoxConstraints(
        maxHeight: double.infinity,
      ),
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
            _getPackagePriceContainer('Price', '₹${package?.listPrice}',
                '₹${package?.originalPrice}'),
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
        child: AppUtils.getHtmlData(package?.description,
            fontFamily: 'Kruti',
            fontSize: double.tryParse(
                _selectedFont!)!) /* Text(
          (package?.description)!,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
        ) */
        ,
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

  Padding _getPackagePriceContainer(label, listPrice, originalPrice) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Row(children: [
          Text(label,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xFFc78f8f))),
          const SizedBox(
            width: 5,
          ),
          Text(listPrice,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black)),
          const SizedBox(
            width: 3,
          ),
          Text(originalPrice,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  decoration: TextDecoration.lineThrough,
                  color: Colors.black))
        ]),
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
          image: NetworkImage(AppUtils.getImageUrl(logoUrl)),
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
        child: AppUtils.getElevatedButton(
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
