import 'package:fitfusion_app/Services/userService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class View_profile extends StatefulWidget {
  final String userId;

  const View_profile({Key? key, required this.userId}) : super(key: key);

  @override
  _View_profileState createState() => _View_profileState();
}

class _View_profileState extends State<View_profile> {
  late Future<dynamic> userData;

  @override
  void initState() {
    super.initState();
    var apiService = userApiService();
    userData =  apiService.viewProfile(widget.userId);

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
      body: FutureBuilder(
        future: userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            var user = snapshot.data;
            return ListView(
              padding: EdgeInsets.all(16),
              children: [
                ListTile(
                  title: Text('Name: ${user['name']}', style: TextStyle(
                color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          ),),
                ),
                ListTile(
                  title: Text('Address: ${user['address']}', style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                ),
                ListTile(
                  title: Text('Weight: ${user['weight']}', style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                ),
                ListTile(
                  title: Text('Height: ${user['height']}', style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                ),
                ListTile(
                  title: Text('ID Proof: ${user['idproof']}', style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                ),
                ListTile(
                  title: Text('Email ID: ${user['emailid']}', style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                ),
                ListTile(
                  title: Text('Contact No.: ${user['contactno']}', style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
