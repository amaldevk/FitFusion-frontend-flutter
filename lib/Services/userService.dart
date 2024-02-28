
import 'dart:convert';

import 'package:http/http.dart' as http;

class userApiService{

  Future<dynamic> loginApi(String userName ,String password) async{

    var client =http.Client();
    var url = Uri.parse("http://localhost:3006/api/member/login");
    var response =await client.post(url,
        headers: <String,String>{
          "Content-Type" :"application/json ; charset=UTF-8"
        },
        body: jsonEncode(<String,String>{
          "username": userName,
          "password": password,
        })
    );

    if(response.statusCode ==200){
      return jsonDecode(response.body);
    }
    else{
      throw Exception("Fail to send data");
    }
  }
}