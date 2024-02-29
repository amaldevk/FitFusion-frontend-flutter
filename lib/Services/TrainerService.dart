import 'dart:convert';
import 'package:fitfusion_app/Models/TrainerModel.dart';
import 'package:http/http.dart' as http;

class TrainerApiService{
  Future<dynamic> addTrainerApi(String name,String gender,String phnno,String address,String experience) async
  {
    var client =http.Client();
    var apiUrl= Uri.parse("http:localhost:3006/api/trainer/addtrainer");
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
  Future<List<Trainer>> getTrainerApi() async {
    try {
      var apiUrl = Uri.parse("http://localhost:3006/api/trainer/viewtrainers");
      var response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        return trainerFromJson(response.body);
      } else {
        throw Exception("Failed to fetch trainers");
      }
    } catch (error) {
      throw Exception("Failed to fetch trainers: $error");
    }
  }
}
