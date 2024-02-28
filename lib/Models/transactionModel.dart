// To parse this JSON data, do
//
//     final post2 = post2FromJson(jsonString);

import 'dart:convert';

List<Post2> post2FromJson(String str) => List<Post2>.from(json.decode(str).map((x) => Post2.fromJson(x)));

String post2ToJson(List<Post2> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post2 {
  String userid;
  String packageid;
  DateTime postdate;

  Post2({
    required this.userid,
    required this.packageid,
    required this.postdate,
  });

  factory Post2.fromJson(Map<String, dynamic> json) => Post2(
    userid: json["userid"],
    packageid: json["packageid"],
    postdate: DateTime.parse(json["postdate"]),
  );

  Map<String, dynamic> toJson() => {
    "userid": userid,
    "packageid": packageid,
    "postdate": postdate.toIso8601String(),
  };
}
