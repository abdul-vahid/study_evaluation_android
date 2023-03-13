// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/view/views/order_detail_view.dart';

import 'package:study_evaluation/view/views/package_detail_view.dart';
import 'package:study_evaluation/view/widgets/app_drawer_widget.dart';
import 'package:study_evaluation/view_models/order_list_vm.dart';

import '../../models/order_model.dart';
import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';
import '../../utils/enum.dart';
import '../../view_models/package_list_vm.dart';

class MyOrderView extends StatefulWidget {
  const MyOrderView({super.key});

  @override
  State<MyOrderView> createState() => _MyOrderViewState();
}

class _MyOrderViewState extends State<MyOrderView> {
  BaseListViewModel? baseListViewModel;
  String? profileUrl;
  @override
  void initState() {
    super.initState();
    Provider.of<OrderListViewModel>(context, listen: false).fetch();
  }

  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    baseListViewModel = Provider.of<OrderListViewModel>(context);
    print('@@@$baseListViewModel');
    return Scaffold(
      appBar: AppUtils.getAppbar("My Order"),
      body: AppUtils.getAppBody(baseListViewModel!, _getDataBody),
      drawer: const AppDrawerWidget(),
    );
  }

  SingleChildScrollView _getDataBody() {
    return SingleChildScrollView(
      child: Column(children: _getLeaderBordWidgets),
    );
  }

  List<Widget> get _getLeaderBordWidgets {
    List<Widget> widgets = [];

    for (var viewModel in baseListViewModel!.viewModels) {
      widgets.add(getCard(viewModel.model));

      print('viewModel$viewModel');
      // viewModel.model
      print('viewModel.model@@ ${viewModel.model}');
    }

    return widgets;
  }

  // Widget _getorderWidget(orderVM) {
  //   var count = orderVM.viewModels.length;
  //   var height = count > 8 ? (count * 100.0) : 800.0;
  //   return Container(
  //       width: double.infinity,
  //       height: height,
  //       margin: const EdgeInsets.all(15.0),
  //       // width: 200,
  //       child: _getGridView(orderVM));
  // }

  // void _onTap(id) {
  //   print("id is $id");
  // }

  // Widget _getGridView(orderVM) {
  //   return orderVM.viewModels.isNotEmpty
  //       ? _getBody(orderVM)
  //       : AppUtils.getLoader();
  // }

  // GridView _getBody(orderVM) {
  //   return GridView.builder(
  //       gridDelegate:
  //           const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
  //       physics: const NeverScrollableScrollPhysics(),
  //       itemCount: orderVM.viewModels.length,
  //       itemBuilder: (context, index) {
  //         OrderModel orderyModel =
  //             orderVM.viewModels[index].model as OrderModel;
  //         var url = AppUtils.getImageUrl(orderyModel.logoUrl);
  //         //print(categoryModel.logoUrl);
  //         return getCard(orderyModel.packagesTitle!, url, orderyModel.amount!,
  //             orderyModel.packageId!, _onTap,
  //             imageHeight: 70.0,
  //             imageType: ImageType.network,
  //             data: orderyModel.packagesTitle);
  //       });
  // }

  getCard(myOrder) {
    if (myOrder?.logoUrl != null) {
      profileUrl = AppUtils.getImageUrl(myOrder?.logoUrl);
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          onButtonPressed();
          print('packageId@@@!${myOrder.packageId}');
        },
        child: Card(
          elevation: 5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CircleAvatar(
                        backgroundImage: profileUrl == null
                            ? const NetworkImage(
                                'https://pixel.nymag.com/imgs/daily/vulture/2017/06/14/14-tom-cruise.w700.h700.jpg')
                            : NetworkImage(profileUrl!),
                        radius: 30.0,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: <Widget>[
                          Text(
                              // myborder.amount,
                              myOrder.packagesTitle,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                          Text(
                            myOrder.name,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: <Widget>[
              //     // ignore: prefer_const_literals_to_create_immutables
              //     // getText('Order Date', myOrder.createdDate),
              //     getText('Order Number', myOrder.orderNumber),
              //     getText('Order Amount', '₹${myOrder.amount}'),
              //   ],
              // ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: <Widget>[
              //     // ignore: prefer_const_literals_to_create_immutables
              //     //  getText('Order Date', myOrder.createdDate),
              //     getText('Order Date', myOrder.currentStatus),
              //     getText('Expiry Date ', myOrder.expiryDate),
              //   ],
              // ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: <Widget>[
              //     // ignore: prefer_const_literals_to_create_immutables
              //     //getText('Order Date', myOrder.createdDate),
              //     getText('Payment Types', myOrder.paymentType),
              //     getText('Payment Status', myOrder.paymentStatus),
              //   ],
              // ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: <Widget>[
              //     // ignore: prefer_const_literals_to_create_immutables
              //     // getText('Order Date', myOrder.createdDate),
              //     getText('Validity', myOrder.validity),

              //     getText('Status', myOrder.currentStatus),
              //   ],
              // ),
              // SizedBox(
              //   height: 10,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Padding getText(String label, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10, bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  //   return Card(
  //     color: AppColor.boxColor,
  //     elevation: 3,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(18.0),
  //     ),
  //     margin: EdgeInsets.all(10.0),
  //     child: InkWell(
  //       onTap: () {
  //         onButtonPressed(packageId);
  //         print('packageId@@@!${packageId}');
  //       },
  //       child: Center(
  //         child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
  //           Text(
  //             lable,
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               fontWeight: FontWeight.bold,
  //               fontSize: fontSize,
  //               color: AppColor.textColor,
  //             ),
  //           ),
  //           const SizedBox(
  //             height: 7,
  //           ),
  //           _getImage(imagePath, imageType, imageHeight: imageHeight),
  //           const SizedBox(
  //             height: 5,
  //           ),
  //           Text(
  //             amount == null ? 'N/A' : '₹${amount}',
  //             textAlign: TextAlign.center,
  //             style: TextStyle(
  //               fontWeight: FontWeight.bold,
  //               fontSize: fontSize,
  //               color: AppColor.textColor,
  //             ),
  //           ),
  //         ]),
  //       ),
  //     ),
  //   );

  _getImage(url, imageType, {imageHeight}) {
    if (imageType == ImageType.assets) {
      return Image.asset(
        url,
        height: imageHeight,
      );
    } else {
      return Image.network(
        url,
        height: imageHeight,
      );
    }
  }

  void onButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderDetailView()),
    );
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => ChangeNotifierProvider(
    //             create: (_) => PackageListViewModel(),
    //             child: PackageDetailView(
    //               packageLineItemId: packageId,
    //             ),
    //           ),
    //       settings: RouteSettings(arguments: 9)),
    // );
    print("Login Button pressed!!!");
  }
}
