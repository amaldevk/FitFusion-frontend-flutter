// To parse this JSON data, do
//
//     final post2 = post2FromJson(jsonString);

import 'dart:convert';

List<Post2> post2FromJson(String str) => List<Post2>.from(json.decode(str).map((x) => Post2.fromJson(x)));

String post2ToJson(List<Post2> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post2 {
  String id;
  Userid userid;
  Packageid packageid;
  DateTime postdate;

  Post2({
    required this.id,
    required this.userid,
    required this.packageid,
    required this.postdate,
  });

  factory Post2.fromJson(Map<String, dynamic> json) => Post2(
    id: json["_id"],
    userid: Userid.fromJson(json["userid"]),
    packageid: Packageid.fromJson(json["packageid"]),
    postdate: DateTime.parse(json["postdate"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userid": userid.toJson(),
    "packageid": packageid.toJson(),
    "postdate": postdate.toIso8601String(),
  };
}

class Packageid {
  String id;
  String price;
  String duration;

  Packageid({
    required this.id,
    required this.price,
    required this.duration,
  });

  factory Packageid.fromJson(Map<String, dynamic> json) => Packageid(
    id: json["_id"],
    price: json["price"],
    duration: json["duration"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "price": price,
    "duration": duration,
  };
}

class Userid {
  String id;
  String name;

  Userid({
    required this.id,
    required this.name,
  });

  factory Userid.fromJson(Map<String, dynamic> json) => Userid(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}
