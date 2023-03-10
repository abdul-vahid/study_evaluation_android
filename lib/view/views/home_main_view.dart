import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/models/configuration_model.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/view/views/aboutus_view.dart';
import 'package:study_evaluation/view/views/leardeboard_view.dart';
import 'package:study_evaluation/view/views/myorder_view.dart';
import 'package:study_evaluation/view_models/category_list_vm.dart';
import 'package:study_evaluation/view_models/cofiguration_list_vm.dart';
import 'package:study_evaluation/view_models/feedback_list_vm.dart';
import 'package:study_evaluation/view_models/slider_image_list_vm.dart';
import '../widgets/bottom_navigation.dart' as bottom_navi_widget;
import 'package:study_evaluation/view/views/home_view.dart';

class HomeMainView extends StatefulWidget {
  const HomeMainView({super.key});

  @override
  State<HomeMainView> createState() => _HomeMainViewState();
}

class _HomeMainViewState extends State<HomeMainView> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget>? _widgetOptions;

  @override
  void initState() {
    super.initState();
    String url = AppUtils.getUrl(AppConstants.configurationAPIPath);

    Provider.of<CategoryListViewModel>(context, listen: false).fetch();
    Provider.of<SliderImageListViewModel>(context, listen: false).fetch();
    Provider.of<FeedbackListViewModel>(context, listen: false).fetch();
    Provider.of<BaseListViewModel>(context, listen: false)
        .get(baseModel: ConfigurationModel(), url: url);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoriesVM = Provider.of<CategoryListViewModel>(context);
    final slidersVM = Provider.of<SliderImageListViewModel>(context);
    final feedbacksVM = Provider.of<FeedbackListViewModel>(context);
    final configListViewModel = Provider.of<BaseListViewModel>(context);
    _widgetOptions = <Widget>[
      HomeView(
          categoriesVM: categoriesVM,
          slidersVM: slidersVM,
          feedbacksVM: feedbacksVM,
          configListViewModel: configListViewModel),
      AboutUsScreen(),
      const MyOrderView(),
      const LearderbordView()
    ];
    return Scaffold(
      body: Center(
        child: _widgetOptions?.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: bottom_navi_widget
          .getBottomNavigation(_selectedIndex, onItemTap: _onItemTapped),
    );
  }
}
