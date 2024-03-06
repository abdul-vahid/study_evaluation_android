import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../../models/latest_news_model.dart';
import '../../utils/app_color.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_utils.dart';
import '../../utils/video_player.dart';
import '../../view_models/latest_news_list_vm.dart';

class LatestNewsView extends StatefulWidget {
  const LatestNewsView({super.key});

  @override
  State<LatestNewsView> createState() => _LatestNewsViewState();
}

class _LatestNewsViewState extends State<LatestNewsView> {
  late VideoPlayerController controller;

  LatestNewsListViewModel? baseListViewModel;
  LatestNewsModel? latestNewsModel;
  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      var userModel = AppUtils.getSessionUser(prefs);
      userModel ?? AppUtils.logout(context);
    });
    super.initState();

    Provider.of<LatestNewsListViewModel>(context, listen: false).fetch();
  }

  void initVideo(videoUrl) {
    controller = VideoPlayerController.network(videoUrl);
    controller.addListener(() {
      setState(() {});
    });
    controller.setLooping(true);
    controller.initialize().then((_) => setState(() {}));
    controller.play();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    baseListViewModel = Provider.of<LatestNewsListViewModel>(context);

    return Scaffold(
        appBar: AppBar(
            leading: const BackButton(color: Colors.white),
            backgroundColor: AppColor.appBarColor,
            centerTitle: true,
            title: const Text(
              'Latest Exam News',
            )),
        body: AppUtils.getAppBody(baseListViewModel!, _getBody));
  }

  //Center _getLoader() => Center(child: const CircularProgressIndicator());
  //Center _noRecord() => const Center(child: Text("No Record Found!!"));

  SingleChildScrollView _getBody() {
    return SingleChildScrollView(
        child: Column(
      children: [
        _gelatestNewsVideoWidget(),
        const SizedBox(
          height: 10,
        ),
      ],
    ));
  }

  Container _gelatestNewsVideoWidget() {
    return Container(child: Column(children: _getLatestNewsVideoWidgets));
  }

  List<Widget> get _getLatestNewsVideoWidgets {
    List<Widget> widgets = [];
    baseListViewModel?.latestNewsData.forEach((key, viewModels) {
      List<Widget> videoBottomSheetWidgets = [];

      for (var viewModel in viewModels) {
        List<Widget> tempWidgets = [];
        LatestNewsModel model = viewModel.model as LatestNewsModel;
        if (model.title != null) {
          tempWidgets.add(getTitle(model.title));
        }
        if (model.imageUrl != null) {
          tempWidgets.add(getImage(model.imageUrl));
        }
        if (model.videoUrl != null && (model.videoUrl?.endsWith(".mp4"))!) {
          tempWidgets.add(_getLatestNewsModelVideo(model.videoUrl));
        }
        if (model.pdfUrl != null) {
          tempWidgets.add(_bottomSheet(model));
        }

        videoBottomSheetWidgets.add(Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 5,
            child: Column(
              children: tempWidgets,
            ),
          ),
        ));
      }
      widgets.addAll(videoBottomSheetWidgets);
    });

    return widgets;
  }

  Padding _bottomSheet(latestNewsModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
              onPressed: () async {
                AppUtils.openDocument(context, latestNewsModel?.pdfUrl);
              },
              icon: const Icon(
                Icons.picture_as_pdf,
                color: Colors.black,
                size: 15,
              ),
              label: const Text(
                'View PDF',
                style: TextStyle(color: Color(0xFFFB83ADC), fontSize: 15),
              )),
          TextButton.icon(
              onPressed: () => {
                    Share.share(
                        '${AppConstants.baseUrl}${AppConstants.publicPath}/${latestNewsModel?.documentUrl}',
                        subject: 'Welcome Message')
                  },
              icon: const Icon(
                Icons.share,
                color: Colors.black,
                size: 15,
              ),
              label: const Text(
                'SHARE',
                style: TextStyle(color: Colors.black, fontSize: 15),
              )),
        ],
      ),
    );
  }

  TextStyle _getTextStyle() {
    return const TextStyle(
      fontSize: 18,
      // fontStyle: FontStyle.italic,
      color: Colors.white,
    );
  }

  Container getTextContainer(String label) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Center(
          child: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          // color: AppColor.primaryColor,
        ),
      )),
    );
  }

  Padding getTitle(title) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        title,
        style: const TextStyle(
            color: AppColor.textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Padding getImage(image) {
    var url = AppUtils.getImageUrl(image);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.fill,
              )),
          //  color: Color.fromARGB(255, 209, 208, 210),
        ),
      ),
    );
  }

  Container _getLatestNewsModelVideo(videoUrl) {
    //initVideo(videoUrl);
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          //  borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                //offset: Offset(0, 0),
                blurRadius: 5,
                spreadRadius: 1)
          ]),
      child: Column(
        children: [
          // Text(''),
          _getVideoContainer(videoUrl),

          //
        ],
      ),
    );
  }

  Container _getVideoContainer(videoUrl) {
    return Container(
        // height: 2,
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: AppVideoPlayer(
            "${AppConstants.baseUrl}${AppConstants.publicPath}/$videoUrl"));
  }
}
