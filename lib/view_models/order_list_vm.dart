import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/core/models/order_response_model.dart';
import 'package:study_evaluation/models/order_model.dart';
import 'package:study_evaluation/models/user_model.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';

class OrderListViewModel extends BaseListViewModel {
  Future<void> fetch({BuildContext? context}) async {
    var userModel =
        AppUtils.getSessionUser(await SharedPreferences.getInstance());

    String url = AppUtils.getUrl(
        "${AppConstants.orderAPIPath}?user_id=${userModel?.id}");
    get(baseModel: OrderModel(), url: url);
  }

  Future<dynamic> placeOrder(String packageId, String amount) async {
    String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserModel? userModel = AppUtils.getSessionUser(prefs);
    String url = AppUtils.getUrl(AppConstants.orderPaymentCreationAPIPath);
    Map<String, String> requestData = {
      'student_id': (userModel?.studentId)!,
      'package_id': packageId,
      'order_number': '2332323',
      'transaction_id': '34345353',
      'order_date': currentDate,
      'amount': amount,
      'payment_status': 'Confirmed',
      'payment_type': 'Online',
      'user_id': (userModel?.id)!
    };
    String body = jsonEncode(requestData);
    postData(url: url, body: body, baseModel: OrderResponseModel());
  }
}
