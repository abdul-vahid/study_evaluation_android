import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/order_model.dart';
import '../../utils/app_color.dart';
import '../../utils/app_utils.dart';
import '../../utils/enum.dart';
import '../../view_models/order_list_vm.dart';
import '../widgets/widget_utils.dart';

class MyOrderView extends StatefulWidget {
  const MyOrderView({super.key});

  @override
  State<MyOrderView> createState() => _MyOrderViewState();
}

class _MyOrderViewState extends State<MyOrderView> {
  OrderListViewModel? orderVM;
  @override
  void initState() {
    super.initState();
    Provider.of<OrderListViewModel>(context, listen: false).fetch();
  }

  @override
  Widget build(BuildContext context) {
    orderVM = Provider.of<OrderListViewModel>(context);
    print('@@@$orderVM');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const BackButton(color: Colors.white),
        title: const Text("My Order"),
        elevation: .1,
        backgroundColor: AppColor.appBarColor,
      ),
      body: AppUtils.getAppBody(orderVM!, _getDataBody),
    );
  }

  SingleChildScrollView _getDataBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _getCategoryWidget(orderVM),
        ],
      ),
    );
  }

  Widget _getCategoryWidget(orderVM) {
    var count = orderVM.viewModels.length;
    var height = count > 8 ? (count * 100.0) : 800.0;
    return Container(
        width: double.infinity,
        height: height,
        margin: const EdgeInsets.all(15.0),
        // width: 200,
        child: _getGridView(orderVM));
  }

  void _onTap(id) {
    print("id is $id");
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => ChangeNotifierProvider(
    //           create: (_) => PackageListViewModel(),
    //           child: PackageListView(
    //             categoryId: id,
    //           )),
    //       settings: RouteSettings(arguments: id)),
    // );
    // print("Test pressed!!!");
  }

  Widget _getGridView(orderVM) {
    return orderVM.viewModels.isNotEmpty
        ? _getBody(orderVM)
        : AppUtils.getLoader();
  }

  GridView _getBody(orderVM) {
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: orderVM.viewModels.length,
        itemBuilder: (context, index) {
          OrderModel orderyModel = orderVM.viewModels[index].model;
          var url = AppUtils.getImageUrl(orderyModel.logoUrl);
          //print(categoryModel.logoUrl);
          return WidgetUtils.getCard(orderyModel.name!, url, _onTap,
              imageHeight: 70.0,
              imageType: ImageType.network,
              data: orderyModel.packageId);
        });
  }
}
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         leading: BackButton(color: Colors.white),
//         title: Text("My Order"),
//         elevation: .1,
//         backgroundColor: AppColor.appBarColor,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               height: 800.0,
//               child: GridView.count(
//                 crossAxisCount: 2,
//                 // padding: EdgeInsets.all(2.0),
//                 children: <Widget>[
//                   getCard(
//                     '₹499',
//                     'assets/images/contable.png',
//                   ),
//                   // getCard(
//                   //   '₹499',
//                   //   'assets/images/contable.png',
//                   // ),
//                   // getCard(
//                   //   '₹499',
//                   //   'assets/images/contable.png',
//                   // ),
//                   // getCard(
//                   //   '₹499',
//                   //   'assets/images/contable.png',
//                   // ),
//                   // getCard(
//                   //   '₹499',
//                   //   'assets/images/contable.png',
//                   // ),
//                   // getCard(
//                   //   '₹499',
//                   //   'assets/images/contable.png',
//                   // ),
//                   // getCard(
//                   //   '₹499',
//                   //   'assets/images/contable.png',
//                   // ),
//                   // getCard(
//                   //   '₹499',
//                   //   'assets/images/contable.png',
//                   // ),
//                   // getCard(
//                   //   '₹499',
//                   //   'assets/images/contable.png',
//                   // ),
//                   // getCard(
//                   //   '₹499',
//                   //   'assets/images/contable.png',
//                   // ),
//                   // getCard(
//                   //   '₹499',
//                   //   'assets/images/contable.png',
//                   // ),
//                   // getCard(
//                   //   '₹499',
//                   //   'assets/images/contable.png',
//                   // ),
//                   // getCard(
//                   //   '₹499',
//                   //   'assets/images/contable.png',
//                   // ),
//                   // getCard(
//                   //   '₹499',
//                   //   'assets/images/contable.png',
//                   // ),
//                   // getCard(
//                   //   '₹499',
//                   //   'assets/images/contable.png',
//                   // ),
//                   // getCard(
//                   //   '₹499',
//                   //   'assets/images/contable.png',
//                   // ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   onButtonPressed() {
//     // Navigator.push(
//     //   context,
//     //   MaterialPageRoute(builder: (context) => const ContableScreen()),
//     // );
//     // print("Login Button pressed!!!");
//   }

//   getCard(String lable, String imagePath,
//       {imageHeight = 120.0,
//       fontSize = 15.0,
//       imageType = ImageType.assets,
//       data}) {
//     return Card(
//       color: AppColor.boxColor,
//       elevation: 3,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(18.0),
//       ),
//       margin: EdgeInsets.all(10.0),
//       child: InkWell(
//         onTap: () {
//           // voidCallback(data);
//         },
//         child: Center(
//           child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//             Text(
//               lable,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: fontSize,
//                 color: AppColor.textColor,
//               ),
//             ),
//             const SizedBox(
//               height: 3,
//             ),
//             getImage(imagePath, imageType, imageHeight: imageHeight),
//             const SizedBox(
//               height: 3,
//             ),
//             Text(
//               lable,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: fontSize,
//                 color: AppColor.textColor,
//               ),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }

//   getImage(url, imageType, {imageHeight}) {
//     if (imageType == ImageType.assets) {
//       return Image.asset(
//         url,
//         height: imageHeight,
//       );
//     } else {
//       return Image.network(
//         url,
//         height: imageHeight,
//       );
//     }
//   }

//   // Card makeDashboardItem(String title, Image image, double width, double height,
//   //     VoidCallback voidCallback) {
//   //   return Card(
//   //       elevation: 1.0,
//   //       // shape: RoundedRectangleBorder(
//   //       //   borderRadius: BorderRadius.circular(15.0),
//   //       // ),
//   //       margin: new EdgeInsets.only(left: 15, top: 15, bottom: 10, right: 15),
//   //       child: InkWell(
//   //         onTap: () {
//   //           voidCallback();
//   //         },
//   //         child: Column(children: [
//   //           // InkWell(
//   //           //   onTap: () {},
//   //           // ),
//   //           Expanded(
//   //             flex: 3,
//   //             child: Column(
//   //               children: [
//   //                 Container(
//   //                   height: 5,
//   //                   color: AppColor.appBarColor,
//   //                 ),
//   //                 const SizedBox(
//   //                   height: 10,
//   //                 ),
//   //                 Container(
//   //                   child: image,
//   //                   height: height,
//   //                   width: width,
//   //                 ),
//   //                 const SizedBox(
//   //                   height: 10,
//   //                 ),
//   //                 const Text(
//   //                   'Rajasthan Constable Special',
//   //                   style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
//   //                 ),
//   //               ],
//   //             ),
//   //           ),

//   //           Expanded(
//   //               child: Container(
//   //                   decoration:
//   //                       BoxDecoration(color: AppColor.containerBoxColor),
//   //                   child: Center(
//   //                       child: Text(
//   //                     title,
//   //                     style: const TextStyle(
//   //                       color: Colors.white,
//   //                     ),
//   //                   ))))
//   //         ]),
//   //       ));

// }
