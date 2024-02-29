import 'package:fitfusion_app/Models/PackageModel.dart';
import 'package:fitfusion_app/Services/PackageService.dart';
import 'package:fitfusion_app/Services/userService.dart';
import 'package:fitfusion_app/pages/transactionPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class selectPackagepage extends StatefulWidget {
  const selectPackagepage({super.key});

  @override
  State<selectPackagepage> createState() => _selectPackagepageState();
}

class _selectPackagepageState extends State<selectPackagepage> {
  late Future<List<Package>> data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = PackageApiService().getPackageApi();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("PACKAGES"),
      ),
      body: Column(
        children: [
          Container(
            height: 350,
            color: Colors.black,
            child: FutureBuilder<List<Package>>(
              future: data,
              builder: (context,snapshot) {
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: snapshot.data!.map((post) {
                      return Container(
                        width: 300,
                        height: 30, // Set width of the card as needed
                        child: Card(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 300,
                                child: ListTile(
                                  title:Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children:[

                                        Text("${post.packageName}",style: TextStyle(
                                            color: Colors.black,fontWeight: FontWeight.bold
                                        ),)]),
                                  subtitle: Column(
                                    children: [
                                      Text(
                                        "${post.price}",style: TextStyle(
                                        color: Color(0xFF752FFF),fontWeight: FontWeight.bold,fontSize: 45,
                                      ),
                                      ),
                                      Text(
                                        "\n ${post.duration}\n\n",style: TextStyle(
                                          color: Colors.black,fontWeight: FontWeight.bold
                                      ),
                                      ),

                                      SizedBox(
                                        width: 90,height: 40,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Color(0xFF752FFF).withOpacity(0.8),
                                                foregroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(4)
                                                )
                                            ),
                                            onPressed: ()async{
                                              String packageName=post.packageName;
                                              final response= await PackageApiService().logpack(packageName);
                                              if(response["status"]=="success"){
                                                print("success");
                                                String packageId=response["userdata"]["_id"].toString();
                                                SharedPreferences.setMockInitialValues({});
                                                SharedPreferences preferences=await SharedPreferences.getInstance();
                                                preferences.setString("packageid",packageId);
                                                print(packageId);
                                                Navigator.push(context, MaterialPageRoute(builder: (context)=>transactionPage()));
                                              }
                                              else
                                              {
                                                print("invalid");
                                              }

                                            }, child: Text("BUY")),
                                      )
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
          ElevatedButton(onPressed: (){}, child: Text("My Profile"))
        ],
      ),
    );
  }
}
