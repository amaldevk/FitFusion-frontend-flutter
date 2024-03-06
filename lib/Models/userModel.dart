
// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';


List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  String? id;
  String? name;
  String? address;
  String? dateofbirth; // Use nullable types for fields that can be null
  String? age;
  String? contactno;
  String? emailid;
  String? gender;
  String? bloodgroup;
  String? height;
  String? weight;
  String? idproof;
  String? username;
  String? password;
  String? paymentStatus;
  bool? approved;
  int? v;

  User({
    required this.id,
    required this.name,
    required this.address,
    this.dateofbirth, // Use nullable types for fields that can be null
    this.age,
    this.contactno,
    this.emailid,
    this.gender,
    this.bloodgroup,
    this.height,
    this.weight,
    this.idproof,
    this.username,
    this.password,
    this.paymentStatus,
    this.approved,
    required this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    name: json["name"],
    address: json["address"],
    dateofbirth: json["dateofbirth"], // Check for null values
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
    approved: json["approved"],
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
    "approved": approved,
    "__v": v,
  };

}

