import 'dart:convert';
import 'package:fitfusion_app/Models/PackageModel.dart';
import 'package:http/http.dart' as http;

class PackageApiService {
  Future<dynamic> addPackageApi(String packageName,String price,String duration,String description) async
  {
    var client =http.Client();
    var apiUrl= Uri.parse("http://localhost:3006/api/packages/addpackage");

    var response =await client.post(apiUrl,
        headers: <String,String>{
          "Content-Type" : "application/json; charset=UTF-8"
        },
        body: jsonEncode(<String,String>{
          "packageName": packageName,
          "price": price,
          "duration": duration,
          "description": description
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

  Future<List<Package>> getPackageApi() async {
    var client = http.Client();
    var apiUrl = Uri.parse("http:// 192.168.183.53:3006/api/packages/viewpackage");

    var response = await client.get(apiUrl);
    if (response.statusCode == 200) {
      return packageFromJson(response.body);
    }
    else {
      return [];
    }
  }

}