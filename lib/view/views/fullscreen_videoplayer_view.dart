import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:auto_orientation/auto_orientation.dart';

// ignore: must_be_immutable
class FullScreenVideoPlayerView extends StatefulWidget {
  String videoUrl;
  FullScreenVideoPlayerView({super.key, required this.videoUrl});

  @override
  // ignore: library_private_types_in_public_api
  _FullScreenVideoPlayerViewState createState() =>
      // ignore: no_logic_in_create_state
      _FullScreenVideoPlayerViewState(videoUrl);
}

class _FullScreenVideoPlayerViewState extends State<FullScreenVideoPlayerView> {
  String videoUrl;
  _FullScreenVideoPlayerViewState(this.videoUrl);
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _controller = VideoPlayerController.network(videoUrl);

    _initializeVideoPlayerFuture = _controller.initialize();

    // _controller.play();
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Container(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}
