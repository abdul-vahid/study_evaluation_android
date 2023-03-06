import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/base_list_view_model.dart';
import '../../models/leader_board_model.dart';
import '../../utils/app_color.dart';
import '../../utils/app_constants.dart';
import '../../utils/app_utils.dart';

class LearderbordView extends StatefulWidget {
  const LearderbordView({super.key});

  @override
  State<LearderbordView> createState() => _LearderbordViewState();
}

class _LearderbordViewState extends State<LearderbordView> {
  BaseListViewModel? baseListViewModel;
  @override
  void initState() {
    super.initState();
    String url =
        AppUtils.getUrl("${AppConstants.leaderboardAPIPath}?exam_id=96");
    print('url@@@$url');
    Provider.of<BaseListViewModel>(context, listen: false)
        .get(baseModel: LeaderBoardModel(), url: url);
  }

  @override
  Widget build(BuildContext context) {
    baseListViewModel = Provider.of<BaseListViewModel>(context);

    print('@@@$baseListViewModel');
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: const BackButton(color: Colors.white),
          title: const Text("Leardebord"),
          elevation: .1,
          backgroundColor: AppColor.appBarColor,
        ),
        body: ListView(
            padding: const EdgeInsets.all(8), children: _getFollowUsWidgets));
  }

  List<Widget> get _getFollowUsWidgets {
    List<Widget> widgets = [];

    for (var viewModel in baseListViewModel!.viewModels) {
      widgets.add(getCard(viewModel.model));
      // viewModel.model
      print('viewModel.model@@');
    }

    return widgets;
  }

  InkWell getCard(leaderboardModel) {
    var url = AppUtils.getImageUrl(leaderboardModel.profileUrl);
    print('url@@@$url');
    return InkWell(
      onTap: () {
        // launch(leaderboardModel?.url);
      },
      child: Card(
          child: ListTile(
        title: Text(
          leaderboardModel.firstName,
          style:
              TextStyle(fontWeight: FontWeight.bold, color: AppColor.textColor),
        ),
        subtitle: Text(
          leaderboardModel.totalMarks,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: Image.network(
          url,
          height: 60,
          width: 60,
        ),
        trailing: Text(
          leaderboardModel.percentage,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      )),
    );
  }
}

//         body: ListView(
//           padding: const EdgeInsets.all(8),
//           children: <Widget>[
//             Card(
//                 child: ListTile(
//               title: Text(
//                 "Nurcahyo Budi",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                 "300 Marks",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               leading: CircleAvatar(
//                   backgroundImage: NetworkImage(
//                       "https://m.media-amazon.com/images/M/MV5BNjE3NDQyOTYyMV5BMl5BanBnXkFtZTcwODcyODU2Mw@@._V1_UY209_CR5,0,140,209_AL_.jpg")),
//               trailing: Text(
//                 '#1',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             )),
//             Card(
//                 child: ListTile(
//               title: Text(
//                 "Rika Wahyuni",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                 "290 Marks",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               leading: CircleAvatar(
//                   backgroundImage: NetworkImage(
//                       "https://m.media-amazon.com/images/M/MV5BMjJkNDg5ZDctM2RlZS00NjFmLTkxZjktMWE5NGQzMDg4NDFhXkEyXkFqcGdeQXVyMTMwMDM1OTQ@._V1_UY209_CR6,0,140,209_AL_.jpg")),
//               trailing: Text(
//                 '#2',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             )),
//             Card(
//                 child: ListTile(
//               title: Text(
//                 "Alarm",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                 "280 Marks",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               leading: CircleAvatar(
//                   backgroundImage: NetworkImage(
//                       "https://m.media-amazon.com/images/M/MV5BNjE3NDQyOTYyMV5BMl5BanBnXkFtZTcwODcyODU2Mw@@._V1_UY209_CR5,0,140,209_AL_.jpg")),
//               trailing: Text(
//                 '#3',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             )),
//             Card(
//                 child: ListTile(
//               title: Text(
//                 "Ballot",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                 "200 Marks",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               leading: CircleAvatar(
//                   backgroundImage: NetworkImage(
//                       "https://m.media-amazon.com/images/M/MV5BNjE3NDQyOTYyMV5BMl5BanBnXkFtZTcwODcyODU2Mw@@._V1_UY209_CR5,0,140,209_AL_.jpg")),
//               trailing: Text(
//                 '#4',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             )),
//             Card(
//                 child: ListTile(
//               title: Text(
//                 "Rika",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                 "190 Marks",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               leading: CircleAvatar(
//                   backgroundImage: NetworkImage(
//                       "https://m.media-amazon.com/images/M/MV5BMjJkNDg5ZDctM2RlZS00NjFmLTkxZjktMWE5NGQzMDg4NDFhXkEyXkFqcGdeQXVyMTMwMDM1OTQ@._V1_UY209_CR6,0,140,209_AL_.jpg")),
//               trailing: Text(
//                 '#5',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//             )),
//           ],
//         ));
//   }
// }
