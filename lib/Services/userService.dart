import 'dart:convert';
import 'dart:io';
import 'package:fitfusion_app/Models/viewUserModel.dart';
import 'package:http/http.dart' as http;

class userApiService{

  Future<dynamic> getSeruser(String name) async {
  var client = http.Client();
  var apiUrl = Uri.parse("http://localhost:3006/api/member/search");

  try {
  var response = await client.post(
  apiUrl,
  body: jsonEncode({"name": name}),
  headers: {
  "Content-Type": "application/json",
  },
  );

  if (response.statusCode == 200) {
  return json.decode(response.body);
  } else {
  throw Exception("Invalid user");
  }
  } finally {
  client.close();
  }
  }

  Future<List<Viewuser>> getUser() async {
    var client = http.Client();
    var apiUrl = Uri.parse("http://localhost:3006/api/member/MemberDetails");

    try {
      var response = await client.get(apiUrl);
      if (response.statusCode == 200) {
        return viewuserFromJson(response.body);
      } else {
        throw Exception("Failed to fetch user data. Status code: ${response.statusCode}");
      }
    } on SocketException catch (e) {
      throw Exception("Network error: $e");
    } on HttpException catch (e) {
      throw Exception("HTTP error: $e");
    } catch (e) {
      throw Exception("Error fetching user data: $e");
    } finally {
      client.close();
    }
  }


  Future<dynamic> Sentdata(String name,address,dob,age,contactno,emailid,gender,bloodgroup,height,weight,idproof,username,password,status) async {
    var client = http.Client();
    var apiurl = Uri.parse("http://localhost:3006/api/member/signup");
    var response = await client.post(apiurl, headers: <String, String>
    {
      "Content-Type": "application/Json;charset=UTF-8 "
    }, body: jsonEncode(<String, String>
    {
      "name": name,
      "address": address,
      "dateofbirth": dob,
      "age": age,
      "contactno": contactno,
      "emailid": emailid,
      "gender": gender,
      "bloodgroup": bloodgroup,
      "height": height,
      "weight": weight,
      "idproof": idproof,
      "username": username,
      "password": password,
      "paymentStatus":status
    }
    )
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    else {
      throw Exception("Failed");
    }
  }


  Future<dynamic> loginApi(String email ,String password) async{
    var client =http.Client();
    var url = Uri.parse("http://localhost:3006/api/member/login");
    var response =await client.post(url,
        headers: <String,String>{
          "Content-Type" :"application/json ; charset=UTF-8"
        },
        body: jsonEncode(<String,String>{
          "emailid": email,
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

  Future<dynamic> viewProfile(String user_ID) async{
    var client =http.Client();
    var url=Uri.parse("http://localhost:3006/api/member/myprofile");
    try{
      var response =await client.post(url,
      body: jsonEncode({"userId":user_ID}),
      headers:{
        "Content-Type": "application/json",
      },
      );
      if(response.statusCode == 200){
        return json.decode(response.body);
      }
      else{
        throw Exception("Invalid");
      }
    }
    finally{client.close();}
  }

}
