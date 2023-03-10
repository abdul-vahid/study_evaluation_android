// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:study_evaluation/models/quote_model.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/view_models/quote_list_vm.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/app_color.dart';
import 'package:video_player/video_player.dart';

import '../../utils/app_constants.dart';

class MotivationView extends StatefulWidget {
  const MotivationView({super.key});

  @override
  State<MotivationView> createState() => _MotivationViewState();
}

class _MotivationViewState extends State<MotivationView> {
  late VideoPlayerController controller;

  var baseListViewModel;
  QuoteModel? quoteModel;
  @override
  void initState() {
    super.initState();

    Provider.of<QuoteListViewModel>(context, listen: false)
        .fetch(filterDate: "22-02-2023");
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
    baseListViewModel = Provider.of<QuoteListViewModel>(context);
    //return quoteListVM.viewModels.isNotEmpty ? _getBody() : _getLoader();
    return Scaffold(
        appBar: AppUtils.getAppbar("Motivation",
            leading: const BackButton(color: Colors.white)),
        body: AppUtils.getAppBody(baseListViewModel, _getBody));
  }

  SingleChildScrollView _getBody() {
    return SingleChildScrollView(
        child: Column(
      children: [
        getMotivationalImage(),
        getTextContainer('Quotes of The Day'),
        const SizedBox(
          height: 20,
        ),

        _getQuoteVideoWidget(),

        //getTextContainer('Motivational Video'),

        const SizedBox(
          height: 10,
        ),
      ],
    ));
  }

  Container _getQuoteVideoWidget() {
    return Container(child: Column(children: _getQuoteVideoWidgets));
  }

  List<Widget> get _getQuoteVideoWidgets {
    List<Widget> widgets = [];

    for (var viewModel in baseListViewModel.viewModels) {
      List<Widget> tempWidgets = [];
      tempWidgets.add(_getQuote(viewModel.model));
      tempWidgets.add(
        const SizedBox(
          height: 10,
        ),
      );
      //widgets.add(_getQuoteVideo(videoUrl));
      if (viewModel.model.videoUrl != null &&
          viewModel.model.videoUrl.endsWith(".mp4")) {
        tempWidgets.add(_getQuoteVideo(viewModel.model.videoUrl));
      }
      tempWidgets.add(_bottomSheet(viewModel.model));

      widgets.add(Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          elevation: 5,
          child: Column(
            children: tempWidgets,
          ),
        ),
      ));
    }

    return widgets;
  }

  Padding _bottomSheet(quoteModel) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
              onPressed: () {
                final url = '${AppConstants.baseUrl}' +
                    '/study_evaluation/public/' +
                    '${quoteModel?.pdfUrl}';

                if (url.isNotEmpty) {
                  launch('${url}');
                } else {
                  throw 'Could not launch $url';
                }
                print('quoteModel?.quote Pdf ${quoteModel?.pdfUrl}');
              },
              icon: const Icon(
                Icons.picture_as_pdf,
                color: Colors.black,
                size: 10,
              ),
              label: const Text(
                'View PDF',
                style: TextStyle(color: Color(0xFFFB83ADC), fontSize: 10),
              )),
          TextButton.icon(
              onPressed: () => {
                    Share.share('com.example.share_app',
                        subject: 'Welcome Message')
                  },
              icon: Icon(
                Icons.share,
                color: Colors.black,
                size: 10,
              ),
              label: Text(
                'SHARE',
                style: TextStyle(color: Colors.black, fontSize: 10),
              )),
        ],
      ),
    );
  }

  Padding _getQuote(quoteModel) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 160,
        width: 350,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: AppColor.motivationCar1Color,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              // Text(''),
              Text(
                (quoteModel?.quote)!,
                style: _getTextStyle(), //Textstyle
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      backgroundColor: Colors.white),
                  onPressed: (() {
                    Share.share('com.example.share_app',
                        subject: 'Welcome Message');
                  }),
                  label: const Text(
                    'SHARE',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                  icon: Icon(
                    Icons.share,
                    size: 12,
                    color: AppColor.navBarIconColor,
                  ),
                ),
              ),
              //
            ],
          ),
        ),
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

  Padding _getQuoteVideo(videoUrl) {
    //initVideo(videoUrl);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Expanded(
          flex: 2,
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 10),
                      blurRadius: 10,
                      spreadRadius: 2)
                ]),
            child: Column(
              children: [
                // Text(''),
                _getVideoContainer(videoUrl),

                //
              ],
            ),
          )),
    );
  }

  Container _getVideoContainer(videoUrl) {
    return Container(
        // height: 2,
        padding: const EdgeInsets.all(5),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: _VideoPlayer(videoUrl));
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

    print('@@@@videoUrl ${videoUrl}');
    _controller = VideoPlayerController.network(videoUrl);

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
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
