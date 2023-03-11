import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';

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
  @override
  void initState() {
    super.initState();
    Provider.of<OrderListViewModel>(context, listen: false).fetch();
  }

  @override
  Widget build(BuildContext context) {
    baseListViewModel = Provider.of<OrderListViewModel>(context);
    print('@@@$baseListViewModel');
    return Scaffold(
      appBar: AppUtils.getAppbar(
          "My Order") /* AppBar(
        centerTitle: true,
        leading: const BackButton(color: Colors.white),
        title: const Text("My Order"),
        elevation: .1,
        backgroundColor: AppColor.appBarColor,
      ) */
      ,
      body: AppUtils.getAppBody(baseListViewModel!, _getDataBody),
      drawer: const AppDrawerWidget(),
    );
  }

  SingleChildScrollView _getDataBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _getorderWidget(baseListViewModel),
        ],
      ),
    );
  }

  Widget _getorderWidget(orderVM) {
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
          OrderModel orderyModel =
              orderVM.viewModels[index].model as OrderModel;
          var url = AppUtils.getImageUrl(orderyModel.logoUrl);
          //print(categoryModel.logoUrl);
          return getCard(orderyModel.packagesTitle!, url, orderyModel.amount!,
              orderyModel.packageId!, _onTap,
              imageHeight: 70.0,
              imageType: ImageType.network,
              data: orderyModel.packagesTitle);
        });
  }

  getCard(String lable, String imagePath, String amount, String packageId,
      void Function(dynamic) voidCallback,
      {imageHeight = 120.0,
      fontSize = 15.0,
      imageType = ImageType.assets,
      data}) {
    return Card(
      color: AppColor.boxColor,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      margin: EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          onButtonPressed(packageId);
          print('packageId@@@!${packageId}');
        },
        child: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Text(
              lable,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
                color: AppColor.textColor,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            _getImage(imagePath, imageType, imageHeight: imageHeight),
            const SizedBox(
              height: 5,
            ),
            Text(
              amount == null ? 'N/A' : '₹${amount}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
                color: AppColor.textColor,
              ),
            ),
          ]),
        ),
      ),
    );
  }

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

  void onButtonPressed(packageId) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
                create: (_) => PackageListViewModel(),
                child: PackageDetailView(
                  packageLineItemId: packageId,
                ),
              ),
          settings: RouteSettings(arguments: 9)),
    );
    print("Login Button pressed!!!");
  }
}
