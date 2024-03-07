import 'dart:convert';
import 'package:fitfusion_app/Models/currentSubscriptionModel.dart';
import 'package:http/http.dart' as http;

class SubscriptionService {
  static Future<List<Subscribe>> fetchCurrentPackage(String token,
      String userId) async {
    final url = Uri.parse('http://localhost:3006/api/subscription/selected');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json', "token": token
        },
        body: jsonEncode({'userId': userId, "token": token}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        return responseData.map((json) => Subscribe.fromJson(json)).toList();
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized user');
      } else {
        throw Exception(
            'Failed to load selected package: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load selected package: $e');
    }
  }

  Future<dynamic> addPackageApi( String userId,
      String newPackageId) async
  {
    var client = http.Client();
    var apiUrl = Uri.parse("http://localhost:3006/api/subscription/update");
    try {
      final response = await client.post(apiUrl,
          headers: <String, String>{
            'Content-Type': 'application/json',
           // 'Authorization': 'Bearer $token'
          },
          body: jsonEncode(<String, String>{
            "userId": userId,
            "newPackageId": newPackageId
          })
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      else {
        throw Exception("failed to add");
      }
    }
    catch (e) {
      throw Exception("failed to add");
    }
  }
}