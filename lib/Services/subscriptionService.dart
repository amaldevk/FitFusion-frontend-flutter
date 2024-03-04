import 'dart:convert';

import 'package:http/http.dart'as http;

class subApiSer{
  Future<dynamic> buySub(String userId,packageId)async
  {
    var client=http.Client();
    var apiurl=Uri.parse("http://localhost:3006/api/subscription/select");

    var response=await client.post(apiurl,headers: <String,String>{
      "Content-Type":"application/json; charset=UTF-8"

    },body: jsonEncode(<String,String>{

        "userId":userId,
        "packageId":packageId

    }));
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
}