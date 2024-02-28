// To parse this JSON data, do
//
//     final seruser = seruserFromJson(jsonString);

import 'dart:convert';

List<Seruser> seruserFromJson(String str) => List<Seruser>.from(json.decode(str).map((x) => Seruser.fromJson(x)));

String seruserToJson(List<Seruser> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Seruser {
  String name;
  String address;
  String weight;
  String height;
  String idproof;
  String emailid;
  String contactno;

  Seruser({
    required this.name,
    required this.address,
    required this.weight,
    required this.height,
    required this.idproof,
    required this.emailid,
    required this.contactno,
  });

  factory Seruser.fromJson(Map<String, dynamic> json) => Seruser(
    name: json["name"],
    address: json["address"],
    weight: json["weight"],
    height: json["height"],
    idproof: json["idproof"],
    emailid: json["emailid"],
    contactno: json["contactno"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
    "weight": weight,
    "height": height,
    "idproof": idproof,
    "emailid": emailid,
    "contactno": contactno,
  };
}
