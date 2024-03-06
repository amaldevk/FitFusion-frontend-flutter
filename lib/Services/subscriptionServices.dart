import 'dart:convert';

import 'package:fitfusion_app/Models/subscriptionModel.dart';
import 'package:http/http.dart'as http;

class SubscriptionService {
  static Future<List<SubscribePackage>> fetchDueSubscriptions(String token) async {
    final url = Uri.parse('http://localhost:3006/api/subscription/due');
    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        return responseData.map((json) => SubscribePackage.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load due subscriptions: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load due subscriptions: $e');
    }
  }

  static Future<List<SubscribePackage>> fetchCurrentPackage(String token, String userId) async {
    final url = Uri.parse('http://localhost:3006/api/subscription/selected');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'userId': userId}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        return responseData.map((json) => SubscribePackage.fromJson(json['packageid'])).toList();
      } else {
        throw Exception('Failed to load selected package: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load selected package: $e');
    }
  }
}