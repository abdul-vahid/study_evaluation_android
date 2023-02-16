import 'package:flutter/material.dart';
import 'package:study_evaluation/view/views/contable_screen.dart';

import '../../utils/app_color.dart';

class TestSeriesScreen extends StatefulWidget {
  const TestSeriesScreen({super.key});

  @override
  State<TestSeriesScreen> createState() => _TestSeriesScreenState();
}

class _TestSeriesScreenState extends State<TestSeriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(color: Colors.white),
        title: Text("Test Series"),
        elevation: .1,
        backgroundColor: AppColor.appBarColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 800.0,
              // padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              child: GridView.count(
                crossAxisCount: 3,
                // padding: EdgeInsets.all(2.0),
                children: <Widget>[
                  makeDashboardItem(
                      "Contable",
                      Image.asset('assets/images/contable.png'),
                      55.0,
                      41.0,
                      onButtonPressed),
                  makeDashboardItem(
                      "Combo Offer",
                      Image.asset('assets/images/combo-offer.png'),
                      82.0,
                      49.0,
                      onButtonPressed),
                  makeDashboardItem(
                      "CET(12+2)",
                      Image.asset('assets/images/cet(12+2).png'),
                      100.0,
                      80.0,
                      onButtonPressed),
                  makeDashboardItem(
                      "Contable",
                      Image.asset('assets/images/contable.png'),
                      55.0,
                      41.0,
                      onButtonPressed),
                  makeDashboardItem(
                      "Combo Offer",
                      Image.asset('assets/images/combo-offer.png'),
                      82.0,
                      49.0,
                      onButtonPressed),
                  makeDashboardItem(
                      "CET(12+2)",
                      Image.asset('assets/images/cet(12+2).png'),
                      49.0,
                      46.0,
                      onButtonPressed),
                  makeDashboardItem(
                      "Contable",
                      Image.asset('assets/images/contable.png'),
                      55.0,
                      41.0,
                      onButtonPressed),
                  makeDashboardItem(
                      "Combo Offer",
                      Image.asset('assets/images/combo-offer.png'),
                      82.0,
                      49.0,
                      onButtonPressed),
                  makeDashboardItem(
                      "CET(12+2)",
                      Image.asset('assets/images/cet(12+2).png'),
                      49.0,
                      46.0,
                      onButtonPressed),
                  makeDashboardItem(
                      "Contable",
                      Image.asset('assets/images/contable.png'),
                      55.0,
                      41.0,
                      onButtonPressed),
                  makeDashboardItem(
                      "Combo Offer",
                      Image.asset('assets/images/combo-offer.png'),
                      82.0,
                      49.0,
                      onButtonPressed),
                  makeDashboardItem(
                      "CET(12+2)",
                      Image.asset('assets/images/cet(12+2).png'),
                      49.0,
                      46.0,
                      onButtonPressed),
                  makeDashboardItem(
                      "Contable",
                      Image.asset('assets/images/contable.png'),
                      55.0,
                      41.0,
                      onButtonPressed),
                  makeDashboardItem(
                      "Combo Offer",
                      Image.asset('assets/images/combo-offer.png'),
                      82.0,
                      49.0,
                      onButtonPressed),
                  makeDashboardItem(
                      "CET(12+2)",
                      Image.asset('assets/images/cet(12+2).png'),
                      49.0,
                      46.0,
                      onButtonPressed),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              color: AppColor.containerBoxColor,
            )
          ],
        ),
      ),
    );
  }

  void onButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ContableScreen()),
    );
    print("Login Button pressed!!!");
  }

  Card makeDashboardItem(String title, Image image, double width, double height,
      VoidCallback voidCallback) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.only(left: 15, top: 15, bottom: 10, right: 15),
        child: InkWell(
          onTap: () {
            voidCallback();
          },
          child: Column(children: [
            // InkWell(
            //   onTap: () {},
            // ),
            Expanded(
              flex: 3,
              child: Container(
                child: image,
                height: height,
                width: width,
              ),
            ),
            Expanded(
                child: Container(
                    decoration:
                        BoxDecoration(color: AppColor.containerBoxColor),
                    child: Center(
                        child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ))))
          ]),
        ));
  }
}
