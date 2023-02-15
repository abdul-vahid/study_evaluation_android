import 'package:flutter/material.dart';
import 'package:study_evaluation/models/category_model.dart';
import 'package:study_evaluation/utils/app_color.dart';
import 'package:study_evaluation/view/screens/contable_screen.dart';
import 'package:study_evaluation/view/screens/packages_view.dart';
import 'package:study_evaluation/view/widgets/widget_utils.dart';
import 'package:study_evaluation/viewmodel/category_view_model/category_list_vm.dart';

class CategoryController {
  var context;
  CategoryListViewModel categoriesVM;
  CategoryController(this.context, this.categoriesVM);
}
