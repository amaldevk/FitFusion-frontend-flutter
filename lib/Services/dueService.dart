import 'dart:convert';

import 'package:fitfusion_app/Models/dueModel.dart';
import 'package:http/http.dart'as http;
class dueApiSer {
  Future<List<Due>> fetchdue(String userId) async {
    final url = Uri.parse('http://localhost:3006/api/subscription/due');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'userId': userId}),
      );

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);

        // Check if responseData is a list or a single object
        if (responseData is List) {
          return responseData.map((json) => Due.fromJson(json)).toList();
        } else if (responseData is Map<String, dynamic>) {
          // If it's a single object, create a list with that object
          return [Due.fromJson(responseData)];
        } else {
          throw Exception('Invalid response data format');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized user');
      } else {
        throw Exception('Failed to load due information: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load due information: $e');
    }
  }
}

// class dueApiSer{
//   Future<List<Due>> fetchdue(String userId) async {
//     final url = Uri.parse('http://localhost:3006/api/subscription/due');
//     try {
//       final response = await http.post(
//         url,
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({'userId': userId}),
//       );
//
//       if (response.statusCode == 200) {
//         final List<dynamic> responseData = jsonDecode(response.body);
//
//         // Assuming your Due.fromJson method is defined like this
//         List<Due> dueList = responseData.map((json) => Due.fromJson(json)).toList();
//
//         return dueList;
//       } else if (response.statusCode == 401) {
//         throw Exception('Unauthorized user');
//       } else {
//         throw Exception('Failed to load due information: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Failed to load due information: $e');
//     }
//   }
// }

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> responseData = jsonDecode(response.body);
  //
  //       if (responseData.containsKey('dueList')) {
  //         List<dynamic> dueJsonList = responseData['dueList'];
  //
  //         List<Due> dueList = dueJsonList.map((json) => Due.fromJson(json)).toList();
  //
  //         return dueList;
  //       } else {
  //         throw Exception('Invalid JSON format: Missing "dueList" key');
  //       }} else if (response.statusCode == 401) {
  //       throw Exception('Unauthorized user');
  //     } else {
  //       throw Exception('Failed to load due information: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to load due information: $e');
  //   }
  // }
  // Future<List<Due>>fetchdue(String userId) async {
  //   final url = Uri.parse('http://localhost:3006/api/subscription/due');
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: <String, String>{
  //         'Content-Type': 'application/json'
  //       },
  //       body: jsonEncode({'userId': userId}),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final List<dynamic> responseData = jsonDecode(response.body);
  //
  //       // Assuming your Due.fromJson method is defined like this
  //       List<Due> dueList = responseData.map((json) => Due.fromJson(json)).toList();
  //
  //       return dueList;
  //       // //final List<dynamic> responseData = jsonDecode(response.body);
  //       // // return responseData.map((json) => Subscribe.fromJson(json)).toList();
  //       // return jsonDecode(response.body);
  //     } else if (response.statusCode == 401) {
  //       throw Exception('Unauthorized user');
  //     } else {
  //       throw Exception('Failed to load due information: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to load due information: $e');
  //   }
  // }
