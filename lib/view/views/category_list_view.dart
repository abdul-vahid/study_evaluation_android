import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_evaluation/models/category_model.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/utils/enum.dart';
import 'package:study_evaluation/view/views/package_list_view.dart';
import 'package:study_evaluation/view/widgets/widget_utils.dart';
import 'package:study_evaluation/view_models/category_list_vm.dart';
import 'package:study_evaluation/view_models/package_list_vm.dart';

import '../../utils/app_color.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({super.key});

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  CategoryListViewModel? categoriesVM;
  @override
  void initState() {
    super.initState();
    Provider.of<CategoryListViewModel>(context, listen: false).fetch();
  }

  @override
  Widget build(BuildContext context) {
    categoriesVM = Provider.of<CategoryListViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const BackButton(color: Colors.white),
        title: const Text("Test Series"),
        elevation: .1,
        backgroundColor: AppColor.appBarColor,
      ),
      body: AppUtil.getAppBody(categoriesVM!, _getDataBody),
    );
  }

  SingleChildScrollView _getDataBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _getCategoryWidget(categoriesVM),
        ],
      ),
    );
  }

  Widget _getCategoryWidget(categoriesVM) {
    var count = categoriesVM.viewModels.length;
    var height = count > 8 ? (count * 100.0) : 800.0;
    return Container(
        width: double.infinity,
        height: height,
        margin: const EdgeInsets.all(15.0),
        // width: 200,
        child: _getGridView(categoriesVM));
  }

  void _onTap(id) {
    print("id is $id");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (_) => PackageListViewModel(),
              child: PackageListView(
                categoryId: id,
              )),
          settings: RouteSettings(arguments: id)),
    );
    print("Test pressed!!!");
  }

  Widget _getGridView(categoriesVM) {
    return categoriesVM.viewModels.isNotEmpty
        ? _getBody(categoriesVM)
        : AppUtil.getLoader();
  }

  GridView _getBody(categoriesVM) {
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categoriesVM.viewModels.length,
        itemBuilder: (context, index) {
          CategoryModel categoryModel = categoriesVM.viewModels[index].model;
          var url = AppUtil.getImageUrl(categoryModel.logoUrl);
          //print(categoryModel.logoUrl);
          return WidgetUtils.getCard(categoryModel.name!, url, _onTap,
              imageHeight: 70.0,
              imageType: ImageType.network,
              data: categoryModel.id);
        });
  }
}
