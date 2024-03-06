// To parse this JSON data, do
//
//     final viewuser = viewuserFromJson(jsonString);

import 'dart:convert';

List<Viewuser> viewuserFromJson(String str) => List<Viewuser>.from(json.decode(str).map((x) => Viewuser.fromJson(x)));

String viewuserToJson(List<Viewuser> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Viewuser {

  String name;
  String age;
  String contactno;
  String emailid;
  String gender;
  String bloodgroup;
  String height;
  String weight;
  String idproof;
  String username;
  PaymentStatus paymentStatus;

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

  factory Viewuser.fromJson(Map<String, dynamic> json) => Viewuser(

    name: json["name"],
    age: json["age"],
    contactno: json["contactno"],
    emailid: json["emailid"],
    gender: json["gender"],
    bloodgroup: json["bloodgroup"],
    height: json["height"],
    weight: json["weight"],
    idproof: json["idproof"],
    username: json["username"],
    paymentStatus: paymentStatusValues.map[json["paymentStatus"]]!,
  );

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
