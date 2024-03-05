import 'package:fitfusion_app/Services/subscriptionSer.dart';
import 'package:fitfusion_app/pages/transactionPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Buy extends StatefulWidget {
  const Buy({Key? key});

  @override
  State<Buy> createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  late Future<String> userID;
  late Future<String> packageID;
  bool hasSelectedPackage = true;

  @override
  void initState() {
    super.initState();
    _fetchIds();
  }

  Future<void> _fetchIds() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userID = Future.value(preferences.getString("UserID") ?? "Unknown");
      packageID = Future.value(preferences.getString("packageID") ?? "Unknown");
      hasSelectedPackage = preferences.getBool("hasSelectedPackage") ?? true;
    });
  }

  Future<void> buypkg() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userId = preferences.getString("UserID") ?? "";
    String packageId = preferences.getString("packageID") ?? "";
    print(userId);
    print(packageId);

    print(userId);
    print(packageId);

    if (hasSelectedPackage) {
      // User has already subscribed to a package
      print("You have already subscribed to a package!");
    } else {
      try {
        final response = await subApiSer().buySub(userId, packageId);

        if (response != null) {
          setState(() {
            hasSelectedPackage = true;
            print("Package subscribed successfully!");
          });
        }
      } catch (error) {
        print("Error buying package: $error");
        // Handle error, show a snackbar, or any other user feedback.
      }
    }
  }

  @override
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
            ),
            if (!hasSelectedPackage)
              ListTile(
                title: ElevatedButton(
                  onPressed: () async {
                    // Navigate to the package selection page
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => transactionPage()),
                    );

                    // After navigating back, refresh the data or perform any necessary actions.
                    _fetchIds();

                    // Check if the user has subscribed to a package after navigating back
                    buypkg();
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
