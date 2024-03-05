// To parse this JSON data, do
//
//     final package = packageFromJson(jsonString);

import 'dart:convert';

List<Package> packageFromJson(String str) => List<Package>.from(json.decode(str).map((x) => Package.fromJson(x)));

String packageToJson(List<Package> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Package {
  String id;
  String packageName;
  String price;
  String duration;
  String description;

  Package({
    required this.id,
    required this.packageName,
    required this.price,
    required this.duration,
    required this.description,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    id: json["_id"],
    packageName: json["packageName"],
    price: json["price"],
    duration: json["duration"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "packageName": packageName,
    "price": price,
    "duration": duration,
    "description": description,
  };
}
