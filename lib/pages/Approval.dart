// import 'package:fitfusion_app/pages/Menu.dart';
// import 'package:flutter/material.dart';
// import 'package:fitfusion_app/Models/userModel.dart';
// import 'package:fitfusion_app/Services/userService.dart';
// import 'package:http/http.dart' as http;
// import 'dart:io';
//
// class UserApi {
//   static Future<List<User>> getUserApi() async {
//     var client = http.Client();
//     var apiUrl = Uri.parse("http://localhost:3006/api/member/MemberDetails");
//
//     try {
//       var response = await client.get(apiUrl);
//       if (response.statusCode == 200) {
//         return userFromJson(response.body);
//       } else {
//         throw Exception("Failed to fetch user data. Status code: ${response.statusCode}");
//       }
//     } on SocketException catch (e) {
//       throw Exception("Network error: $e");
//     } on HttpException catch (e) {
//       throw Exception("HTTP error: $e");
//     } catch (e) {
//       throw Exception("Error fetching user data: $e");
//     } finally {
//       client.close();
//     }
//   }
// }
//
// class AdminApprovalPage extends StatefulWidget {
//   @override
//   _AdminApprovalPageState createState() => _AdminApprovalPageState();
// }
//
// class _AdminApprovalPageState extends State<AdminApprovalPage> {
//   late Future<List<User>> _users;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchUsers();
//   }
//
//   Future<void> _fetchUsers() async {
//     setState(() {
//       _users = UserApi.getUserApi();
//     });
//   }
//
//   Future<void> _approveUser(String userId) async {
//     var apiService = userApiService();
//     await apiService.approveUser(userId);
//     _fetchUsers();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF752FFF),
//         title: Text('Admin Approval',style: TextStyle(color: Colors.white),),
//         actions: <Widget>[
//           IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) =>MenuPage()));},
//         icon: Icon(Icons.home_filled, color: Colors.white),tooltip: 'Admin Menu'),
//     ],
//       ),
//       body: FutureBuilder<List<User>>(
//         future: _users,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             List<User>? users = snapshot.data;
//             return ListView.builder(
//               itemCount: users?.length ?? 0,
//               itemBuilder: (context, index) {
//                 User user = users![index];
//                 return ListTile(
//                   title: Text(user.emailid ?? 'Unknown'),
//                   subtitle: Text('Status: ${user.approved != null && user.approved! ? 'Approved' : 'Approved'}'),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.check),
//                         onPressed: user.approved != null && user.approved! ? null : () => _approveUser(user.id ?? 'Unknown'),
//                       ),
//                     ],
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
