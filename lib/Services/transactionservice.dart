
import 'dart:convert';

import 'package:fitfusion_app/Models/TransactionModel.dart';
import 'package:http/http.dart' as http;

class PostApiService
{
  Future<dynamic> sendData(
      String userId,String packageId
      ) async
  {
    var client = http.Client();
    var apiUri = Uri.parse("http://localhost:3006/api/tran/transpost");
    var response = await client.post(apiUri,
      headers: <String,String>
      {
        "Content-Type":"application/json; charset=UTF-8"
      },
      body: jsonEncode(<String,String>
      {
        "userid" : userId,
        "packageid" : packageId
      }
      ),
    );
    if(response.statusCode==200)
    {
      var resp = response.body;
      return jsonDecode(resp);
    }
    else
    {
      throw Exception("Failed to send data");
    }
  }

  Future<List<Post2>> getData() async
  {
    var client = http.Client();
    var apiUri = Uri.parse("http://local:3006/api/tran/viewuser");
    var response = await client.get(apiUri);
    if(response.statusCode == 200)
    {
      var resp = response.body;
      return post2FromJson(resp);
    }
    else
    {
      return [];
    }
  }

  static Future<String?> selectPackage(String userId, String packageId) async {
    final url = Uri.parse('http://localhost:3006/api/subscription/select');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'userId': userId,
          'packageId': packageId,
        }),
      );

      if (response.statusCode == 201) {
        return "Package selected successfully";
      } else {
        throw Exception('Failed to select package');
      }
    } catch (error) {
      print('Error selecting package: $error');
      throw error;
    }
  }

  static Future<dynamic> getSelectedPackage(String userId) async {
    final url = Uri.parse('http://localhost:3006/api/subscription/selected');
    try {
      final response = await http.post(url, body: {'userId': userId});

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        // Assuming responseData contains the current package information
        final currentPackage = responseData['packageName'];
        return currentPackage;
      } else {
        throw Exception('Failed to load current package: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load current package: $e');
    }
  }
}
