// To parse this JSON data, do
//
//     final update = updateFromJson(jsonString);

import 'dart:convert';

List<Update> updateFromJson(String str) => List<Update>.from(json.decode(str).map((x) => Update.fromJson(x)));

String updateToJson(List<Update> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Update {
  String name;
  String emailid;
  String paymentStatus;

  Update({
    required this.name,
    required this.emailid,
    required this.paymentStatus,
  });

  factory Update.fromJson(Map<String, dynamic> json) => Update(
    name: json["name"],
    emailid: json["emailid"],
    paymentStatus: json["paymentStatus"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "emailid": emailid,
    "paymentStatus": paymentStatus,
  };
}
