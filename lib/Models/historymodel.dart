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
  UserId userId;
  PackageId oldPackageId;
  PackageId newPackageId;
  int? refund;
  int? payToAdmin;
  DateTime updatedAt;

  HistoryEntry({
    required this.id,
    required this.userId,
    required this.oldPackageId,
    required this.newPackageId,
    this.refund,
    this.payToAdmin,
    required this.updatedAt,
  });

  factory HistoryEntry.fromJson(Map<String, dynamic> json) => HistoryEntry(
    id: json["_id"],
    userId: UserId.fromJson(json["userId"]),
    oldPackageId: PackageId.fromJson(json["oldPackageId"]),
    newPackageId: PackageId.fromJson(json["newPackageId"]),
    refund: json["refund"],
    payToAdmin: json["payToAdmin"],
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId.toJson(),
    "oldPackageId": oldPackageId.toJson(),
    "newPackageId": newPackageId.toJson(),
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
