// To parse this JSON data, do
//
//     final package = packageFromJson(jsonString);

import 'dart:convert';

List<Package> packageFromJson(String str) => List<Package>.from(json.decode(str).map((x) => Package.fromJson(x)));

String packageToJson(List<Package> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Package {
  String packageName;
  String price;
  String duration;

  Package({
    required this.packageName,
    required this.price,
    required this.duration,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    packageName: json["packageName"],
    price: json["price"],
    duration: json["duration"],
  );

  Map<String, dynamic> toJson() => {
    "packageName": packageName,
    "price": price,
    "duration": duration,
  };
}
