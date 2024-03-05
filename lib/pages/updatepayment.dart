import 'dart:async';
import 'package:fitfusion_app/Services/PackageService.dart';
import 'package:fitfusion_app/Services/subscriptionservice.dart';
import 'package:fitfusion_app/Services/userService.dart';
import 'package:fitfusion_app/pages/selectPackage.dart';
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
    String packageId = preferences.getString("packageID") ?? "";
    String userTok = preferences.getString("token") ?? "";
    print("dd"+widget.userid);
    print("dd"+packageId);

    print(userId);
    print("Token is:"+userTok);
    // Corrected assumption: UserServiceApi().searchData() returns a Future that resolves to a list of user data
    try {
      final response = await UpdateApiService().addPackageApi(widget.userid, userTok);
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
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Payment Successfull',
          style: TextStyle(color: Color(0xFF008000),fontSize: 20,fontWeight: FontWeight.bold),),
        content: Image.asset('assets/successGiff.gif'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>selectPackagepage())),
            child: Text('OK'),
          ),
        ],
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF752FFF),
        title: Text("PAYMENT",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
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