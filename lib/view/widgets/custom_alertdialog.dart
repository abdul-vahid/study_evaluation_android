import 'package:flutter/material.dart';

class CustomAlertDialog extends StatefulWidget {
  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            // These values are based on trial & error method
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                  //color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.close,
                  color: Color(0xFF666666),
                ),
              ),
            ),
          ),
          Text(
            "Filter",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text("Rajasthan GK",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                        letterSpacing: 1)),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 1,
          ),
          //SizedBox(height: 10),
          Container(
            //  color: Colors.amberAccent,
            height: 120,

            child: GridView(
                padding: EdgeInsets.only(left: 20, right: 20, top: 5),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 5, crossAxisCount: 8, crossAxisSpacing: 5),
                children: [
                  getButton(),
                  getButton(),
                  getButton(),
                  getButton(),
                  getButton(),
                  getButton(),
                  getButton(),
                  getButton(),
                  getButton(),
                  getButton(),
                  getButton(),
                  getButton(),
                  getButton(),
                  getButton(),
                  getButton(),
                  getButton(),
                ]),
          ),

          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text("Rajasthan GK and GS",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                        letterSpacing: 1)),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 1,
          ),

          Container(
            //  color: Colors.amberAccent,
            height: 120,

            child: GridView(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 5, crossAxisCount: 8, crossAxisSpacing: 5),
                children: [
                  getButton(),
                  getButton(),
                  getButton(),
                  getButton(),
                  getButton(),
                  getButton(),
                  getButton(),
                  getButton(),
                  getButton(),
                  getButton(),
                  getButton(),
                  getButton(),
                  getButton(),
                  getButton(),
                  getButton(),
                  getButton(),
                ]),
          ),
        ],
      ),
    );
  }

  Container getButton() {
    return Container(
      width: 30.0,
      height: 30.0,
      padding: const EdgeInsets.all(10.0),
      decoration:
          new BoxDecoration(shape: BoxShape.circle, color: Color(0xFFdce5ff)),
      child: InkWell(
        onTap: () {
          // voidCallback();
        },
        child: Center(
          child: new Text('1',
              style: new TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0)),
        ),
      ),
    );
  }
}
