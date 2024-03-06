import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fitfusion_app/Models/TransactionModel.dart';

class PostApiService {
  Future<dynamic> sendData(String userId, String packageId) async {
    var client = http.Client();
    var apiUri = Uri.parse("http://localhost:3006/api/tran/transpost");
    var response = await client.post(apiUri,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(<String, String>{"userid": userId, "packageid": packageId}));

    if (response.statusCode == 200) {
      var resp = response.body;
      return jsonDecode(resp);
    } else {
      throw Exception("Failed to send data");
    }
  }
  Future<List<Post2>> getTransaction(String userId) async {
    final url = Uri.parse('http://localhost:3006/api/tran/viewuser');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{'userId': userId}),
      );

      if (response.statusCode == 201) {
        var resp = response.body;
        return jsonDecode(resp);
      } else {
        throw Exception('Failed to get data');
      }
    } catch (error) {
      print('Error in receiving data: $error');
      throw error;
    }
  }

  //
  // Future<List<Post2>> getTransaction(String userId) async {
  //   var client = http.Client();
  //   var apiUrl = Uri.parse("http://localhost:3006/api/tran/viewuser");
  //
  //   var response = await client.post(apiUrl,
  //       headers: <String, String>{
  //         "Content-Type": "application/json; charset=UTF-8"
  //       },
  //       body: jsonEncode(<String, String>{
  //         "userId": userId
  //       })
  //   );
  //   if (response.statusCode == 200) {
  //     return json.decode(response.body);
  //   }
  //   else {
  //     throw Exception("failed to add");
  //   }
  // }
  // if (response.statusCode == 200) {
  // List<dynamic> jsonResponse = jsonDecode(response.body);
  // List<Post2> transactions = [];
  // for (var item in jsonResponse) {
  // transactions.add(Post2.fromJson(item));
  // }
  // return transactions;
  // } else {
  // return [];
  // }
  // }



  Future<List<Post2>> getAllTransactions() async {
    var client = http.Client();
    var apiUrl = Uri.parse("http://localhost:3006/api/tran/viewall");
    var response = await client.get(apiUrl);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Post2> transactions = [];
      for (var item in jsonResponse) {
        transactions.add(Post2.fromJson(item));
      }
      return transactions;
    } else {
      return [];
    }
  }


  static Future<String?> selectPackage(String userId, String packageId) async {
    final url = Uri.parse('http://localhost:3006/api/subscription/select');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{'userId': userId, 'packageId': packageId}),
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

  // static Future<List<Packageid>> fetchCurrentPackage(String token, String userId) async {
  //   final url = Uri.parse('http://localhost:3006/api/subscription/selected');
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token', // Assuming your JWT token is passed in this format
  //       },
  //       body: jsonEncode({'userId': userId}),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final List<dynamic> responseData = jsonDecode(response.body);
  //       return responseData.map((json) => Packageid.fromJson(json)).toList();
  //     } else {
  //       throw Exception('Failed to load selected package: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to load selected package: $e');
  //   }
  // }
}
