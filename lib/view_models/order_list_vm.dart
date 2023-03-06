import 'package:study_evaluation/core/apis/app_exception.dart';
import 'package:study_evaluation/core/models/base_list_view_model.dart';
import 'package:study_evaluation/core/models/base_view_model.dart';

import '../models/order_model.dart';
import '../services/order_services.dart';

class OrderListViewModel extends BaseListViewModel {
  Future<void> fetch({String studentId = ""}) async {
    try {
      final jsonObject = await OrderService().fetch(studentId: studentId);
      final records = jsonObject["records"];
      print('recordsorder$records');
      var orderModelMap =
          records.map((item) => OrderModel.fromMap(item)).toList();
      viewModels =
          orderModelMap.map((item) => BaseViewModel(model: item)).toList();
      status = "Completed";
    } on AppException catch (error) {
      status = "Error";
      //  viewModels.add(BaseViewModel(model: OrderModel(appException: error)));
    } on Exception catch (e) {
      status = "Error";
      //   viewModels.add(BaseViewModel(model: OrderModel(error: e)));
    }

    notifyListeners();
  }
}
