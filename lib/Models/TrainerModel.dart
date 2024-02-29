// To parse this JSON data, do
//
//     final trainer = trainerFromJson(jsonString);

import 'dart:convert';

List<Trainer> trainerFromJson(String str) => List<Trainer>.from(json.decode(str).map((x) => Trainer.fromJson(x)));

String trainerToJson(List<Trainer> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Trainer {
  String? name;
  String? gender;
  String? phnno;
  String? address;
  String? experience;

  Trainer({
    this.name,
    this.gender,
    this.phnno,
    this.address,
    this.experience,
  });

  factory Trainer.fromJson(Map<String, dynamic> json) => Trainer(
    name: json["name"],
    gender: json["gender"],
    phnno: json["phnno"],
    address: json["address"],
    experience: json["experience"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "gender": gender,
    "phnno": phnno,
    "address": address,
    "experience": experience,
  };
}
