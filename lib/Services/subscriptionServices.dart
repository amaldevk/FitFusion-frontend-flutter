import 'dart:convert';
import 'package:fitfusion_app/Models/DueModel.dart';
import 'package:http/http.dart' as http;
class SubscriptionService {
  static const String baseUrl = 'http://localhost:3006/api/dueamount';

  Future<List<DueAmount>> getDueSubscriptions() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/due'));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<DueAmount> subscriptions =
        data.map((item) => DueAmount.fromJson(item)).toList();
        return subscriptions;
      } else {
        throw Exception('Failed to load due subscriptions');
      }
    } catch (error) {
      throw Exception('Failed to load due subscriptions: $error');
    }
  }
}
