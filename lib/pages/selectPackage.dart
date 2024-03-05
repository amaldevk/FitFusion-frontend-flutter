
import 'package:flutter/material.dart';
import 'package:fitfusion_app/Models/PackageModel.dart';
import 'package:fitfusion_app/Services/PackageService.dart';
import 'package:fitfusion_app/pages/transactionPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class selectPackagepage extends StatefulWidget {
  const selectPackagepage({Key? key}) : super(key: key);

  @override
  State<selectPackagepage> createState() => _selectPackagepageState();
}

class _selectPackagepageState extends State<selectPackagepage> {
  late Future<List<Package>> data;
  late String userId;
  late String Uid;

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
        title: Text("PACKAGES",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          Container(
            height: 350,
            color: Colors.black,
            child: FutureBuilder<List<Package>>(
              future: data,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
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
                                            fontSize: 15
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
                                        "\n ${post.duration}\n\n",
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
                                            // Check if the user has already selected a package
                                            SharedPreferences preferences = await SharedPreferences.getInstance();
                                            bool packageSelected = preferences.getBool("packageSelected") ?? false;

                                            if (packageSelected) {
                                              // Display the prompt if the user has already selected a package
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text("Package Already Selected"),
                                                    content: Text("You have already selected a package. Please contact admin to change it."),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                        child: Text("OK"),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            } else {
                                              // Proceed with package selection if the user has not selected a package
                                              String packageName = post.packageName;
                                              final response = await PackageApiService().logpack(packageName);

                                              if (response["status"] == "success") {
                                                print("success");

                                                String packageId = response["userdata"]["_id"].toString();
                                                preferences.setString("packageid", packageId);
                                                preferences.setBool("packageSelected", true); // Mark package as selected
                                                print(packageId);
                                                preferences.setString("UserID", userId);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => transactionPage(),
                                                  ),
                                                );
                                              } else {
                                                print("invalid");
                                              }
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
                } else {
                  print(data);
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("My Profile"),
          ),
          Text("User ID: $userId"),
        ],
      ),
    );
  }
}
