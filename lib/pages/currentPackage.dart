import 'package:fitfusion_app/Models/TransactionModel.dart';
import 'package:flutter/material.dart';
import 'package:fitfusion_app/Models/subscriptionModel.dart'; // Replace with the correct import path
import 'package:fitfusion_app/Services/subscriptionServices.dart'; // Replace with the correct import path

class CurrentPackagePage extends StatefulWidget {
  final String userId;
  final String token;

  const CurrentPackagePage({Key? key, required this.userId, required this.token}) : super(key: key);

  @override
  _CurrentPackagePageState createState() => _CurrentPackagePageState();
}

class _CurrentPackagePageState extends State<CurrentPackagePage> {
  late Future<Post2> currentPackage;

  @override
  void initState() {
    super.initState();
    fetchCurrentPackage();
  }

  Future<void> fetchCurrentPackage() async {
    try {
      final response = await SubscriptionService().fe
      setState(() {
        currentPackage = Future.value(response);
      });
    } catch (e) {
      // Handle the error, e.g., show an error message to the user
      print('Error fetching current package: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Package'),
      ),
      body: FutureBuilder<Package>(
        future: currentPackage,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text('No current package available.'),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Package Details',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text('Package Name: ${snapshot.data!.packageName}'),
                  Text('Price: ₹${snapshot.data!.price}'),
                  Text('Duration: ${snapshot.data!.duration}'),
                  // Add more details as needed
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Implement any action you want when the button is pressed
                    },
                    child: Text('Renew Package'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

//
// static Future<List<NotificationModel>> getNotifications(int batchId) async {
// try {
// await initSharedPref();
//
// var token = prefs?.getString('token') ?? '';
//
//
// if (token.isEmpty || batchId == 0) {
// throw Exception("Token or batchId not available.");
// } else {
// var reqbody = {"batchId": batchId.toString()};
//
// var response = await http.post(
// Uri.parse(FacultyNotificationUrl),
// headers: {"Content-Type": "application/json", "token": token},
// body: jsonEncode(reqbody),
// );
//
// if (response.statusCode == 200) {
// var jsonResponse = jsonDecode(response.body);
// print(response.body);
// // Check the structure of the API response
// if (jsonResponse is Map<String, dynamic>) {
// if (jsonResponse.containsKey('status') &&
// jsonResponse['status'] == 'No notifications found!') {
// // Handle case when no notifications are found
// return [];
// } else if (jsonResponse.containsKey('data')) {
// // Process the notifications as usual
// var notificationList = List<NotificationModel>.from(jsonResponse['data']
//     .map((notificationData) => NotificationModel.fromJson(notificationData)));
// return notificationList;
// } else {
// throw Exception("Invalid API response structure.");
// }
// } else {
// throw Exception("Invalid API response type.");
// }
// } else {
// // Handle error response
// throw Exception(
// "Failed to get notifications. Status Code: ${response.statusCode}");
// }
// }
// } catch (e) {
// throw Exception(e.toString());
// }
// }