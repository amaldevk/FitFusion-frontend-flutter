import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fitfusion_app/pages/transactionPage.dart';

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
    String? userId = preferences.getString("UserId");
    String? packageId = preferences.getString("packageId");

    if (packageId != null && packageId.isNotEmpty) {
      setState(() {
        hasSelectedPackage = true;
      });
    } else {
      setState(() {
        hasSelectedPackage = false;
      });
    }
  }

  // Function to save the selected packageId in shared preferences
  Future<void> saveSelectedPackageId(String packageId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('packageId', packageId);
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
            ),
            if (!hasSelectedPackage)
              ListTile(
                title: ElevatedButton(
                  onPressed: () async {
                    // Simulating the selection of a package (replace with your logic)
                    String selectedPackageId = "your_selected_package_id";

                    // Save the selected packageId to shared preferences
                    await saveSelectedPackageId(selectedPackageId);

                    // Refresh the state to reflect the changes
                    pkg();
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
