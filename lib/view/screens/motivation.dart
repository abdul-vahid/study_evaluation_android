import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../utils/app_color.dart';

class MotivationScreen extends StatefulWidget {
  const MotivationScreen({super.key});

  @override
  State<MotivationScreen> createState() => _MotivationScreenState();
}

class _MotivationScreenState extends State<MotivationScreen> {
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
            'Motivation',
          )),
      body: SingleChildScrollView(
          child: Column(
        children: [
          getMotivationalImage(),
          getTextContainer('Quotes of The Day'),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 160,
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
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
                  const Text(
                    'Emptiness comes as sunset comes of an evening, full of beauty, enchanment and richness, it comes as naturall as the blossoming of a flower.',
                    style: TextStyle(
                      fontSize: 18,
                      // fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ), //Textstyle
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: Colors.white),
                      onPressed: (() {}),
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
          SizedBox(
            height: 10,
          ),
          Container(
            height: 150,
            width: 350,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: AppColor.selectedItemColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                children: [
                  // Text(''),
                  const Text(
                    'दर्द, गम, डर जो भी है बस तेरे अंदर हैं. खुद के बनाये पिंजरे से निकल कर देख तू भी एक सिकंदर हैं.',
                    style: TextStyle(
                      fontSize: 18,
                      // fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ), //Textstyle
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: Colors.white),
                      onPressed: (() {}),
                      label: const Text(
                        'SHARE',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      icon: Icon(
                        Icons.share,
                        color: AppColor.navBarIconColor,
                        size: 12,
                      ),
                    ),
                  ),
                  //
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          getTextContainer('Motivational Video'),
          SizedBox(
            height: 10,
          ),
          getMotivationVideo(),
          getMotivationVideo(),
          getMotivationVideo(),
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

  Container getTextContainer(String label) {
    return Container(
      child: Center(
          child: Text(
        label,
        style: TextStyle(
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
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              image: DecorationImage(
                image: new AssetImage("assets/images/motivational.png"),
                fit: BoxFit.fill,
              )),
          //  color: Color.fromARGB(255, 209, 208, 210),
        ),
      ),
    );
  }

  Padding getMotivationVideo() {
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
