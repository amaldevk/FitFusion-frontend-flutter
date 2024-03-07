import 'dart:convert';
import 'package:fitfusion_app/Models/currentmodel.dart';
import 'package:http/http.dart' as http;

class CurrentApiSer {
  Future<List<Current>> getPackage(String userId) async {
    http.Response response = http.Response('{"error": "No response"}', 500); // Initialize with a default response

    try {
      var client = http.Client();
      var apiUri = Uri.parse("http://localhost:3006/api/tran/viewuser");
      response = await client.post(
        apiUri,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: jsonEncode(<String, String>{"userId": userId}),
      );

      if (response.statusCode == 200) {
        var resp = response.body;
        return jsonDecode(resp);
      } else {
        throw Exception("Failed to fetch data. Status: ${response.statusCode}");
      }
    } catch (error) {
      print("Error in getPackage: $error");
      print("Response body: ${response.body}");
      throw Exception("Failed to fetch data. Status: ${response.statusCode}");
    }
  }
}
