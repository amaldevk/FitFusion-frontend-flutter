import 'dart:async';
import 'package:fitfusion_app/Services/PackageService.dart';
import 'package:fitfusion_app/Services/subscriptionservices.dart';
import 'package:fitfusion_app/Services/userService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Assuming UserServiceApi is correctly implemented elsewhere

class updatepayment extends StatefulWidget {
  final String userid;
  const updatepayment({Key? key, required this.userid}) : super(key: key);

  @override
  State<updatepayment> createState() => _View_profileState();
}

class _View_profileState extends State<updatepayment> {
  Map<String, dynamic> searchResult={};

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userId = preferences.getString("userid") ?? "";
    String packageId = preferences.getString("packageId") ?? "";
    print("dd"+widget.userid);
    print("dd"+packageId);
    final response = await UpdateApiService().addPackageApi(widget.userid, packageId);
    if (response["status"] == "success") {
      print("Transaction added");
    } else {
      print("Payment Failed!!");
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


    );
  }
}