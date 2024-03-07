// To parse this JSON data, do
//
//     final current = currentFromJson(jsonString);

import 'dart:convert';

List<Current> currentFromJson(String str) => List<Current>.from(json.decode(str).map((x) => Current.fromJson(x)));

String currentToJson(List<Current> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Current {
  Userid userid;
  Packageid packageid;
  DateTime postdate;

  Current({
    required this.userid,
    required this.packageid,
    required this.postdate,
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    userid: Userid.fromJson(json["userid"]),
    packageid: Packageid.fromJson(json["packageid"]),
    postdate: DateTime.parse(json["postdate"]),
  );

  Map<String, dynamic> toJson() => {
    "userid": userid.toJson(),
    "packageid": packageid.toJson(),
    "postdate": postdate.toIso8601String(),
  };
}

class Packageid {
  String id;
  String packageName;
  String price;
  String duration;

  Packageid({
    required this.id,
    required this.packageName,
    required this.price,
    required this.duration,
  });

  factory Packageid.fromJson(Map<String, dynamic> json) => Packageid(
    id: json["_id"],
    packageName: json["packageName"],
    price: json["price"],
    duration: json["duration"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "packageName": packageName,
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
