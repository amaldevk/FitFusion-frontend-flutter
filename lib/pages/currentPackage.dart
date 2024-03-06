import 'package:flutter/material.dart';
import 'package:fitfusion_app/Models/TransactionModel.dart';
import 'package:fitfusion_app/Services/transactionservice.dart';
class curtpkg extends StatefulWidget {
  final String userId;

  const curtpkg({Key? key, required this.userId}) : super(key: key);

  @override
  State<curtpkg> createState() => _curtpkgState();
}

class _curtpkgState extends State<curtpkg> {
  late Future<List<Post2>> data;

  @override
  void initState() {
    super.initState();
    data = PostApiService().getTransaction(widget.userId);
  }
//
// class curtpkg extends StatefulWidget {
//   final String userId;
//
//   const curtpkg({Key? key, required this.userId}) : super(key: key);
//
//   @override
//   State<curtpkg> createState() => _curtpkgState();
// }
//
// class _curtpkgState extends State<curtpkg> {
//   late Future<List<Post2>> data=Future.value([]);
//
//   @override

  // void initState() {
  //   super.initState();
  //   fetchData();
  // }
  //
  // void fetchData() async {
  //   try {
  //     List<Post2> transactions = await PostApiService().getTransaction(widget.userId);
  //     print("userid is"+ widget.userId);
  //     setState(() {
  //       data = Future.value(transactions);
  //     });
  //   } catch (error) {
  //     // Handle errors here
  //     print("Error fetching data: $error");
  //   }
  // }

  // void initState() {
  //   super.initState();
  //   data = PostApiService().getTransaction(widget.userId);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Selected Packages'),
      ),
      body: FutureBuilder<List<Post2>>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error loading packages:',
                    style: TextStyle(color: Colors.red),
                  ),
                  Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            );
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No packages found.',
                style: TextStyle(color: Colors.grey),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final subscription = snapshot.data![index];
                final package = subscription.packageid!;
                final user = subscription.userid!;

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Price: ${package.price}'),
                        Text('Duration: ${package.duration}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}


// import 'package:fitfusion_app/Models/TransactionModel.dart';
// import 'package:fitfusion_app/Services/transactionservice.dart';
// import 'package:flutter/material.dart';
//
// class curtpkg extends StatefulWidget {
//   //final String token;
//   final String userId;
//   const curtpkg({Key? key, required this.userId}) : super(key:key);// required this.token,
//
//   @override
//   State<curtpkg> createState() => _curtpkgState();
// }
//
// class _curtpkgState extends State<curtpkg> {
//   late Future<List<Post2>> data;
// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     data=PostApiService().getTransaction(widget.userId);
//
//   }
//   // void getPackage()async{
//   //   final response=await PostApiService().getAllTransactions();
//   //
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Current Selected Packages'),
//       ),
//       body: FutureBuilder(
//         future: ,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Error loading packages:',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                   Text(
//                     '${snapshot.error}',
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ],
//               ),
//             );
//           } else if (snapshot.data == null || snapshot.data!.isEmpty) {
//             // Check if data is null or empty
//             return Center(
//               child: Text(
//                 'No packages found.',
//                 style: TextStyle(color: Colors.grey),
//               ),
//             );
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 final subscription = snapshot.data![index];
//                 final package = subscription.packageid!;
//                 final user = subscription.userid!;
//
//                 return Card(
//                   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   child: ListTile(
//                     // title: Text(
//                     //   'Package Name: ${package.packageName}',
//                     //   style: TextStyle(fontWeight: FontWeight.bold),
//                     // ),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text('Price: ${package.price}'),
//                         Text('Duration: ${package.duration}'),
//                         // Assuming description and subscriptionDate are properties of subscription model
//                         // Text('Description: ${subscription.description}'),
//                         // SizedBox(height: 8),
//                         // Text('Subscription Date: ${subscription.subscriptionDate}'),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

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