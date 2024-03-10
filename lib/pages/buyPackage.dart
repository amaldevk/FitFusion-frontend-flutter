import 'package:fitfusion_app/Services/subscriptionService.dart';
import 'package:fitfusion_app/pages/selectPackage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuyPackage extends StatefulWidget {

  const BuyPackage({Key? key}) : super(key: key);

  @override
  State<BuyPackage> createState() => _BuyPackageState();
}

class _BuyPackageState extends State<BuyPackage> {
  late String packageID,UID;
  String message = '';

  @override
  void initState() {
    super.initState();
    _fetchIds();
  }

  Future<void> _fetchIds() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      packageID = preferences.getString("packageid") ?? "";
      UID = preferences.getString("userid") ?? "";
    });
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
    try {
      final response = await subApiSer().buySub(UID.toString(), packageID.toString());
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
      if (e.toString() == "Exception: User already has a selected packageeeee") {
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
      } else {
        print("Error in buypkge: $e");
        _showDialog(
          'Something Went Wrong',
          'Error',
        );
      }
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
                width: 100,height: 30,
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
            //Text("userID :"+widget.userId+"\npackageID :"+packageID)

          ],
        ),
      ),
    );
  }
}
