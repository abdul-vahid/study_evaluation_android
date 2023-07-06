// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/models/current_affairs_model.dart';
import 'package:study_evaluation/utils/function_lib.dart';
import 'package:study_evaluation/utils/video_player.dart';
import 'package:study_evaluation/view_models/current_affairs_list_vm.dart';
import 'package:video_player/video_player.dart';
import '../../utils/app_color.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_utils.dart';

class CurrentAffairsView extends StatefulWidget {
  const CurrentAffairsView({super.key});

  @override
  State<CurrentAffairsView> createState() => _CurrentAffairsViewState();
}

class _CurrentAffairsViewState extends State<CurrentAffairsView> {
  late VideoPlayerController controller;

  CurrentAffairsListViewModel? baseListViewModel;
  CurrentAffairsModel? currentAffairsModel;
  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      var userModel = AppUtils.getSessionUser(prefs);
      userModel ?? AppUtils.logout(context);
    });
    super.initState();

    Provider.of<CurrentAffairsListViewModel>(context, listen: false).fetch();
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
    baseListViewModel = Provider.of<CurrentAffairsListViewModel>(context);

    return Scaffold(
        appBar: AppBar(
            leading: const BackButton(color: Colors.white),
            backgroundColor: AppColor.appBarColor,
            centerTitle: true,
            title: const Text(
              'Current Affairs',
            )),
        body: AppUtils.getAppBody(baseListViewModel!, _getBody));
  }

  //Center _getLoader() => Center(child: const CircularProgressIndicator());
  //Center _noRecord() => const Center(child: Text("No Record Found!!"));

  SingleChildScrollView _getBody() {
    return SingleChildScrollView(
        child: Column(
      children: [
        _getCurrentAffairVideoWidget(),

        //getTextContainer('Motivational Video'),

        const SizedBox(
          height: 10,
        ),
      ],
    ));
  }

  Container _getCurrentAffairVideoWidget() {
    return Container(child: Column(children: _getCurrentAffairVideoWidgets));
  }

  List<Widget> get _getCurrentAffairVideoWidgets {
    List<Widget> widgets = [];
    baseListViewModel?.currentAffairsData.forEach((key, viewModels) {
      List<Widget> videoBottomSheetWidgets = [];
      videoBottomSheetWidgets.add(Container(
          child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                key,
                style: const TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 18, fontWeight: FontWeight.bold,
                  color: AppColor.textColor,
                ),
              ),
            ),
            Divider(
              color: Colors.grey,
            ),
          ],
        ),
      )));
      for (var viewModel in viewModels) {
        List<Widget> tempWidgets = [];
        CurrentAffairsModel model = viewModel.model as CurrentAffairsModel;

        if (model.videoUrl != null && (model.videoUrl?.endsWith(".mp4"))!) {
          debug('Video URL : ${model.videoUrl}');

          tempWidgets.add(_getCurrentAffairsModelVideo(model.videoUrl));
        }

        if (model.documentUrl != null) {
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
      /* widgets.add(Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 5,
          child: Column(
            children: videoBottomSheetWidgets,
          ),
        ),
      )); */
    });

    return widgets;
  }

  Padding _bottomSheet(currentAffairsModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
              onPressed: () async {
                AppUtils.openDocument(
                    context, currentAffairsModel?.documentUrl);
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
                    if (currentAffairsModel?.videoUrl == null)
                      {
                        Share.share(
                            '${AppConstants.baseUrl}${AppConstants.publicPath}/${currentAffairsModel?.documentUrl}',
                            subject: 'Welcome Message')
                      }
                    else
                      {
                        Share.share(
                            '${AppConstants.baseUrl}${AppConstants.publicPath}/${currentAffairsModel?.documentUrl} \n  ${AppConstants.baseUrl}${AppConstants.publicPath}/${currentAffairsModel?.videoUrl}',
                            subject: 'Welcome Message')
                      }
                  },
              icon: Icon(
                Icons.share,
                color: Colors.black,
                size: 15,
              ),
              label: Text(
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

  Padding getMotivationalImage() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              image: DecorationImage(
                image: AssetImage("assets/images/motivational.png"),
                fit: BoxFit.fill,
              )),
          //  color: Color.fromARGB(255, 209, 208, 210),
        ),
      ),
    );
  }

  Container _getCurrentAffairsModelVideo(videoUrl) {
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
        child: /*  ElevatedButton(
          child: Text("Open"),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FullVideoPlayerView(
                        videoUrl:
                            "${AppConstants.baseUrl}${AppConstants.publicPath}/$videoUrl")));
          },
        )); */
            AppVideoPlayer(
                "${AppConstants.baseUrl}${AppConstants.publicPath}/$videoUrl"));
  }
}
