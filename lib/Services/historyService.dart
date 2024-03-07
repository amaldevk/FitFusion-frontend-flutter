import 'dart:convert';

import 'package:fitfusion_app/Models/historymodel.dart';
import 'package:http/http.dart' as http;
class hisApiSer {
  Future<List<HistoryEntry>> gethistoryApi() async {
    var client = http.Client();
    var apiUrl = Uri.parse("http://localhost:3006/api/history/viewhistory");

    try {
      var response = await client.get(apiUrl);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['historyEntries'] != null) {
          return List<HistoryEntry>.from(jsonResponse['historyEntries'].map((entry) => HistoryEntry.fromJson(entry)));
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to load history entries');
      }
    } finally {
      client.close();
    }
  }
}

// class hisApiSer {
//   Future<List<History>> gethistoryApi() async {
//     var client = http.Client();
//     var apiUrl = Uri.parse("http://localhost:3006/api/history/viewhistory");
//
//     try {
//       var response = await client.get(apiUrl);
//       if (response.statusCode == 200) {
//         final jsonResponse = jsonDecode(response.body);
//         if (jsonResponse['historyEntries'] != null) {
//           return List<History>.from(jsonResponse['historyEntries'].map((entry) => History.fromJson(entry)));
//         } else {
//           return [];
//         }
//       } else {
//         throw Exception('Failed to load history entries');
//       }
//     } finally {
//       client.close();
//     }
//   }
// }
