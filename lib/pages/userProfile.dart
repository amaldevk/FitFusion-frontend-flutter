import 'dart:async';
import 'package:fitfusion_app/Services/userService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Assuming UserServiceApi is correctly implemented elsewhere

class View_profile extends StatefulWidget {
  const View_profile({Key? key}) : super(key: key);

  @override
  State<View_profile> createState() => _View_profileState();
}

class _View_profileState extends State<View_profile> {
  Map<String, dynamic> searchResult={};

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("userid") ?? "";
    String packetId = prefs.getString("packetid") ?? "";
    String userTok = prefs.getString("token") ?? "";
    print(userId);
    //print("packetId:"+packetId);
    print("Token is:"+userTok);
    // Corrected assumption: UserServiceApi().searchData() returns a Future that resolves to a list of user data
    try {
      final response = await userApiService().viewProfile(userId, userTok);
      if (response != null && mounted) {
        setState(() {
          searchResult = Map<String, dynamic>.from(response);
        });
      }
    } catch (e) {
      // Handling exceptions that might be thrown by UserServiceApi().searchData()
      print("Error fetching user data: $e");
      // Optionally, show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF752FFF),
        title: Text("User Profile",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
          tooltip: 'Search User',
        ),
      ),
      body:   ListView(
          padding: EdgeInsets.all(16),
          children: [
                     ListTile(
                      title: Text("Name: ${searchResult['name']}",style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                      subtitle: Text("Address: ${searchResult['address']}"+"\nWeight: ${searchResult['weight']}"+"\nHeight: ${searchResult['height']}"+"\nAadhar No.: ${searchResult['idproof']}"
                          +"\nEmail  ID: ${searchResult['emailid']}"+"\nContact No.: ${searchResult['contactno']}"+"\nPackageName: ${searchResult['packageName']}",style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                    ),]
                  )

    );
  }
}