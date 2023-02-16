import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../utils/app_color.dart';

class CurrentAffairScreen extends StatefulWidget {
  const CurrentAffairScreen({super.key});

  @override
  State<CurrentAffairScreen> createState() => _CurrentAffairScreenState();
}

class _CurrentAffairScreenState extends State<CurrentAffairScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: "yI_txg4AZNI",
      flags: YoutubePlayerFlags(
        autoPlay: false,
        // mute: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(color: Colors.white),
          backgroundColor: AppColor.appBarColor,
          centerTitle: true,
          title: const Text(
            'Current Affairs',
          )),
      body: SingleChildScrollView(
          child: Column(
        children: [
          getCurrentAffairsVideo(),
          getCurrentAffairsVideo(),
          getCurrentAffairsVideo(),
          getCurrentAffairsVideo(),
          getCurrentAffairsVideo(),
          getCurrentAffairsVideo(),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 40,
            color: AppColor.containerBoxColor,
          )
        ],
      )),
    );
  }

  Padding getCurrentAffairsVideo() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(children: [
        Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
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
                  Container(
                    // height: 2,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                          onPressed: () => {},
                          icon: Icon(
                            Icons.picture_as_pdf,
                            color: Colors.black,
                            size: 10,
                          ),
                          label: Text(
                            'View PDF',
                            style: TextStyle(
                                color: Color(0xFFFB83ADC), fontSize: 10),
                          )),
                      TextButton.icon(
                          onPressed: () => {},
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
                  )

                  //
                ],
              ),
            )),
        SizedBox(
          width: 10,
        ),
        Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
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
                  Container(
                    // height: 2,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                          onPressed: () => {},
                          icon: Icon(
                            Icons.picture_as_pdf,
                            color: Colors.black,
                            size: 10,
                          ),
                          label: Text(
                            'View PDF',
                            style: TextStyle(
                                color: Color(0xFFFB83ADC), fontSize: 10),
                          )),
                      TextButton.icon(
                          onPressed: () => {},
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
                  )

                  //
                ],
              ),
            )),
      ]),
    );
  }
}
