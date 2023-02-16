import 'package:flutter/material.dart';

import '../../utils/app_color.dart';

class LearderbordView extends StatefulWidget {
  const LearderbordView({super.key});

  @override
  State<LearderbordView> createState() => _LearderbordViewState();
}

class _LearderbordViewState extends State<LearderbordView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: BackButton(color: Colors.white),
          title: Text("Leardebord"),
          elevation: .1,
          backgroundColor: AppColor.appBarColor,
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Card(
                child: ListTile(
              title: Text(
                "Nurcahyo Budi",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "300 Marks",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://m.media-amazon.com/images/M/MV5BNjE3NDQyOTYyMV5BMl5BanBnXkFtZTcwODcyODU2Mw@@._V1_UY209_CR5,0,140,209_AL_.jpg")),
              trailing: Text(
                '#1',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )),
            Card(
                child: ListTile(
              title: Text(
                "Rika Wahyuni",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "290 Marks",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://m.media-amazon.com/images/M/MV5BMjJkNDg5ZDctM2RlZS00NjFmLTkxZjktMWE5NGQzMDg4NDFhXkEyXkFqcGdeQXVyMTMwMDM1OTQ@._V1_UY209_CR6,0,140,209_AL_.jpg")),
              trailing: Text(
                '#2',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )),
            Card(
                child: ListTile(
              title: Text(
                "Alarm",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "280 Marks",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://m.media-amazon.com/images/M/MV5BNjE3NDQyOTYyMV5BMl5BanBnXkFtZTcwODcyODU2Mw@@._V1_UY209_CR5,0,140,209_AL_.jpg")),
              trailing: Text(
                '#3',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )),
            Card(
                child: ListTile(
              title: Text(
                "Ballot",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "200 Marks",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://m.media-amazon.com/images/M/MV5BNjE3NDQyOTYyMV5BMl5BanBnXkFtZTcwODcyODU2Mw@@._V1_UY209_CR5,0,140,209_AL_.jpg")),
              trailing: Text(
                '#4',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )),
            Card(
                child: ListTile(
              title: Text(
                "Rika",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "190 Marks",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://m.media-amazon.com/images/M/MV5BMjJkNDg5ZDctM2RlZS00NjFmLTkxZjktMWE5NGQzMDg4NDFhXkEyXkFqcGdeQXVyMTMwMDM1OTQ@._V1_UY209_CR6,0,140,209_AL_.jpg")),
              trailing: Text(
                '#5',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )),
          ],
        ));
  }
}
