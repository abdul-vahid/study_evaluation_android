/* class HomeModel {
  final String memberName;
  final DateTime renewalDate;
  final DateTime nextRenewalDate;
  final bool isRenewal;
  final String fees;

  HomeModel(
      {required this.memberName,
      required this.renewalDate,
      required this.nextRenewalDate,
      required this.isRenewal,
      required this.fees});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
        memberName: json["Member__r"]["Name"],
        renewalDate: DateTime.parse(json["Renewal_Date__c"] + " 00:00:00"),
        nextRenewalDate:
            DateTime.parse(json["Next_Renewal_Date__c"] + " 00:00:00"),
        isRenewal: json['Is_Renewed__c'],
        fees: json['Fees__c'].toString());
  }
}  */
