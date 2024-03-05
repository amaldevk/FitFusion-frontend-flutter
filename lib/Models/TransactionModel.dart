import 'dart:convert';

void main() {
  String jsonString = '[{"_id": "1", "userid": {"_id": "101", "name": "User1"}, "packageid": {"_id": "201","price": "10", "duration": "30"}, "postdate": "2022-03-05T10:00:00Z"}, {"_id": "2", "userid": {"_id": "102", "name": "User2"}, "packageid": {"_id": "202", "price": "20", "duration": "60"}, "postdate": "2022-03-06T11:00:00Z"}]';

  List<Post2> posts = post2FromJson(jsonString);

  posts.forEach((post) {
    print('Post ID: ${post.id}');
    print('User ID: ${post.userid!.id}, Name: ${post.userid!.name}');
    print('Package ID: ${post.packageid!.id},Price: ${post.packageid!.price}, Duration: ${post.packageid!.duration}');
    print('Post Date: ${post.postdate}');
    print('');
  });
}

List<Post2> post2FromJson(String str) => List<Post2>.from(json.decode(str).map((x) => Post2.fromJson(x)));

String post2ToJson(List<Post2> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post2 {
  String? id;
  Userid? userid;
  Packageid? packageid;
  DateTime? postdate;

  Post2({
    required this.id,
    required this.userid,
    required this.packageid,
    required this.postdate,
  });

  factory Post2.fromJson(Map<String, dynamic> json) => Post2(
    id: json["_id"],
    userid: json["userid"] != null ? Userid.fromJson(json["userid"]) : null,
    packageid: json["packageid"] != null ? Packageid.fromJson(json["packageid"]) : null,
    postdate: json["postdate"] != null ? DateTime.parse(json["postdate"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userid": userid!.toJson(),
    "packageid": packageid!.toJson(),
    "postdate": postdate!.toIso8601String(),
  };
}

class Packageid {
  String? id;
  String? price;
  String? duration;

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
  String? id;
  String? name;

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
