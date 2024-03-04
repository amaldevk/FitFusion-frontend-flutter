// To parse this JSON data, do
//
//     final subscription = subscriptionFromJson(jsonString);

import 'dart:convert';

List<Subscription> subscriptionFromJson(String str) => List<Subscription>.from(json.decode(str).map((x) => Subscription.fromJson(x)));

String subscriptionToJson(List<Subscription> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Subscription {
  final String name;
  final String email;
  final String packageName;
  final double packagePrice;
  final double dueAmount;
  final int remainingDaysForDue;

  Subscription({
    required this.name,
    required this.email,
    required this.packageName,
    required this.packagePrice,
    required this.dueAmount,
    required this.remainingDaysForDue,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      name: json['name'],
      email: json['emailid'],
      packageName: json['packageName'],
      packagePrice: json['packagePrice'] != null ? _parseDouble(json['packagePrice']) : 0.0,
      dueAmount: json['dueAmount'] != null ? _parseDouble(json['dueAmount']) : 0.0,
      remainingDaysForDue: json['remainingDaysForDue'],
    );
  }

  static double _parseDouble(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else if (value is String) {
      // Remove commas and parse to double
      return double.parse(value.replaceAll(',', ''));
    } else {
      throw FormatException('Invalid double');
    }
  }
  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'packageName': packageName,
    'packagePrice': packagePrice,
    'dueAmount': dueAmount,
    'remainingDaysForDue': remainingDaysForDue,
  };
}
