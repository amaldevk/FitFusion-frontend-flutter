import 'dart:convert';
import 'package:fitfusion_app/Models/PackageModel.dart';
import 'package:http/http.dart' as http;

class UpdateApiService {
  Future<dynamic> addPackageApi(String token,String userId, String newPackageId) async
  {
    var client =http.Client();
    var apiUrl= Uri.parse("http://localhost:3006/api/subscription/update");

    final response =await client.post(apiUrl,
        headers: <String,String>{
          'Content-Type' : 'application/json',
          'Authorization' : 'Bearer $token'
        },
        body: jsonEncode(<String,String>{
          "userId": userId,
          "newPackageId": newPackageId
        })
    );
    if(response.statusCode==200)
    {
      return json.decode(response.body);
    }
    else
    {
      throw Exception("failed to add");
    }
  }
}
