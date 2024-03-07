// To parse this JSON data, do
//
//     final subscribe = subscribeFromJson(jsonString);

import 'dart:convert';

Subscribe subscribeFromJson(String str) => Subscribe.fromJson(json.decode(str));

String subscribeToJson(Subscribe data) => json.encode(data.toJson());

class Subscribe {
  String id;
  String userId;
  PackageId packageId;
  DateTime subscriptionDate;
  int v;

  Subscribe({
    required this.id,
    required this.userId,
    required this.packageId,
    required this.subscriptionDate,
    required this.v,
  });

  factory Subscribe.fromJson(Map<String, dynamic> json) => Subscribe(
    id: json["_id"],
    userId: json["userId"],
    packageId: PackageId.fromJson(json["packageId"]),
    subscriptionDate: DateTime.parse(json["subscriptionDate"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "packageId": packageId.toJson(),
    "subscriptionDate": subscriptionDate.toIso8601String(),
    "__v": v,
  };
}

class PackageId {
  String id;
  String packageName;
  String price;
  String duration;
  String description;
  int v;

  PackageId({
    required this.id,
    required this.packageName,
    required this.price,
    required this.duration,
    required this.description,
    required this.v,
  });

  factory PackageId.fromJson(Map<String, dynamic> json) => PackageId(
    id: json["_id"],
    packageName: json["packageName"],
    price: json["price"],
    duration: json["duration"],
    description: json["description"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "packageName": packageName,
    "price": price,
    "duration": duration,
    "description": description,
    "__v": v,
  };
}
