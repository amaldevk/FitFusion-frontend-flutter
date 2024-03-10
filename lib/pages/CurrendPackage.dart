import 'package:fitfusion_app/Services/subscriptionService.dart';
import 'package:fitfusion_app/pages/selectPackage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fitfusion_app/pages/transactionPage.dart';

class BuyPackage extends StatefulWidget {
  final String userId;

  const BuyPackage({Key? key, required this.userId}) : super(key: key);

  @override
  State<BuyPackage> createState() => _BuyPackageState();
}

class _BuyPackageState extends State<BuyPackage> {
  late String packageID;
  String message = '', UID = '';

  @override
  void initState() {
    super.initState();
    _fetchIds();
  }

  Future<void> _fetchIds() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      packageID = preferences.getString("packageid") ?? "";
    });
  }

  Future<void> _updatePackageId(String newPackageId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("packageid", newPackageId);
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(color: Color(0xFF008000), fontSize: 20, fontWeight: FontWeight.bold),
        ),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SelectPackagePage())),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void buypkge() async {
    print("buy package is called");
    UID = widget.userId;

    // Check if packageID is null or empty
    if (packageID == null || packageID.isEmpty) {
      // Handle the case for a new user selecting a package
      // You can customize this part based on your logic for new users
      _showDialog(
        'Payment Successful',
        'New user selected a package successfully!',
      );
      return;
    }

    try {
      final response = await subApiSer().buySub(widget.userId.toString(), packageID.toString());
      print("msg" + response["message"]);

      setState(() {
        message = response['message'];
      });

      if (message == "User already has a selected package") {
        // Show a SnackBar with the message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Already have a package'),
          ),
        );

        // Delay navigation to SelectPackagePage
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SelectPackagePage()),
          );
        });
      } else if (message == "Package selected successfully") {
        // Update the package ID in shared preferences
        await _updatePackageId(response['newPackageId']);

        _showDialog(
          'Payment Successful',
          'Package selected successfully!',
        );
      } else {
        _showDialog(
          'Something Went Wrong',
          'Error',
        );
      }
    } catch (e) {
      print("Error in buypkge: $e");
      _showDialog(
        'Something Went Wrong',
        'Error',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF752FFF),
          title: Text(
            "Buy Package",
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
            tooltip: 'Search User',
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            SizedBox(height: 15),
            SizedBox(
              width: 100,
              height: 30,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF752FFF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                onPressed: buypkge,
                child: Text("Make Payment"),
              ),
            ),
            SizedBox(height: 55),
          ],
        ),
      ),
    );
  }
}
