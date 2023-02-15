import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_evaluation/view/screens/rajasthanconstablespecial_screen.dart';
import 'package:study_evaluation/view/screens/testseries.dart';
import 'package:study_evaluation/viewmodel/package_view_model/package_list_vm.dart';

import '../../utils/app_color.dart';

class PackageListView extends StatefulWidget {
  const PackageListView({super.key});

  @override
  State<PackageListView> createState() => _PackageListViewState();
}

class _PackageListViewState extends State<PackageListView> {
  @override
  void initState() {
    super.initState();
    final id = ModalRoute.of(context)!.settings.arguments;
    Provider.of<PackageListViewModel>(context, listen: false)
        .fetch(categoryId: id);
  }

  @override
  Widget build(BuildContext context) {
    final packageListVM = Provider.of<PackageListViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(color: Colors.white),
        title: Text("Constable"),
        elevation: .1,
        backgroundColor: AppColor.appBarColor,
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        getPadding(context),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 220,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
              child: InkWell(
                onTap: () {
                  onButtonPressed();
                },
                child: Column(
                  children: [
                    Container(
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColor.containerBoxColor,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(8.0),
                            topLeft: Radius.circular(8.0)),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 80,
                          width: 120,
                          //padding: EdgeInsets.only(top: 0),
                          margin: EdgeInsets.only(bottom: 50, left: 5),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              scale: 5,
                              image: AssetImage(
                                  "assets/images/rajasthan-constable.png"),
                              fit: BoxFit.fill,
                            ),
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                  "Rajasthan Constable 10 New Test Series",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      letterSpacing: 1)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                maxLines: 8,
                              ),
                            ),
                          ],
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 300,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 40,
            color: AppColor.containerBoxColor,
          ),
        )
      ])),
    );
  }

  Padding getPadding(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 220,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: InkWell(
            onTap: () {
              onButtonPressed();
            },
            child: Column(
              children: [
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: AppColor.containerBoxColor,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8.0),
                        topLeft: Radius.circular(8.0)),
                  ),
                ),
                Row(
                  children: [
                    getContainer(),
                    getContainer2(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded getContainer2() {
    return Expanded(
        child: Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("Rajasthan Constable Special",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 1)),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
            maxLines: 8,
          ),
        ),
      ],
    ));
  }

  Container getContainer() {
    return Container(
      height: 80,
      width: 120,
      //padding: EdgeInsets.only(top: 0),
      margin: EdgeInsets.only(bottom: 50, left: 5),
      decoration: BoxDecoration(
        image: DecorationImage(
          scale: 5,
          image: AssetImage("assets/images/contable.png"),
          fit: BoxFit.fill,
        ),
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }

  void onButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const RajasthanConstableSpecialScreen()),
    );
    print("Login Button pressed!!!");
  }
}
