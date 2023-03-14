import 'package:flutter/material.dart';

import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';

class OrderDetailView extends StatefulWidget {
  const OrderDetailView({super.key});

  @override
  State<OrderDetailView> createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
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
                    getColumn('Order Number', '9876543213'),
                    getColumn('Order Amount', '99.99'),
                    getColumn('Order Date', '23-03-2023'),
                    getColumn('Expiry Date', '23-06-2023'),
                    getColumn('Payment Types', 'Bank'),
                    getColumn('Payment Status', 'Confirm'),
                    getColumn('Validity', '365'),
                    getColumn('Status', 'ACTIVE'),
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
            onPressed: (() {}),
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
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.grey,
          ),
        ),

        // ignore: prefer_const_constructors
        SizedBox(
          height: 10,
        ),
        Text(
          profileInput,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 3,
        ),
        const Divider(
          color: Colors.grey,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
