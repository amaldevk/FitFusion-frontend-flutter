import 'dart:convert';

List<Viewuser> viewuserFromJson(String str) => List<Viewuser>.from(json.decode(str).map((x) => Viewuser.fromJson(x)));

String viewuserToJson(List<Viewuser> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Viewuser {
  String? name;
  String? age;
  String? contactno;
  String? emailid;
  String? gender;
  String? bloodgroup;
  String? height;
  String? weight;
  String? idproof;
  String? username;
  PaymentStatus? paymentStatus;

  Viewuser({
    required this.name,
    required this.age,
    required this.contactno,
    required this.emailid,
    required this.gender,
    required this.bloodgroup,
    required this.height,
    required this.weight,
    required this.idproof,
    required this.username,
    required this.paymentStatus,
  });

  factory Viewuser.fromJson(Map<String, dynamic> json) {
    return Viewuser(
      name: json["name"] ?? 'Unknown',
      age: json["age"] ?? 'Unknown',
      contactno: json["contactno"] ?? 'Unknown',
      emailid: json["emailid"] ?? 'Unknown',
      gender: json["gender"] ?? 'Unknown',
      bloodgroup: json["bloodgroup"] ?? 'Unknown',
      height: json["height"] ?? 'Unknown',
      weight: json["weight"] ?? 'Unknown',
      idproof: json["idproof"] ?? 'Unknown',
      username: json["username"] ?? 'Unknown',
      paymentStatus: paymentStatusValues.map[json["paymentStatus"]] ?? PaymentStatus.PENDING,
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "age": age,
    "contactno": contactno,
    "emailid": emailid,
    "gender": gender,
    "bloodgroup": bloodgroup,
    "height": height,
    "weight": weight,
    "idproof": idproof,
    "username": username,
    "paymentStatus": paymentStatusValues.reverse[paymentStatus],
  };
}

enum PaymentStatus {
  PAID,
  PAYMENT_STATUS_PENDING,
  PENDING,
  SUCCESS
}

final paymentStatusValues = EnumValues({
  "paid": PaymentStatus.PAID,
  "Pending": PaymentStatus.PAYMENT_STATUS_PENDING,
  "pending": PaymentStatus.PENDING,
  "Success": PaymentStatus.SUCCESS
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
