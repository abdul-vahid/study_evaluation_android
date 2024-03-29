import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/models/leader_board_model.dart';
import 'package:study_evaluation/utils/app_constants.dart';
import 'package:study_evaluation/utils/app_utils.dart';

class LeaderBoardListViewModel extends BaseListViewModel {
  Future<void> fetch(examId) async {
    String url =
        AppUtils.getUrl("${AppConstants.leaderboardAPIPath}?exam_id=$examId");
    get(baseModel: LeaderBoardModel(), url: url);
  }
}
