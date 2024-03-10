import 'dart:convert';
import 'package:fitfusion_app/pages/updatepackage.dart';
import 'package:flutter/material.dart';
import 'package:fitfusion_app/Models/currentSubscriptionModel.dart';
import 'package:fitfusion_app/Services/subscriptionServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentPackage extends StatefulWidget {


  const CurrentPackage({Key? key}) : super(key: key);

  @override
  _CurrentPackageState createState() => _CurrentPackageState();
}

class _CurrentPackageState extends State<CurrentPackage> {
  late Future<List<Subscribe>> _currentPackageList=Future.value([]);


  @override
  void initState() {
    super.initState();
    loadData();
  }
  Future<void> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString("userid") ?? "";
    String token = prefs.getString("token") ?? "";
    print("User Id is :"+userId);
    print("Token is:" + token);

    try {
      _currentPackageList = SubscriptionService.fetchCurrentPackage(token, userId);
      if (_currentPackageList != null && mounted) {
        setState(() {
          print(_currentPackageList);
        });
      }
    } catch (e) {
      // Handling exceptions that might be thrown by UserServiceApi().searchData()
      print("Error fetching user data: $e");
      // Optionally, show an error message to the user
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xFF752FFF),
        title: Text("Current Selected Packages",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
          tooltip: 'Search User',
        ),
      ),


      body: FutureBuilder<List<Subscribe>>(
        future: _currentPackageList,
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
          } else if (snapshot.hasData && snapshot.data==null) {
            // Check if data is null or empty
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
                final package = subscription.packageId!;
                final user = subscription.userId!;
                return SizedBox(
                  height: 400,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: Card(
                    color: Colors.black,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text(
                        'Name :${package.packageName}',style: TextStyle(
                      color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                      ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Price: ${package.price}', style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25
                          ),),
                          Text('Duration: ${package.duration}', style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 23
                          ),),
                          Text('${package.description}', style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),),
                          Text('Subscription date:${subscription.subscriptionDate}', style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),),
                          SizedBox(
                            width: 200,
                            child: ElevatedButton(
                              style:ElevatedButton.styleFrom(
                                backgroundColor:
                                Color(0xFF752FFF).withOpacity(0.8),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ) ,

                              onPressed: ()  {Navigator.push(context, MaterialPageRoute(builder: (context) => updatepackage(),
                                  ),
                                );

                              },
                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>View_profile(userId: userId)));
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>updatepackage()));
                              child: Text("UPDATE PACKAGE"),
                            ),
                          ),

                          // Assuming description and subscriptionDate are properties of subscription model
                          // Text('Description: ${subscription.description}'),
                          // SizedBox(height: 8),
                          // Text('Subscription Date: ${subscription.subscriptionDate}'),
                        ],
                      ),
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
