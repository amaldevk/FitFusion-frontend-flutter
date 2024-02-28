
// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String id;
  String name;
  String address;
  String dateofbirth;
  String age;
  String contactno;
  String emailid;
  String gender;
  String bloodgroup;
  String height;
  String weight;
  String idproof;
  String username;
  String password;
  String paymentStatus;
  int v;

  User({
    required this.id,
    required this.name,
    required this.address,
    required this.dateofbirth,
    required this.age,
    required this.contactno,
    required this.emailid,
    required this.gender,
    required this.bloodgroup,
    required this.height,
    required this.weight,
    required this.idproof,
    required this.username,
    required this.password,
    required this.paymentStatus,
    required this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    address: json["address"],
    dateofbirth: json["dateofbirth"],
    age: json["age"],
    contactno: json["contactno"],
    emailid: json["emailid"],
    gender: json["gender"],
    bloodgroup: json["bloodgroup"],
    height: json["height"],
    weight: json["weight"],
    idproof: json["idproof"],
    username: json["username"],
    password: json["password"],
    paymentStatus: json["paymentStatus"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "address": address,
    "dateofbirth": dateofbirth,
    "age": age,
    "contactno": contactno,
    "emailid": emailid,
    "gender": gender,
    "bloodgroup": bloodgroup,
    "height": height,
    "weight": weight,
    "idproof": idproof,
    "username": username,
    "password": password,
    "paymentStatus": paymentStatus,
    "__v": v,
  };
}
