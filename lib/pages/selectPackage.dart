import 'package:fitfusion_app/pages/duenew.dart';
import 'package:flutter/material.dart';
import 'package:fitfusion_app/Models/PackageModel.dart';
import 'package:fitfusion_app/Services/PackageService.dart';
import 'package:fitfusion_app/pages/transactionPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fitfusion_app/pages/CurrendPackage.dart';
import 'package:fitfusion_app/pages/buyPackage.dart';
import 'package:fitfusion_app/pages/userProfile.dart';

class SelectPackagePage extends StatefulWidget {
  const SelectPackagePage({Key? key}) : super(key: key);

  @override
  State<SelectPackagePage> createState() => _SelectPackagePageState();
}

class _SelectPackagePageState extends State<SelectPackagePage> {
  late Future<List<Package>> data;
  late String userId = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString("userid") ?? "";
    setState(() {
      data = PackageApiService().getPackageApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF752FFF),
        title: Text(
          "PACKAGES",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 360,
            color: Colors.black,
            child: FutureBuilder<List<Package>>(
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
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('No packages available.'),
                  );
                } else {
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: snapshot.data!.map((post) {
                      return Container(
                        width: 300,
                        height: 30,
                        child: Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 300,
                                child: ListTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${post.packageName}",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    children: [
                                      Text(
                                        "₹ ${post.price}",
                                        style: TextStyle(
                                          color: Color(0xFF752FFF),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 45,
                                        ),
                                      ),
                                      Text(
                                        "\n ${post.duration}\n",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "\n ${post.description}\n\n",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 90,
                                        height: 40,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                            Color(0xFF752FFF).withOpacity(0.8),
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                          ),
                                          onPressed: () async {
                                            String packageName = post.packageName;
                                            final response = await PackageApiService()
                                                .logpack(packageName);

                                            if (response["status"] == "success") {
                                              print("success");

                                              String packageId =
                                              response["userdata"]["_id"].toString();

                                              SharedPreferences.setMockInitialValues({});
                                              SharedPreferences preferences =
                                              await SharedPreferences.getInstance();
                                              preferences.setString("packageid", packageId);
                                              print(packageId);
                                              preferences.setString("userId", userId);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BuyPackage(userId: userId),
                                                ),
                                              );
                                            } else {
                                              print("invalid");
                                            }
                                          },
                                          child: Text("BUY"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ),
          SizedBox(height: 30),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF752FFF).withOpacity(0.8),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => View_profile()));
              },
              child: Text("My Profile"),
            ),
          ),
          SizedBox(height: 30),
          SizedBox(
            width: 200,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF752FFF).withOpacity(0.8),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CurrentPackage(
                            token: 'token',
                            userId: 'userId',
                          )));
                },
                child: Text("Current Package")),
          )
        ],
      ),
    );
  }
}
