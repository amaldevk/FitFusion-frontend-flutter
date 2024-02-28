import 'package:fitfusion_app/Services/userSearchServive.dart';
import 'package:flutter/material.dart';

class searchUser extends StatefulWidget {
  const searchUser({super.key});

  @override
  State<searchUser> createState() => _searchUserState();
}

class _searchUserState extends State<searchUser> {
  TextEditingController name=new TextEditingController();
  //List<dynamic> userdata=[];
  String userdata="";

  void FetchData() async{

   final response=await userSearchSer().getUser(name.text);
   setState(() {
     userdata=response;
   });
 }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("SEARCH SCREEN"),),
        body: Center(
          child: Container(padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(4),
                  Colors.white.withOpacity(4),
                ]
              )
            ),
            child: Column(
              children: [
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    labelText: "Enter name",
                    hintText: "Enter the user name",
                    border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 30,),
                ElevatedButton(onPressed: FetchData, child: Text("SEARCH")),
            SizedBox(height: 30),
            // Display the fetched data here, for example, in a ListView
            // Expanded(
            //   child: userdata.isNotEmpty
            //       ? ListView.builder(
            //     itemCount: userdata.length,
            //     itemBuilder: (context, index) {
            //       var user = userdata[index];
            //       return ListTile(
            //         title: Text(user['name']),
            //         subtitle: Text(user['address']),
            //         // Add other fields as needed
            //       );
            //     },
            //   )
            //       : Container(),)
                Text(userdata)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
