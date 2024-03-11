// class Due {
//   String packageName;
//   String packagePrice;
//   String dueAmount;
//   int oldPackageDuration;
//   int newPackageDuration;
//   DateTime oldPackageUpdateDate;
//   DateTime newPackageUpdateDate;
//   int remainingDaysForDue;
//
//   Due({
//     required this.packageName,
//     required this.packagePrice,
//     required this.dueAmount,
//     required this.oldPackageDuration,
//     required this.newPackageDuration,
//     required this.oldPackageUpdateDate,
//     required this.newPackageUpdateDate,
//     required this.remainingDaysForDue,
//   });
//
// }
class Due {
  String packageName;
  String packagePrice;
  String dueAmount;
  int oldPackageDuration;
  int newPackageDuration;
  DateTime oldPackageUpdateDate;
  DateTime newPackageUpdateDate;
  int remainingDaysForDue;

  Due({
    required this.packageName,
    required this.packagePrice,
    required this.dueAmount,
    required this.oldPackageDuration,
    required this.newPackageDuration,
    required this.oldPackageUpdateDate,
    required this.newPackageUpdateDate,
    required this.remainingDaysForDue,
  });

  // factory Due.fromJson(Map<String, dynamic> json) {
  //   return Due(
  //     packageName: json['packageName'],
  //     packagePrice: json['packagePrice'],
  //     dueAmount: json['dueAmount'],
  //     oldPackageDuration: json['oldPackageDuration'],
  //     newPackageDuration: json['newPackageDuration'],
  //     oldPackageUpdateDate: DateTime.parse(json['oldPackageUpdateDate']),
  //     newPackageUpdateDate: DateTime.parse(json['newPackageUpdateDate']),
  //     remainingDaysForDue: json['remainingDaysForDue'],
  //   );
  // }
  factory Due.fromJson(Map<String, dynamic> json) {
    return Due(
      packageName: json['packageName'] ?? '',
      packagePrice: json['packagePrice'] ?? '',
      dueAmount: json['dueAmount'] ?? '',
      oldPackageDuration: json['oldPackageDuration'] ?? 0,
      newPackageDuration: json['newPackageDuration'] ?? 0,
      oldPackageUpdateDate: json['oldPackageUpdateDate'] != null
          ? DateTime.parse(json['oldPackageUpdateDate'])
          : DateTime.now(),
      newPackageUpdateDate: json['newPackageUpdateDate'] != null
          ? DateTime.parse(json['newPackageUpdateDate'])
          : DateTime.now(),
      remainingDaysForDue: json['remainingDaysForDue'] ?? 0,
    );
  }
}

