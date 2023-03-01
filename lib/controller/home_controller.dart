import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:provider/provider.dart';
import 'package:study_evaluation/models/home_tiles_model.dart';
import 'package:study_evaluation/models/slider_image_model.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/view/views/category_list_view.dart';
import 'package:study_evaluation/view/widgets/widget_utils.dart';
import 'package:study_evaluation/view_models/category_list_vm.dart';
import 'package:study_evaluation/view_models/feedback_list_vm.dart';
import 'package:study_evaluation/view_models/slider_image_list_vm.dart';

class HomeController {
  var context;
  FeedbackListViewModel feedbackListViewModel;
  SliderImageListViewModel? viewModelList;
  HomeController(this.context, this.feedbackListViewModel);
  Widget getHomeTiles() {
    return Container(
        width: double.infinity,
        height: 540.0,
        margin: const EdgeInsets.all(15.0),
        // width: 200,
        child: _getGridView());
  }

  void _onHomeTiles(id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                        create: (_) => CategoryListViewModel()),
                  ],
                  child: const CategoryListView(),
                )));
    print("Test pressed!!!");
  }

  void _onVideo(id) {
    AppUtils().getAlert(context, ["App is Under Construction!"]);
  }

  Widget _getGridView() {
    List<HomeTilesModel> homeTilesModels = AppUtils.getHomeTilesModels();

    return homeTilesModels.isNotEmpty
        ? _getBody(homeTilesModels, _onVideo)
        : AppUtils.getLoader();
  }

  GridView _getBody(
      List<HomeTilesModel> homeTilesModels, void Function(dynamic id) onVideo) {
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
          } else {
            callBack = onVideo;
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
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: NetworkImage(AppUtils.getImageUrl(model.sliderUrl)),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget getFeedbackSlideshowContainer() {
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
    feedbackListViewModel.viewModels.forEach((viewModel) {
      widgets.add(_getFeedbackWidget(viewModel.getViewModel));
    });
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
            children: [_nameAndFeedbackWidget(model), _shareButton()],
          )),
        ],
      ),
    );
  }

  Container _nameAndFeedbackWidget(model) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 4),
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
      style: TextStyle(fontSize: 17),
      maxLines: 4,
    );
  }

  Text _getNameWidget(model) {
    return Text("${model.fullName}",
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 1));
  }

  Container _shareButton() {
    return Container(
      padding: const EdgeInsets.only(left: 150),
      child: Row(
        children: [
          Align(
            child: TextButton.icon(
              // <-- TextButton
              onPressed: () {},
              icon: const Icon(
                Icons.share,
                size: 20.0,
              ),
              label: const Text('SHARE'),
            ),
          ),
        ],
      ),
    );
  }

  Container _feedbackCardContainer(model) {
    return Container(
      height: 70,
      width: 70,
      //padding: EdgeInsets.only(top: 0),
      margin: const EdgeInsets.only(bottom: 100, left: 10),
      decoration: const BoxDecoration(
        image: DecorationImage(
          scale: 5,
          image: AssetImage("assets/images/profile-image.png"),
          fit: BoxFit.fill,
        ),
        color: Colors.white,
        shape: BoxShape.circle,
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
