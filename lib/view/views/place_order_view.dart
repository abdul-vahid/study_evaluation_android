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
import 'package:study_evaluation/view/views/result_view.dart';
import 'package:study_evaluation/view/views/signup_success.dart';
import 'package:study_evaluation/view_models/order_list_vm.dart';
import 'package:study_evaluation/view_models/package_list_vm.dart';
import 'package:study_evaluation/view_models/exam_list_vm.dart';
import 'package:study_evaluation/view_models/result_list_vm.dart';
import '../../utils/app_color.dart';
import '../../view_models/order_payment_list_vm.dart';

class PlaceOrderView extends StatefulWidget {
  final String packageId;
  final String amount;

  const PlaceOrderView(
      {super.key, required this.packageId, required this.amount});

  @override
  State<PlaceOrderView> createState() => _PlaceOrderViewState();
}

class _PlaceOrderViewState extends State<PlaceOrderView> {
  UserModel? userModel;
  OrderListViewModel? orderListViewModel;
  @override
  void initState() {
    super.initState();
    Provider.of<OrderListViewModel>(context, listen: false)
        .placeOrder(widget.packageId, widget.amount);
  }

  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    orderListViewModel = Provider.of<OrderListViewModel>(context);
    return Scaffold(
        appBar: AppUtils.getAppbar("Order Placement"),
        body: AppUtils.getAppBody(orderListViewModel!, _getBody,
            context: context));
  }

  SingleChildScrollView _getBody() {
    return const SingleChildScrollView(
        child: Center(
      child: Text("Your order has been placed!"),
    ));
  }
}
