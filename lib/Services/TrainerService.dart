import 'dart:convert';

import 'package:http/http.dart' as http;

class TrainerApiService{
  Future<dynamic> addTrainerApi(String name,String gender,String phnno,String address,String experience) async
  {
    var client =http.Client();
    var apiUrl= Uri.parse("http://localhost:3006/api/trainer/addtrainer");
    var response =await client.post(apiUrl,
        headers: <String,String>{
          "Content-Type" : "application/json; charset=UTF-8"
        },
        body: jsonEncode(<String,String>{
          "name": name,
          "gender": gender,
          "phnno": phnno,
          "address": address,
          "experience": experience
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
