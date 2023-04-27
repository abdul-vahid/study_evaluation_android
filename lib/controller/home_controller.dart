import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:provider/provider.dart';
import 'package:study_evaluation/models/feedback_model.dart';
import 'package:study_evaluation/models/home_tiles_model.dart';
import 'package:study_evaluation/models/slider_image_model.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/utils/enum.dart';
import 'package:study_evaluation/view/views/latest_news_view.dart';
import 'package:study_evaluation/view/views/package_list_view.dart';
import 'package:study_evaluation/view/widgets/widget_utils.dart';
import 'package:study_evaluation/view_models/feedback_list_vm.dart';
import 'package:study_evaluation/view_models/latest_news_list_vm.dart';
import 'package:study_evaluation/view_models/package_list_vm.dart';
import 'package:study_evaluation/view_models/slider_image_list_vm.dart';
import 'package:transparent_image/transparent_image.dart';

import '../utils/app_constants.dart';
import '../view/views/package_detail_view.dart';

class HomeController {
  BuildContext context;
  String? profileUrl;
  FeedbackListViewModel feedbackListViewModel;
  SliderImageListViewModel? viewModelList;
  HomeController(this.context, this.feedbackListViewModel);

  Widget getHomeTiles() {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 1.5,
        // height: 540.0,
        margin: const EdgeInsets.all(15.0),
        // width: 200,
        child: _getGridView());
  }

  void _onHomeTiles(id) {
    AppUtils.launchTab(context,
        selectedIndex: HomeTabsOptions.testSeries.index);
  }

  void _onComboTiles(id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
            create: (_) => PackageListViewModel(),
            child: PackageListView(
              packageType: "combo",
            )),
      ),
    );
  }

  void _onFreeTiles(id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
            create: (_) => PackageListViewModel(),
            child: PackageListView(
              publishType: "free",
            )),
      ),
    );
  }

  void _onLatestTiles(id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
            create: (_) => LatestNewsListViewModel(),
            child: const LatestNewsView()),
      ),
    );
  }

  void _onTilesTap(id) {
    AppUtils.getAlert(
        context, ["This functionality is currenlty unavailable!"]);
  }

  Widget _getGridView() {
    List<HomeTilesModel> homeTilesModels = AppUtils.getHomeTilesModels();

    return homeTilesModels.isNotEmpty
        ? _getBody(homeTilesModels, _onTilesTap)
        : AppUtils.getLoader();
  }

  GridView _getBody(List<HomeTilesModel> homeTilesModels,
      void Function(dynamic id) onTilesTap) {
    return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: homeTilesModels.length,
        itemBuilder: (context, index) {
          HomeTilesModel homeTilesModel = homeTilesModels[index];
          void Function(dynamic id) callBack;
          if (homeTilesModel.title.toLowerCase() == "test series") {
            callBack = _onHomeTiles;
          } else if (homeTilesModel.title.toLowerCase() == "combo package") {
            callBack = _onComboTiles;
          } else if (homeTilesModel.title.toLowerCase() == "latest exam") {
            callBack = _onLatestTiles;
          } else if (homeTilesModel.title.toLowerCase() == "free content") {
            callBack = _onFreeTiles;
          } else {
            callBack = onTilesTap;
          }
          return WidgetUtils.getCard(
              homeTilesModel.title, homeTilesModel.imagePath, callBack,
              imageHeight: 70.0);
        });
  }

  Container getImageSlideshowContainer(SliderImageListViewModel viewModelList) {
    this.viewModelList = viewModelList;
    return Container(
        margin: const EdgeInsets.only(left: 5.0, right: 10.0, top: 4.0),
        height: 200,
        child: AppUtils.getAppBody(viewModelList, _imageSlideshowWidget));
  }

  ImageSlideshow _imageSlideshowWidget() {
    return ImageSlideshow(
      width: double.infinity,
      height: 200,
      initialPage: 0,
      //  indicatorColor: Colors.blue,
      indicatorBackgroundColor: Colors.grey,
      onPageChanged: (value) {},
      autoPlayInterval: 5000,
      isLoop: true,
      children: _getImagesWidgets(viewModelList?.viewModels),
    );
  }

  List<Widget> _getImagesWidgets(viewModels) {
    List<Widget> imageWidgets = [];
    viewModels.forEach((viewModel) {
      imageWidgets.add(_getImageWidget(viewModel.getViewModel));
    });
    return imageWidgets;
  }

  Widget _getImageWidget(SliderImageModel model) {
    return InkWell(
      onTap: () {
        if (model.packageId != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                      create: (_) => PackageListViewModel(),
                      child: PackageDetailView(
                        packageLineItemId: (model.packageId)!,
                      ),
                    ),
                settings: RouteSettings(arguments: 9)),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: FadeInImage.memoryNetwork(
          image: AppUtils.getImageUrl(model.sliderUrl),
          placeholder: kTransparentImage,
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset('assets/images/motivational.png',
                fit: BoxFit.cover);
          },
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget getFeedbackSlideshowContainer() {
    if (feedbackListViewModel.viewModels.isEmpty) {
      return Container();
    }
    return Container(
        margin: const EdgeInsets.only(left: 5.0, right: 10.0, top: 2.0),
        height: 200,
        child: _feedbackSlideshowWidget());
  }

  ImageSlideshow _feedbackSlideshowWidget() {
    return ImageSlideshow(
      width: double.infinity,
      height: 200,
      initialPage: 0,
      indicatorBackgroundColor: Colors.grey,
      onPageChanged: (value) {},
      autoPlayInterval: 20000,
      isLoop: true,
      children: _getFeedbackWidgets(),
    );
  }

  List<Widget> _getFeedbackWidgets() {
    List<Widget> widgets = [];
    if (feedbackListViewModel.isError) {
      return widgets;
    }
    for (var viewModel in feedbackListViewModel.viewModels) {
      widgets.add(_getFeedbackWidget(viewModel.model as FeedbackModel));
    }
    return widgets;
  }

  Container _getFeedbackWidget(model) {
    return feedbackInnerContainer(model);
  }

  Container feedbackInnerContainer(model) {
    return Container(
      //color: Colors.amber,
      width: 350,
      height: 220,
      decoration: containerBoxDecoration(),

      child: _feedbackCard(model),
    );
  }

  Card _feedbackCard(model) {
    return Card(
      elevation: 0,
      shape: _roundRectBorder(),
      child: Row(
        children: [
          _feedbackCardContainer(model),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: Column(
            children: [
              _nameAndFeedbackWidget(model),
              //_shareButton()
            ],
          )),
        ],
      ),
    );
  }

  Container _nameAndFeedbackWidget(model) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 4),
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: _getNameWidget(model),
        ),
        subtitle: _getParaWidget(model),
      ),
    );
  }

  Text _getParaWidget(model) {
    return Text(
      "${model.comment}",
      style: const TextStyle(fontSize: 17),
      maxLines: 4,
    );
  }

  Text _getNameWidget(model) {
    return Text("${model.fullName}",
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 1));
  }

  // Container _shareButton() {
  //   return Container(
  //     padding: const EdgeInsets.only(left: 150),
  //     child: Row(
  //       children: [
  //         Align(
  //           child: TextButton.icon(
  //             // <-- TextButton
  //             onPressed: () {
  //               Share.share('com.study.evaluation',
  //                   subject: 'Welcome Message');
  //             },
  //             icon: const Icon(
  //               Icons.share,
  //               size: 20.0,
  //             ),
  //             label: const Text('SHARE'),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Container _feedbackCardContainer(model) {
    if (model?.profileUrl != null) {
      profileUrl =
          '${AppConstants.baseUrl}${AppConstants.publicPath}/${model.profileUrl}';
    }

    return Container(
      height: 70,
      width: 70,
      //padding: EdgeInsets.only(top: 0),
      margin: const EdgeInsets.only(bottom: 100, left: 10),
      decoration: BoxDecoration(),
      child: CircleAvatar(
        radius: 60,
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(0), // Border radius
          child: ClipOval(
              child: FadeInImage.assetNetwork(
            placeholder: "assets/images/loading.gif",
            image: profileUrl ?? "",
            fit: BoxFit.cover,
            height: 100,
            width: 100,
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/profile-image.png',
                fit: BoxFit.cover,
                height: 100,
                width: 100,
              );
            },
          )),
        ),
      ),
    );
  }

  RoundedRectangleBorder _roundRectBorder() {
    return RoundedRectangleBorder(
      side: BorderSide(
        color: Theme.of(context).colorScheme.outline,
      ),
      //borderRadius: const BorderRadius.all(Radius.circular(12)),
    );
  }

  BoxDecoration containerBoxDecoration() {
    return BoxDecoration(
      boxShadow: [BoxShadow(blurRadius: 1.0, color: Colors.grey.shade100)],
      borderRadius: const BorderRadius.all(Radius.circular(12)),
    );
  }
}
