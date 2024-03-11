import 'dart:convert';

History historyFromJson(String str) => History.fromJson(json.decode(str));

String historyToJson(History data) => json.encode(data.toJson());

class History {
  List<HistoryEntry> historyEntries;

  History({
    required this.historyEntries,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
    historyEntries: List<HistoryEntry>.from(
        json["historyEntries"].map((x) => HistoryEntry.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "historyEntries":
    List<dynamic>.from(historyEntries.map((x) => x.toJson())),
  };
}

class HistoryEntry {
  String id;
  UserId userId;
  PackageId? oldPackageId;
  PackageId newPackageId;
  int? refund;
  int? payToAdmin;
  DateTime updatedAt;

  HistoryEntry({
    required this.id,
    required this.userId,
    this.oldPackageId,
    required this.newPackageId,
    this.refund,
    this.payToAdmin,
    required this.updatedAt,
  });

  factory HistoryEntry.fromJson(Map<String, dynamic> json) {
    return HistoryEntry(
      id: json["_id"] ?? "",
      userId: json["userId"] != null ? UserId.fromJson(json["userId"]) : UserId(id: "", name: ""),
      oldPackageId: json["oldPackageId"] != null ? PackageId.fromJson(json["oldPackageId"]) : null,
      newPackageId: json["newPackageId"] != null ? PackageId.fromJson(json["newPackageId"]) : PackageId(id: "", packageName: "", price: ""),
      refund: json["refund"]?.toInt(), // Cast to int explicitly
      payToAdmin: json["payToAdmin"]?.toInt(), // Cast to int explicitly
      updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.now(),
    );
  }


  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId.toJson(),
    "oldPackageId": oldPackageId?.toJson(),
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

  factory PackageId.fromJson(Map<String, dynamic> json) {
    return PackageId(
      id: json["_id"] ?? "",
      packageName: json["packageName"] ?? "Unknown",
      price: json["price"] ?? "Unknown",
    );
  }

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

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(
      id: json["_id"] ?? "",
      name: json["name"] ?? "Unknown",
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}
