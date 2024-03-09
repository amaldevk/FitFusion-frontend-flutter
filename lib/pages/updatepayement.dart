import 'dart:async';
import 'package:fitfusion_app/Services/subscriptionServices.dart';
import 'package:fitfusion_app/pages/selectPackage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdatePayment extends StatefulWidget {
  final String userId;
  final String userToken;

  const UpdatePayment({Key? key, required this.userId, required this.userToken}) : super(key: key);

  @override
  State<UpdatePayment> createState() => _UpdatePaymentState();
}

class _UpdatePaymentState extends State<UpdatePayment> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String userId = preferences.getString("userid") ?? "";
      String packageId = preferences.getString("packageID") ?? "";
      String userToken = preferences.getString("token") ?? "";

      print("UserId: $userId");
      print("Token is: ${widget.userToken}");
      print("PackageId: $packageId");

      final Map<String, dynamic> response = await SubscriptionService().addPackageApi(widget.userId, packageId, widget.userToken);

      if (response != null && mounted) {
        print("Successful");
      } else {
        print("Error fetching user data");
      }
    } catch (e) {
      print("Error: $e");
      // Handle error accordingly
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Payment Status',
          style: TextStyle(color: Color(0xFF008000), fontSize: 20, fontWeight: FontWeight.bold),
        ),
        content: Image.asset('assets/successGiff.gif'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/selectPackage'),
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
        title: Text("PAYMENT", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
          tooltip: 'Search User',
        ),
      ),
      body: Center(
        child: Text(
          "PAYMENT SUCCESSFUL",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
