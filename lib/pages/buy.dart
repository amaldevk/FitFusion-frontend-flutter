import 'package:fitfusion_app/pages/selectPackage.dart';
import 'package:fitfusion_app/pages/transactionPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Buy extends StatefulWidget {
  const Buy({Key? key}) : super(key: key);

  @override
  State<Buy> createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  late bool hasSelectedPackage;

  @override
  void initState() {
    super.initState();
    pkg(); // Call pkg() in initState
  }

  Future<void> pkg() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userId = preferences.getString("UserId") ?? "";
    String packageId = preferences.getString("packageId") ?? "";


    if (packageId != null && packageId.isNotEmpty) {
      setState(() {
        hasSelectedPackage = true;
        print(packageId);
      });
    } else {
      setState(() {
        hasSelectedPackage = false;
        print(packageId);
      });
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Buy Package"),
        ),
        body: ListView(
          children: [
            ListTile(
              title: hasSelectedPackage
                  ? Text("You have already selected a package!")
                  : Text("You have not selected a package yet."),
             // style: TextStyle(fontSize: 20),
            ),
            if (!hasSelectedPackage)
              ListTile(
                title: ElevatedButton(
                  onPressed: () {
                    // Navigate to the package selection page
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>transactionPage()));
                  },
                  child: Text("Select Package"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Buy(),
  ));
}
