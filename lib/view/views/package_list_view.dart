// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/models/package_model/package.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/view/views/package_detail_view.dart';
import 'package:study_evaluation/view_models/package_list_vm.dart';

import '../../utils/app_color.dart';

class PackageListView extends StatefulWidget {
  String? categoryId;
  String? packageType;
  String? publishType;

  PackageListView(
      {super.key, this.categoryId, this.packageType, this.publishType});

  @override
  State<PackageListView> createState() => _PackageListViewState();
}

class _PackageListViewState extends State<PackageListView> {
  PackageListViewModel? packageListVM;
  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      var userModel = AppUtils.getSessionUser(prefs);
      userModel ?? AppUtils.logout(context);
    });
    Provider.of<PackageListViewModel>(context, listen: false).fetch(
        categoryId: widget.categoryId ?? "",
        publishType: widget.publishType ?? "",
        packageType: widget.packageType ?? "");
    //final id = ModalRoute.of(context)!.settings.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    packageListVM = Provider.of<PackageListViewModel>(context);
    return Scaffold(
      appBar: AppUtils.getAppbar("Packages",
          leading: const BackButton(color: Colors.white)),
      body: AppUtils.getAppBody(packageListVM!, _getBody),
    );
  }

  /* Widget getBody(PackageListViewModel packageListVM) {
    if (packageListVM.status == "Loading") {
      return AppUtil.getLoader();
    } else if (packageListVM.status == "Error") {
      return AppUtil.getErrorWidget(packageListVM.viewModels[0].model);
    } else if (packageListVM.viewModels.isNotEmpty) {
      return _getBody(packageListVM);
    } else {
      return AppUtil.getNoRecordWidget();
    }
  } */

  SingleChildScrollView _getBody() {
    return SingleChildScrollView(
        child: Column(children: getWidgets(packageListVM)));
  }

  List<Widget> getWidgets(packageListVM) {
    List<Widget> widgets = [];
    if (packageListVM.viewModels.isNotEmpty) {
      packageListVM.viewModels.forEach((viewModel) {
        widgets.add(getPadding(context, viewModel.model));
      });
      widgets.add(const SizedBox(
        height: 10,
      ));

      /* widgets.add(Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 40,
          color: AppColor.containerBoxColor,
        ),
      )); */
    }
    return widgets;
  }

  Padding getPadding(BuildContext context, Package model) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
      ),
      child: getCard(context, model),
    );
  }

  Card getCard(BuildContext context, Package model) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Theme.of(context).colorScheme.outline,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      ),
      child: InkWell(
        onTap: () {
          onButtonPressed(model.id);
        },
        child: Column(
          children: [
            Container(
              height: 10,
              decoration: const BoxDecoration(
                color: AppColor.containerBoxColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    topLeft: Radius.circular(8.0)),
              ),
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _getImageContainer(model),
                SizedBox(
                  width: 20,
                ),
                _getContentContainer(model),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Html(data: model.getShortDescription(0, end: 150)),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Expanded _getContentContainer(Package model) {
    return Expanded(
        child: Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Text("${model.title}",
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 1)),
        ),
        // Padding(
        //   padding: const EdgeInsets.all(5.0),
        //   child: Text("${model.category}",
        //       style: const TextStyle(
        //           fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1)),
        // ),
      ],
    ));
  }

  Padding _getImageContainer(Package model) {
    return Padding(
        padding: const EdgeInsets.only(top: 10, left: 10),
        child: CircleAvatar(
          radius: 50,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(0), // Border radius
            child: ClipOval(
                child: FadeInImage.assetNetwork(
              placeholder: "assets/images/loading.gif",
              image:
                  '${AppConstants.baseUrl}${AppConstants.publicPath}/${model.logoUrl}',
              fit: BoxFit.cover,
              height: 100,
              width: 100,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/no_image.png',
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                );
              },
            )),
          ),
        ));
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
  }
}
