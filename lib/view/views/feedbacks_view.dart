// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_utils.dart';

class FeedBacksView extends StatefulWidget {
  const FeedBacksView({super.key});

  @override
  State<FeedBacksView> createState() => _FeedBacksViewState();
}

class _FeedBacksViewState extends State<FeedBacksView> {
  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      var userModel = AppUtils.getSessionUser(prefs);
      userModel ?? AppUtils.logout(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppUtils.getAppbar("Feedbacks",
            leading: const BackButton(
              color: Colors.white,
            )),
        body: SingleChildScrollView(
          // scrollDirection: Axis.vertical,
          child: Column(
            children: [
              getCards(),
              getCards(),
              getCards(),
              getCards(),
              getCards(),
            ],
          ),
        ));
  }
}

getCards() {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Card(
        color: Colors.white,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 20, bottom: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
                    radius: 35,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 15),
                        child: Text(
                          'Demo Use',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          'The word pollution was derived from the Latin word pollution, which means to make dirty. Pollution is the process of making the environment pollute the water and the air by adding harmful substances.',
                          style: TextStyle(
                            color: Color.fromRGBO(97, 97, 97, 1),
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
  );
}
