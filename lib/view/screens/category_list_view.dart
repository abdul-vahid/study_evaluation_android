import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_evaluation/models/category_model.dart';
import 'package:study_evaluation/view/screens/package_list_view.dart';
import 'package:study_evaluation/view/widgets/widget_utils.dart';
import 'package:study_evaluation/viewmodel/category_view_model/category_list_vm.dart';
import 'package:study_evaluation/viewmodel/package_view_model/package_list_vm.dart';

import '../../utils/app_color.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({super.key});

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  @override
  void initState() {
    super.initState();
    Provider.of<CategoryListViewModel>(context, listen: false).fetch();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesVM = Provider.of<CategoryListViewModel>(context);
    //_categoryController = CategoryController(context, categoriesVM);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(color: Colors.white),
        title: const Text("Test Categories"),
        elevation: .1,
        backgroundColor: AppColor.appBarColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _getCategoryWidget(categoriesVM),
          ],
        ),
      ),
    );
  }

  Widget _getCategoryWidget(categoriesVM) {
    var count = categoriesVM.categoryViewModels.length;
    var height = count > 8 ? (count * 100.0) : 800.0;
    return Container(
        width: double.infinity,
        height: height,
        margin: const EdgeInsets.all(15.0),
        // width: 200,
        child: _getGridView(categoriesVM));
  }

  void _onTap(id) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (_) => PackageListViewModel(),
              child: const PackageListView()),
          settings: RouteSettings(arguments: id)),
    );
    print("Test pressed!!!");
  }

  Widget _getGridView(categoriesVM) {
    return categoriesVM.categoryViewModels.isNotEmpty
        ? GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categoriesVM.categoryViewModels.length,
            itemBuilder: (context, index) {
              CategoryModel categoryModel =
                  categoriesVM.categoryViewModels[index].categoryModel;
              return WidgetUtils.getCard('${categoryModel.name}',
                  "assets/images/test-series.png", _onTap,
                  imageHeight: 70.0);
            })
        : const CircularProgressIndicator();
  }
}
