/*

class RenewalListViewModel extends ChangeNotifier {
  List<RenewalViewModel> renewalModels = [];

  Future<void> fetchRenewal(String accountId) async {
    final results = await HomeService().get();
    if (Constants.kDebugMode) {
      print("-----------------");
    }
    if (Constants.kDebugMode) {
      print(results);
    }
    var renewalModelMap =
        results.map((item) => RenewalModel.fromJson(item)).toList();

    renewalModels = renewalModelMap
        .map((item) => RenewalViewModel(renewalModel: item))
        .toList();

    notifyListeners();
  }
}  */
