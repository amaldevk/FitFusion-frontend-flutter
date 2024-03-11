// To parse this JSON data, do
//
//     final history = historyFromJson(jsonString);

import 'dart:convert';

History historyFromJson(String str) => History.fromJson(json.decode(str));

String historyToJson(History data) => json.encode(data.toJson());

class History {
  List<HistoryEntry> historyEntries;

  History({
    required this.historyEntries,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
    historyEntries: List<HistoryEntry>.from(json["historyEntries"].map((x) => HistoryEntry.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "historyEntries": List<dynamic>.from(historyEntries.map((x) => x.toJson())),
  };
}

class HistoryEntry {
  String id;
  UserId? userId;
  PackageId? oldPackageId;
  PackageId? newPackageId;
  double? refund;
  double? payToAdmin;
  DateTime updatedAt;

  HistoryEntry({
    required this.id,
    this.userId,
    this.oldPackageId,
    this.newPackageId,
    this.refund,
    this.payToAdmin,
    required this.updatedAt,
  });

  factory HistoryEntry.fromJson(Map<String, dynamic> json) => HistoryEntry(
    id: json["_id"],
    //userId: UserId.fromJson(json["userId"]),
    //userId: json["userId"] ! = null ? UserId.fromJson(json["userId"]) : null,
    userId: json["userId"] != null ? UserId.fromJson(json["userId"]) : null,
    oldPackageId: json["oldPackageId"] != null ? PackageId.fromJson(json["oldPackageId"]) : null,
    //oldPackageId: PackageId.fromJson(json["oldPackageId"]),
    newPackageId: json["newPackageId"] != null ? PackageId.fromJson(json["newPackageId"]) : null,
   // newPackageId: PackageId.fromJson(json["newPackageId"]),
   // refund: json["refund"],
   // payToAdmin: json["payToAdmin"],
    refund: (json["refund"] as num?)?.toDouble(), // Convert to double if not null
    payToAdmin: (json["payToAdmin"] as num?)?.toDouble(), //
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId?.toJson(),
    "oldPackageId": oldPackageId?.toJson(),
    "newPackageId": newPackageId?.toJson(),
    "refund": refund,
    "payToAdmin": payToAdmin,
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class PackageId {
  String id;
  String packageName;
  String price;

  PackageId({
    required this.id,
    required this.packageName,
    required this.price,
  });

  factory PackageId.fromJson(Map<String, dynamic> json) => PackageId(
    id: json["_id"],
    packageName: json["packageName"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "packageName": packageName,
    "price": price,
  };
}

class UserId {
  String id;
  String name;

  UserId({
   required this.id,
    required this.name,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}
