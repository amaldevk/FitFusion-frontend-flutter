import 'package:flutter/material.dart';
import 'package:fitfusion_app/Models/viewUserModel.dart';
import 'package:fitfusion_app/pages/searchUser.dart';
import 'package:fitfusion_app/Services/userService.dart';

class viewUser extends StatefulWidget {
  const viewUser({Key? key});

  @override
  State<viewUser> createState() => _viewUserState();
}

class _viewUserState extends State<viewUser> {
  Future<List<Viewuser>>? data;

  @override
  void initState() {
    super.initState();
    data = userApiService().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                  return Card(
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
                              user.name[0],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          title: Text(
                            user.name,
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: user.paymentStatus == PaymentStatus.SUCCESS
                                  ? Colors.lightGreen.shade900
                                  : Color(0xFF830317),
                            ),
                          ),
                          subtitle: Text(
                            "Gender: " +
                                user.gender +
                                "\n" +
                                "Contact Number: " +
                                user.contactno +
                                "\n" +
                                "Email Id: " +
                                user.emailid +
                                "\n" +
                                "Blood Group: " +
                                user.bloodgroup,
                            style: TextStyle(
                              fontSize: 16,
                              color: user.paymentStatus == PaymentStatus.SUCCESS
                                  ? Colors.lightGreen.shade900
                                  : null,
                            ),
                          ),
                        ),
                        Text("ID proof: " + user.idproof),
                        SizedBox(height: 10),
                      ],
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
      ),
    );
  }
}
