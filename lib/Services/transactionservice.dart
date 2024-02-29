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
}
