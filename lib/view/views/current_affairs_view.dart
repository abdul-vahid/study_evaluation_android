// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:study_evaluation/models/current_affairs_model.dart';
import 'package:study_evaluation/utils/function_lib.dart';
import 'package:study_evaluation/utils/video_player.dart';
import 'package:study_evaluation/view_models/current_affairs_list_vm.dart';
import 'package:url_launcher/url_launcher.dart';
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
      int i = 0;
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
                // ignore: prefer_interpolation_to_compose_strings

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
                    Share.share(
                        '${AppConstants.baseUrl}${AppConstants.publicPath}/${currentAffairsModel?.documentUrl}',
                        subject: 'Welcome Message')
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

  Padding _getCurrentAffairsModelVideo(videoUrl) {
    //initVideo(videoUrl);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: const BoxDecoration(color: Colors.white,
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
        child: _VideoPlayer(
            "${AppConstants.baseUrl}${AppConstants.publicPath}/$videoUrl"));
  }
}

class _VideoPlayer extends StatefulWidget {
  String videoUrl;
  _VideoPlayer(this.videoUrl);

  @override
  _VideoPlayerState createState() => _VideoPlayerState(videoUrl);
}

class _VideoPlayerState extends State<_VideoPlayer> {
  String videoUrl;
  _VideoPlayerState(this.videoUrl);
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(videoUrl)
      ..initialize().then((value) {
        debug("videoUrl = $videoUrl");
        _controller.addListener(() {
          setState(() {});
        });
        _controller.setLooping(true);
        _controller.pause();
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          // Container(
          //   padding: const EdgeInsets.only(top: 20.0),
          // ),
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                VideoPlayer(_controller),
                _ControlsOverlay(controller: _controller),
                VideoProgressIndicator(
                  _controller,
                  allowScrubbing: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);

  static const List<Duration> _exampleCaptionOffsets = <Duration>[
    Duration(seconds: -10),
    Duration(seconds: -3),
    Duration(seconds: -1, milliseconds: -500),
    Duration(milliseconds: -250),
    Duration.zero,
    Duration(milliseconds: 250),
    Duration(seconds: 1, milliseconds: 500),
    Duration(seconds: 3),
    Duration(seconds: 10),
  ];
  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        Align(
          alignment: Alignment.topLeft,
          child: PopupMenuButton<Duration>(
            initialValue: controller.value.captionOffset,
            tooltip: 'Caption Offset',
            onSelected: (Duration delay) {
              controller.setCaptionOffset(delay);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<Duration>>[
                for (final Duration offsetDuration in _exampleCaptionOffsets)
                  PopupMenuItem<Duration>(
                    value: offsetDuration,
                    child: Text('${offsetDuration.inMilliseconds}ms'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.captionOffset.inMilliseconds}ms'),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (double speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<double>>[
                for (final double speed in _examplePlaybackRates)
                  PopupMenuItem<double>(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.playbackSpeed}'),
            ),
          ),
        ),
      ],
    );
  }
}
