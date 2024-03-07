import 'dart:convert';

import 'package:http/http.dart'as http;

class subApiSer{

  static Future<void> updatepkg(
      String token,
      String userId,
      String newPackageId,
      ) async {
    final url = 'http://localhost:3006/api/subscription/update'; // replace with your actual update API endpoint

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'token': token,
      },
      body: jsonEncode({
        'userId': userId,
        'newPackageId': newPackageId,
      }),
    );

    if (response.statusCode == 200) {
      // Package updated successfully
      print('Package updated successfully');
    } else {
      // Handle the error, you can throw an exception or log it
      print('Failed to update package. Status Code: ${response.statusCode}');
      throw Exception('Failed to update package');
    }
  }

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
    if(response.statusCode == 400){
      throw Exception("User already has a selected packageeeee");
    }
    else if(response.statusCode==201)
    {
      var resp = response.body;
      return jsonDecode(resp);
    }
    else
    {
      throw Exception("Failed to send data:${response.statusCode}");
    }

  }
}