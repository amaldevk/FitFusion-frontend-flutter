// To parse this JSON data, do
//
//     final post2 = post2FromJson(jsonString);

import 'dart:convert';

List<Post2> post2FromJson(String str) => List<Post2>.from(json.decode(str).map((x) => Post2.fromJson(x)));

String post2ToJson(List<Post2> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post2 {
  String? id;
  User? userid;
  Package? packageid;
  DateTime? postdate;

  Post2({
    this.id,
    this.userid,
    this.packageid,
    this.postdate,
  });

  factory Post2.fromJson(Map<String, dynamic> json) => Post2(
    id: json["_id"],
    userid: User.fromJson(json["userid"]),
    packageid: Package.fromJson(json["packageid"]),
    postdate: DateTime.parse(json["postdate"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userid": userid?.toJson(),
    "packageid": packageid?.toJson(),
    "postdate": postdate?.toIso8601String(),
  };
}

class User {
  String? id;
  String? name;

  User({
    this.id,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}

class Package {
  String? id;
  String? price;
  String? duration;

  Package({
    this.id,
    this.price,
    this.duration,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
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
