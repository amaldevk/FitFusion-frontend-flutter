import 'dart:convert';
import 'package:http/http.dart'as http;
class userRegSer{
  Future<dynamic> Sentdata(String name,address,dob,age,contactno,emailid,gender,bloodgroup,height,weight,idproof,username,password,status) async {
    var client = http.Client();
    var apiurl = Uri.parse("http://localhost:3005/api/member/signup");
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
}