import 'package:fitfusion_app/Models/PackageModel.dart';
import 'package:fitfusion_app/Services/PackageService.dart';
import 'package:fitfusion_app/pages/transactionPage.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectPackagePage extends StatefulWidget {
  const SelectPackagePage({Key? key}) : super(key: key);

  @override
  State<SelectPackagePage> createState() => _SelectPackagePageState();
}

class _SelectPackagePageState extends State<SelectPackagePage> {
  late Future<List<Package>> data;

  @override
  Future<void> initState() async {
    super.initState();
    data = PackageApiService().getPackageApi();
    final response=await PackageApiService().getPackageApi();
    // String packageId=response["packageid"]["_id"].toString();
    // SharedPreferences.setMockInitialValues({});
    // SharedPreferences preferences=await SharedPreferences.getInstance();
    // preferences.setString("packageid",packageId);
    // print(packageId);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Packages"),
        backgroundColor: Color(0xFF752FFF),
      ),
      body: Column(
        children: [
          Container(
            height: 400,
            color: Colors.white,

            child: FutureBuilder<List<Package>>(
              future: data,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: snapshot.data!.map((post) {
                      return Container(
                        width: 200,
                        height: 300, // Set width of the card as needed
                        child: Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 300,
                                child: ListTile(
                                  title:Row(children:[SizedBox(width:50), Text("${post.packageName}")]),
                                  subtitle: Column(
                                    children: [
                                      Text(
                                        "${post.price}\n ${post.duration}\n",
                                      ),
                                      ElevatedButton(onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>transactionPage()));
                                      }, child: Text("BUY"))
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
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          ElevatedButton(onPressed: (){}, child: Text("ViewUser"))
        ],
      ),
    );
  }
}
