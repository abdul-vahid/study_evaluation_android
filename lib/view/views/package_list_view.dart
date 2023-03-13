import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:study_evaluation/models/package_model/package.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/view/views/package_detail_view.dart';
import 'package:study_evaluation/view_models/package_list_vm.dart';

import '../../utils/app_color.dart';

class PackageListView extends StatefulWidget {
  final String categoryId;
  const PackageListView({super.key, required this.categoryId});

  @override
  State<PackageListView> createState() => _PackageListViewState();
}

class _PackageListViewState extends State<PackageListView> {
  PackageListViewModel? packageListVM;
  @override
  void initState() {
    Provider.of<PackageListViewModel>(context, listen: false)
        .fetch(categoryId: widget.categoryId);
    //final id = ModalRoute.of(context)!.settings.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    packageListVM = Provider.of<PackageListViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const BackButton(color: Colors.white),
        title: const Text("Packages"),
        elevation: .1,
        backgroundColor: AppColor.appBarColor,
      ),
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
        height: 300,
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
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 220,
        child: getCard(context, model),
      ),
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
              decoration: BoxDecoration(
                color: AppColor.containerBoxColor,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8.0),
                    topLeft: Radius.circular(8.0)),
              ),
            ),
            Row(
              children: [
                _getImageContainer(model),
                _getContentContainer(model),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Expanded _getContentContainer(Package model) {
    return Expanded(
        child: Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("${model.title}",
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 1)),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Html(data: model.getShortDescription(1, end: 50)),
        ),
      ],
    ));
  }

  Container _getImageContainer(Package model) {
    print("Image Path: ${AppConstants.imagePath}/${model.logoUrl}");
    return Container(
      height: 80,
      width: 120,
      //padding: EdgeInsets.only(top: 0),
      margin: const EdgeInsets.only(bottom: 50, left: 5),
      decoration: BoxDecoration(
        image: DecorationImage(
          scale: 5,
          image: NetworkImage(
              '${AppConstants.baseUrl}${AppConstants.imagePath}/${model.logoUrl}'),
          fit: BoxFit.fill,
        ),
        color: Colors.white,
        shape: BoxShape.circle,
      ),
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
