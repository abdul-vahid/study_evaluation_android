// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user_model.dart';
import '../../utils/app_utils.dart';
import '../../view_models/order_list_vm.dart';

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
    return SingleChildScrollView(
        child: Center(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 400,
              width: 400,
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  CircleAvatar(
                    child: Icon(
                      Icons.check_circle_rounded,
                      color: Colors.white,
                      size: 120,
                    ),
                    radius: 60,
                    backgroundColor: Colors.green,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Thank You!',
                      style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: Colors.green)),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Your order has been placed!',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
