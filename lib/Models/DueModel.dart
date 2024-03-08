// To parse this JSON data, do
//
//     final dueAmount = dueAmountFromJson(jsonString);

import 'dart:convert';

List<DueAmount> dueAmountFromJson(String str) => List<DueAmount>.from(json.decode(str).map((x) => DueAmount.fromJson(x)));

String dueAmountToJson(List<DueAmount> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DueAmount {
  String name;
  String email;
  String packageName;
  String packagePrice;
  String dueAmount;
  String remainingDaysForDue;

  DueAmount({
    required this.name,
    required this.email,
    required this.packageName,
    required this.packagePrice,
    required this.dueAmount,
    required this.remainingDaysForDue,
  });

  factory DueAmount.fromJson(Map<String, dynamic> json) => DueAmount(
    name: json["name"],
    email: json["email"],
    packageName: json["packageName"],
    packagePrice: json["packagePrice"],
    dueAmount: json["dueAmount"],
    remainingDaysForDue: json["remainingDaysForDue"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "packageName": packageName,
    "packagePrice": packagePrice,
    "dueAmount": dueAmount,
    "remainingDaysForDue": remainingDaysForDue,
  };
}
