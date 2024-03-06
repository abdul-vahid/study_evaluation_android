// ignore_for_file: prefer_const_constructors, sort_child_properties_last, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'package:study_evaluation/view/views/package_detail_view.dart';
import '../../utils/app_utils.dart';
import '../../view_models/package_list_vm.dart';

class SuccessView extends StatefulWidget {
  String? success;
  String? packageLineItemId;
  SuccessView({super.key, this.success, required this.packageLineItemId});

  @override
  State<SuccessView> createState() => _SuccessViewState();
}

class _SuccessViewState extends State<SuccessView> {
  @override
  Widget build(BuildContext context) {
    AppUtils.currentContext = context;
    return Scaffold(
        appBar: AppUtils.getAppbar("${widget.success}", leading: BackButton(
          //color: backBtnColor,
          onPressed: () {
            onButtonPressed(widget.packageLineItemId);
          },
        )),
        body: widget.success == 'success'
            ? WillPopScope(
                onWillPop: () {
                  return onButtonPressed(widget.packageLineItemId);
                },
                child: Center(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 400,
                          width: 400,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 40,
                              ),
                              CircleAvatar(
                                child: Icon(
                                  Icons.check_circle_rounded,
                                  color: Colors.white,
                                  size: 120,
                                ),
                                radius: 60,
                                backgroundColor: Colors.green,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Thank You!',
                                  style: TextStyle(
                                      fontSize: 45,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green)),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Your payment was successfully!',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                  'You will be redirect to the Package Detail Page shortly \n        or click here to return to Package Detail Page!',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  height: 50,
                                  width: 200,
                                  //margin: EdgeInsets.symmetric(horizontal: 50),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.green),
                                  child: TextButton(
                                      onPressed: () {
                                        onButtonPressed(
                                            widget.packageLineItemId);
                                      },
                                      child: Text(
                                        'Back',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 400,
                        width: 400,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            CircleAvatar(
                              child: Icon(
                                Icons.cancel,
                                color: Colors.white,
                                size: 120,
                              ),
                              radius: 60,
                              backgroundColor: Colors.red,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Payment Failed!',
                                style: TextStyle(
                                    fontSize: 45,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Text('Payment done Successfully!',
                            //     style: TextStyle(
                            //         fontSize: 15,
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.black)),
                            SizedBox(
                              height: 20,
                            ),
                            Text('Your payment failed try again!',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                height: 50,
                                width: 200,
                                //margin: EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.red),
                                child: TextButton(
                                    onPressed: () {
                                      onButtonPressed(widget.packageLineItemId);
                                    },
                                    child: Text(
                                      'Back',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ))),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ));
  }

  Future<bool> onButtonPressed(id) async {
    Navigator.of(context).pop();
    Navigator.of(context).pop();

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
                create: (_) => PackageListViewModel(),
                child: PackageDetailView(
                  packageLineItemId: id,
                ),
              ),
          settings: RouteSettings(arguments: 9)),
    );

    return false;
  }

//   Future<dynamic> _navigateToHomeView(BuildContext context) {

//     if( widget.bookingType  == BookingTypeConstants.roomBooking) {
//       return Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//             builder: (context) => MultiProvider(
//                   providers: [
//                     ChangeNotifierProvider(
//                         create: (_) => OrderDetailListViewModel()),
//                     ChangeNotifierProvider(
//                         create: (_) => OrderCancelListViewModel()),
//                   ],
//                   child: PropertyBookingDetailView(widget.bookingId),
//                   // isCancallation),
//                 )));
//     }else{
//       return Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => MultiProvider(
//                       providers: [
//                         ChangeNotifierProvider(
//                             create: (_) =>
//                                 OrderDetailListViewModel())
//                       ],
//                       child: MembershipBookingDetailView(
//                           widget.bookingId,bookingType: widget.bookingType ,membershipId: widget.membershipId,)))
//         );
//     }
//   }
// }
}
