import 'package:flutter/material.dart';

import '../../utils/app_color.dart';

class MyOrderView extends StatefulWidget {
  const MyOrderView({super.key});

  @override
  State<MyOrderView> createState() => _MyOrderViewState();
}

class _MyOrderViewState extends State<MyOrderView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(color: Colors.white),
        title: Text("My Order"),
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
                crossAxisCount: 2,
                // padding: EdgeInsets.all(2.0),
                children: <Widget>[
                  makeDashboardItem(
                      "₹499",
                      Image.asset('assets/images/contable.png'),
                      80.0,
                      80.0,
                      onButtonPressed),
                  makeDashboardItem(
                      "₹499",
                      Image.asset('assets/images/contable.png'),
                      80.0,
                      80.0,
                      onButtonPressed),
                  makeDashboardItem(
                      "₹499",
                      Image.asset('assets/images/contable.png'),
                      80.0,
                      80.0,
                      onButtonPressed),
                  makeDashboardItem(
                      "₹499",
                      Image.asset('assets/images/contable.png'),
                      80.0,
                      80.0,
                      onButtonPressed),
                  makeDashboardItem(
                      "₹499",
                      Image.asset('assets/images/contable.png'),
                      80.0,
                      80.0,
                      onButtonPressed),
                  makeDashboardItem(
                      "₹499",
                      Image.asset('assets/images/contable.png'),
                      80.0,
                      80.0,
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
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const ContableScreen()),
    // );
    // print("Login Button pressed!!!");
  }

  Card makeDashboardItem(String title, Image image, double width, double height,
      VoidCallback voidCallback) {
    return Card(
        elevation: 1.0,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(15.0),
        // ),
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
              child: Column(
                children: [
                  Container(
                    height: 5,
                    color: AppColor.appBarColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: image,
                    height: height,
                    width: width,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Rajasthan Constable Special',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            Expanded(
                child: Container(
                    decoration:
                        BoxDecoration(color: AppColor.containerBoxColor),
                    child: Center(
                        child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ))))
          ]),
        ));
  }
}
