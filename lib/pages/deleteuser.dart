import 'package:fitfusion_app/Services/userService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class deleteUser extends StatefulWidget {
  const deleteUser({super.key});

  @override
  State<deleteUser> createState() => _deleteUserState();
}

class _deleteUserState extends State<deleteUser> {
  void SendValuesToApi() async{
    SharedPreferences prefer=await SharedPreferences.getInstance();
    String id=prefer.getString("userId")?? "";

    final response= await userApiService().deleteUser(id);
    print(response);
    if(response["status"]=="success"){
      print("successfuly Deleted");
    }
    else
    {
      print("Error");
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(

        ),
        body: Center(
          child: Container(
            child: Column(
              children: [
                ElevatedButton(onPressed: SendValuesToApi, child: Text("DELETE")),
                ElevatedButton(onPressed:()
                    {
                      Navigator.pop(context);
                    }, child: Text("BACK"))
              ],
            ),
          ),
        ),
      ),

    );
  }
}
