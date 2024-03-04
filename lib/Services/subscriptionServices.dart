import 'dart:convert';
import 'package:fitfusion_app/Models/subscriptionModel.dart';
import 'package:http/http.dart' as http;
class SubscriptionService {
  static const String baseUrl = 'http://localhost:3006/api/subscription'; // Replace with your actual backend URL

  Future<List<Subscription>> getDueSubscriptions() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/due'));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Subscription> subscriptions =
        data.map((item) => Subscription.fromJson(item)).toList();
        return subscriptions;
      } else {
        throw Exception('Failed to load due subscriptions');
      }
    } catch (error) {
      throw Exception('Failed to load due subscriptions: $error');
    }
  }
}
