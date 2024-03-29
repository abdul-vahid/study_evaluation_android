import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class AppVideoPlayer extends StatefulWidget {
  final String videoUrl;
  String? type;
  AppVideoPlayer(this.videoUrl, {super.key, this.type});

  @override
  AppVideoPlayerState createState() => AppVideoPlayerState();
}

class AppVideoPlayerState extends State<AppVideoPlayer> {
  String videoUrl = "";
  String? type;

  late FlickManager flickManager;
  @override
  void initState() {
    type = widget.type;
    videoUrl = widget.videoUrl;
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(videoUrl),
      autoPlay: false,
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.type.toString() == "buy"
          ? Container(
              child:
                  Image.asset('assets/images/no-video.png', fit: BoxFit.cover),
            )
          : FlickVideoPlayer(
              flickManager: flickManager,
            ),
    );
  }
}

  //AppVideoPlayerState(this.videoUrl); */
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     type = widget.type;
//     videoUrl = widget.videoUrl;
//     //_controller = VideoPlayerController.network(videoUrl);
//     _controller = VideoPlayerController.network(videoUrl)
//       ..initialize().then((_) {
//         setState(() {}); //when your thumbnail will show.
//       });
//     _controller.addListener(() {
//       setState(() {});
//     });
//     _controller.setLooping(false);
//     //_controller.initialize().then((_) => setState(() {}));
//     _controller.pause();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: <Widget>[
//           // Container(
//           //   padding: const EdgeInsets.only(top: 20.0),
//           // ),
//           AspectRatio(
//             aspectRatio: _controller.value.aspectRatio,
//             child: Stack(
//               alignment: Alignment.bottomCenter,
//               children: <Widget>[
//                 VideoPlayer(_controller),
//                 _ControlsOverlay(
//                   controller: _controller,
//                   type: widget.type,
//                   videoUrl: videoUrl,
//                 ),
//                 VideoProgressIndicator(
//                   _controller,
//                   allowScrubbing: true,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _ControlsOverlay extends StatefulWidget {
//   String? type = "";
//   String? videoUrl;
//   _ControlsOverlay(
//       {Key? key, required this.controller, this.type, this.videoUrl})
//       : super(key: key);

//   // static const List<Duration> _exampleCaptionOffsets = <Duration>[
//   //   Duration(seconds: -10),
//   //   Duration(seconds: -3),
//   //   Duration(seconds: -1, milliseconds: -500),
//   //   Duration(milliseconds: -250),
//   //   Duration.zero,
//   //   Duration(milliseconds: 250),
//   //   Duration(seconds: 1, milliseconds: 500),
//   //   Duration(seconds: 3),
//   //   Duration(seconds: 10),
//   // ];
//   // static const List<double> _examplePlaybackRates = <double>[
//   //   0.25,
//   //   0.5,
//   //   1.0,
//   //   1.5,
//   //   2.0,
//   //   3.0,
//   //   5.0,
//   //   10.0,
//   // ];

//   final VideoPlayerController controller;

//   @override
//   State<_ControlsOverlay> createState() => _ControlsOverlayState();
// }

// class _ControlsOverlayState extends State<_ControlsOverlay> {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         AnimatedSwitcher(
//           duration: const Duration(milliseconds: 50),
//           reverseDuration: const Duration(milliseconds: 200),
//           child: widget.controller.value.isPlaying
//               ? const SizedBox.shrink()
//               : Container(
//                   color: Colors.black26,
//                   child: const Center(
//                     child: Icon(
//                       Icons.play_arrow,
//                       color: Colors.white,
//                       size: 100.0,
//                       semanticLabel: 'Play',
//                     ),
//                   ),
//                 ),
//         ),
//         GestureDetector(
//           onTap: () {
//             if (widget.type.toString() == "buy") {
//               AppUtils.getAlert(
//                   context, ["Please buy the package to play the Video"]);
//             } else {
//               widget.controller.value.isPlaying
//                   ? widget.controller.pause()
//                   : widget.controller.play();
//             }
//           },
//         ),
//         // Align(
//         //   alignment: Alignment.bottomRight,
//         //   child: IconButton(
//         //     iconSize: 40,
//         //     color: Colors.white,
//         //     icon: const Icon(Icons.fullscreen),
//         //     onPressed: () {
//         //       controller.pause();
//         //       Navigator.push(
//         //         context,
//         //         MaterialPageRoute(
//         //             builder: (context) => FullScreenVideoPlayerView(
//         //                 videoUrl: videoUrl.toString())),
//         //       );
//         //     },
//         //   ),
//         // )
//         // Align(
//         //   alignment: Alignment.topLeft,
//         //   child: PopupMenuButton<Duration>(
//         //     initialValue: controller.value.captionOffset,
//         //     tooltip: 'Caption Offset',
//         //     onSelected: (Duration delay) {
//         //       controller.setCaptionOffset(delay);
//         //     },
//         //     itemBuilder: (BuildContext context) {
//         //       return <PopupMenuItem<Duration>>[
//         //         for (final Duration offsetDuration in _exampleCaptionOffsets)
//         //           PopupMenuItem<Duration>(
//         //             value: offsetDuration,
//         //             child: Text('${offsetDuration.inMilliseconds}ms'),
//         //           )
//         //       ];
//         //     },
//         //     child: Padding(
//         //       padding: const EdgeInsets.symmetric(
//         //         // Using less vertical padding as the text is also longer
//         //         // horizontally, so it feels like it would need more spacing
//         //         // horizontally (matching the aspect ratio of the video).
//         //         vertical: 12,
//         //         horizontal: 16,
//         //       ),
//         //       child: Text('${controller.value.captionOffset.inMilliseconds}ms'),
//         //     ),
//         //   ),
//         // ),
//         // Align(
//         //   alignment: Alignment.topRight,
//         //   child: PopupMenuButton<double>(
//         //     initialValue: controller.value.playbackSpeed,
//         //     tooltip: 'Playback speed',
//         //     onSelected: (double speed) {
//         //       controller.setPlaybackSpeed(speed);
//         //     },
//         //     itemBuilder: (BuildContext context) {
//         //       return <PopupMenuItem<double>>[
//         //         for (final double speed in _examplePlaybackRates)
//         //           PopupMenuItem<double>(
//         //             value: speed,
//         //             child: Text('${speed}x'),
//         //           )
//         //       ];
//         //     },
//         //     child: Padding(
//         //       padding: const EdgeInsets.symmetric(
//         //         vertical: 12,
//         //         horizontal: 16,
//         //       ),
//         //       child: Text('${controller.value.playbackSpeed}'),
//         //     ),
//         //   ),
//         // ),
//       ],
//     );
//   }
// }
