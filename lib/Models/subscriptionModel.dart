import 'dart:convert';

void main() {
  String jsonString = '[{"_id": "1", "userid": {"_id": "101", "name": "User1"}, "packageid": {"_id": "201","price": "10", "duration": "30"}, "postdate": "2022-03-05T10:00:00Z"}, {"_id": "2", "userid": {"_id": "102", "name": "User2"}, "packageid": {"_id": "202", "price": "20", "duration": "60"}, "postdate": "2022-03-06T11:00:00Z"}]';

  List<SubscribePackage> subscribePackageFromJson(String str) {
    List<dynamic> jsonData = json.decode(str);
    return jsonData.map((json) => SubscribePackage.fromJson(json)).toList();
  }

  String subscribePackageToJson(List<SubscribePackage> data) {
    List<dynamic> jsonData = data.map((item) => item.toJson()).toList();
    return json.encode(jsonData);
  }

  List<SubscribePackage> Subscription = subscribePackageFromJson(jsonString);

  Subscription.forEach((Subscription) {
    print('Post ID: ${Subscription.id}');
    print('User ID: ${Subscription.userid!.id}, Name: ${Subscription.userid!.name}');
    print('Package ID: ${Subscription.packageid!.id},Price: ${Subscription.packageid!.price}, Duration: ${Subscription.packageid!.duration}');
    print('Post Date: ${Subscription.postdate}');
    print('');
  });
}

List<SubscribePackage> subscribePackageFromJson(String str) => List<SubscribePackage>.from(json.decode(str).map((x) => SubscribePackage.fromJson(x)));

String subscribePackageToJson(List<SubscribePackage> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubscribePackage {
  String? id;
  SubUserid? userid;
  SubPackageid? packageid;
  DateTime? postdate;

  SubscribePackage({
    required this.id,
    required this.userid,
    required this.packageid,
    required this.postdate,
  });

  factory SubscribePackage.fromJson(Map<String, dynamic> json) => SubscribePackage(
    id: json["_id"],
    userid: json["userid"] != null ? SubUserid.fromJson(json["userid"]) : null,
    packageid: json["packageid"] != null ? SubPackageid.fromJson(json["packageid"]) : null,
    postdate: json["postdate"] != null ? DateTime.parse(json["postdate"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userid": userid!.toJson(),
    "packageid": packageid!.toJson(),
    "postdate": postdate!.toIso8601String(),
  };
}

class SubPackageid {
  String? id;
  String? price;
  String? duration;

  SubPackageid({
    required this.id,
    required this.price,
    required this.duration,
  });

  factory SubPackageid.fromJson(Map<String, dynamic> json) => SubPackageid(
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

class SubUserid {
  String? id;
  String? name;

  SubUserid({
    required this.id,
    required this.name,
  });

  factory SubUserid.fromJson(Map<String, dynamic> json) => SubUserid(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}
