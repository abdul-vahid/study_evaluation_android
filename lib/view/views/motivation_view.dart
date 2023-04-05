// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_evaluation/models/quote_model.dart';
import 'package:study_evaluation/utils/app_utils.dart';
import 'package:study_evaluation/utils/video_player.dart';
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
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  var baseListViewModel;
  QuoteModel? quoteModel;
  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      var userModel = AppUtils.getSessionUser(prefs);
      userModel ?? AppUtils.logout(context);
    });
    super.initState();

    Provider.of<QuoteListViewModel>(context, listen: false)
        .fetch(filterDate: currentDate);
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

      if (viewModel.model.pdfUrl != null) {
        tempWidgets.add(_bottomSheet(viewModel.model));
      }

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
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
              onPressed: () {
                AppUtils.openDocument(context, quoteModel?.pdfUrl);
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
                        '${AppConstants.baseUrl}${AppConstants.publicPath}/${quoteModel?.pdfUrl}',
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

  Padding _getQuote(quoteModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8, right: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 10, right: 10, bottom: 18),
                          child: Text(
                            (quoteModel?.quote)!,
                            style: _getTextStyle(), //Textstyle
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 40,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 8.0, bottom: 8),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Share.share('${(quoteModel?.quote)!}',
                                        subject: 'Welcome Message');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    minimumSize: Size.zero, // Set this
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0)),
                                  ),
                                  child: Row(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'SHARE',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ), // <-- Text

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0.0, top: 2, bottom: 2),
                                        child: CircleAvatar(
                                          child: Icon(
                                            // <-- Icon
                                            Icons.share,
                                            size: 15.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        /*Container(
                          height: 40,
                          width: 160,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: StadiumBorder(),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 5,
                                ),
                                Text('S H A R E',style: TextStyle(fontSize: 15,color: Colors.black),), // <-- Text
                                SizedBox(
                                  width: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    child:Icon(
                                    // <-- Icon
                                    Icons.share,
                                    size: 15.0,
                                    color: Colors.white,
                                  ),
                                  ),
                                ),
                                
                              ],
                            ),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    // return Padding(
    //   padding: const EdgeInsets.all(20.0),
    //   child: Container(
    //     height: 180,
    //     width: 350,
    //     decoration: BoxDecoration(
    //       borderRadius: const BorderRadius.only(
    //         topLeft: Radius.circular(20),
    //         bottomRight: Radius.circular(20),
    //       ),
    //       color: AppColor.motivationCar1Color,
    //     ),
    //     child: Padding(
    //       padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
    //       child: Column(
    //         children: [
    //           // Text(''),
    //           Text(
    //             (quoteModel?.quote)!,
    //             style: _getTextStyle(), //Textstyle
    //           ),
    //           Align(
    //             alignment: Alignment.bottomRight,
    //             child: ElevatedButton.icon(
    //               style: ElevatedButton.styleFrom(
    //                   shape: RoundedRectangleBorder(
    //                       borderRadius: BorderRadius.circular(20)),
    //                   backgroundColor: Colors.white),
    //               onPressed: (() {
    //                 Share.share('${(quoteModel?.quote)!}',
    //                     subject: 'Welcome Message');
    //               }),
    //               label: const Text(
    //                 'SHARE',
    //                 style: TextStyle(color: Colors.black, fontSize: 12),
    //               ),
    //               icon: Icon(
    //                 Icons.share,
    //                 size: 12,
    //                 color: AppColor.navBarIconColor,
    //               ),
    //             ),
    //           ),
    //           //
    //         ],
    //       ),
    //     ),
    //   ),
    // );
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

  Container _getQuoteVideo(videoUrl) {
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
