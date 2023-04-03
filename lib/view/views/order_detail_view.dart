import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/view/views/package_detail_view.dart';

import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';
import '../../view_models/package_list_vm.dart';

class OrderDetailView extends StatefulWidget {
  final myOrder;
  const OrderDetailView({super.key, required this.myOrder});

  @override
  State<OrderDetailView> createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
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
    return Scaffold(
      appBar: AppUtils.getAppbar("Order Detail",
          leading: const BackButton(
            color: Colors.white,
          )),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    getColumn('Package Title', widget.myOrder.packagesTitle),
                    getColumn('Package Name', widget.myOrder.name),
                    getColumn('Order Amount', widget.myOrder.amount),
                    getColumn('Order Number', widget.myOrder.orderNumber),
                    getColumn('Order Date', widget.myOrder.createdDate),
                    getColumn('Expiry Date', widget.myOrder.expiryDate),
                    getColumn('Payment Types', widget.myOrder.paymentType),
                    getColumn('Payment Status', widget.myOrder.paymentStatus),
                    getColumn('Validity', widget.myOrder.validity),
                    getColumn('Status', widget.myOrder.status),
                    getButton(),
                  ],
                ),
              )
            ]),
      ),
    );
  }

  Padding getButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFfef5e6),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Back',
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.buttonColor,
            ),
            onPressed: (() {
              onButtonPressed(widget.myOrder.packageId);
            }),
            child: const Text(
              'Show Package',
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Column getColumn(String label, String profileInput) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.grey[700],
          ),
        ),

        // ignore: prefer_const_constructors
        SizedBox(
          height: 10,
        ),
        Text(
          profileInput,
          style: TextStyle(
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        Divider(
          color: Colors.grey[700],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  void onButtonPressed(id) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
                create: (_) => PackageListViewModel(),
                child: PackageDetailView(
                  packageLineItemId: id,
                ),
              ),
          settings: RouteSettings(arguments: 9)),
    );
    print("Login Button pressed!!!");
  }
}
