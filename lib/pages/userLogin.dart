import 'package:flutter/material.dart';

class searchUser extends StatefulWidget {
  const searchUser({super.key});

  @override
  State<searchUser> createState() => _searchUserState();
}

class _searchUserState extends State<searchUser> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 100,),
                TextField(decoration: InputDecoration(
                  labelText: "Enter Name",
                  hintText: "enter the user name",
                  border: OutlineInputBorder()
                ),),
                SizedBox(height: 35,),
                ElevatedButton(onPressed: ()
                    {

                    }, child: Text("SEARCH"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
