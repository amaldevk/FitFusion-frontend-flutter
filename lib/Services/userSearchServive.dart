import 'dart:convert';

import 'package:http/http.dart'as http;

class userSearchSer
{
  Future<dynamic> getUser(String name)async{
    var client=http.Client();
    var apiUrl=Uri.parse("http://localhost:3005/api/member/search");

    var response=await client.post(apiUrl,headers: <String,String>
    {
      "name":name
    });
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    else {
      throw Exception("Invalid user");
    }


  }
}