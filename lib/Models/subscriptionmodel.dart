// To parse this JSON data, do
//
//     final update = updateFromJson(jsonString);

import 'dart:convert';

List<Update> updateFromJson(String str) => List<Update>.from(json.decode(str).map((x) => Update.fromJson(x)));

String updateToJson(List<Update> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Update {
  String userId;
  String packageId;
  DateTime subscriptionDate;

  Update({
    required this.userId,
    required this.packageId,
    required this.subscriptionDate,
  });

  factory Update.fromJson(Map<String, dynamic> json) => Update(
    userId: json["userId"],
    packageId: json["packageId"],
    subscriptionDate: DateTime.parse(json["subscriptionDate"]),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "packageId": packageId,
    "subscriptionDate": subscriptionDate.toIso8601String(),
  };
}

