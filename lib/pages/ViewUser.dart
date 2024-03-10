import 'package:fitfusion_app/pages/Update.dart';
import 'package:flutter/material.dart';
import 'package:fitfusion_app/Models/viewUserModel.dart';
import 'package:fitfusion_app/pages/searchUser.dart';
import 'package:fitfusion_app/Services/userService.dart';

class ViewUser extends StatefulWidget {
  const ViewUser({Key? key});

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  Future<List<Viewuser>>? data;

  @override
  void initState() {
    super.initState();
    data = userApiService().getUser();
  }

  Future<void> deleteUser(String emailId) async {
    try {
      await userApiService.deleteMember(emailId);
      // Refresh the user list after deletion
      setState(() {
        data = userApiService().getUser();
      });
    } catch (error) {
      // Handle errors
      print('Error deleting user: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF752FFF),
        title: Text(
          "View User",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
          tooltip: 'View Package',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchUser()));
            },
            icon: Icon(Icons.search, color: Colors.white),
            tooltip: 'Search User',
          ),
        ],
      ),
      body: FutureBuilder<List<Viewuser>>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Viewuser user = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    if (user.paymentStatus == PaymentStatus.SUCCESS) {
                      showDialog(context: context, builder: (context) =>AlertDialog(title: Text('Payment Successful')));
                    } else {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePayment()));
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Payment Not Successful'),
                          content: Text('Update the payment status to allow the user to log in'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Card(
                    color: user.paymentStatus == PaymentStatus.SUCCESS
                        ? Colors.white.withOpacity(0.9)
                        : Colors.white.withOpacity(0.9),
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            radius: 27,
                            backgroundColor: user.paymentStatus == PaymentStatus.SUCCESS
                                ? Colors.lightGreen.shade900
                                : Color(0xFF830317),
                            child: Text(
                              user.name?.isNotEmpty ?? false ? user.name![0] : 'N',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          title: Text(
                            user.name ?? 'Null',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: user.paymentStatus == PaymentStatus.SUCCESS
                                  ? Colors.lightGreen.shade900
                                  : Color(0xFF830317),
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Gender: ${user.gender ?? 'Unknown'}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: user.paymentStatus == PaymentStatus.SUCCESS
                                      ? Colors.lightGreen.shade900
                                      : Color(0xFF830317),
                                ),
                              ),
                              Text(
                                "Contact Number: ${user.contactno ?? 'Unknown'}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: user.paymentStatus == PaymentStatus.SUCCESS
                                      ? Colors.lightGreen.shade900
                                      : Color(0xFF830317),
                                ),
                              ),
                              Text(
                                "Email Id: ${user.emailid ?? 'Unknown'}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: user.paymentStatus == PaymentStatus.SUCCESS
                                      ? Colors.lightGreen.shade900
                                      : Color(0xFF830317),
                                ),
                              ),
                              Text(
                                "Blood Group: ${user.bloodgroup ?? 'Unknown'}",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: user.paymentStatus == PaymentStatus.SUCCESS
                                      ? Colors.lightGreen.shade900
                                      : Color(0xFF830317),
                                ),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () => deleteUser(user.emailid ?? 'Unknown'), // Delete the user
                            icon: Icon(Icons.delete_forever, color: Colors.red),
                          ),
                        ),
                        Text("ID proof: ${user.idproof ?? 'Unknown'}"),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text('No data available.'),
            );
          }
        },
      ),
    );
  }
}
