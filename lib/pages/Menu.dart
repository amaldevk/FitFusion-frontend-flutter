import 'package:fitfusion_app/pages/Packege.dart';
import 'package:fitfusion_app/pages/Trainer.dart';
import 'package:fitfusion_app/pages/Update.dart';
import 'package:fitfusion_app/pages/ViewUser.dart';
import 'package:fitfusion_app/pages/searchUser.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("ADMIN ",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
            backgroundColor: Color(0xFF752FFF),
        foregroundColor: Colors.white,),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent
                  ),
                  child: Text("MY LIST",style: TextStyle(fontSize: 15,color: Colors.white),),),
              ListTile(title: const Text("ADD PACKAGES"),
                onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Add_Packege()));
                },),
              ListTile(title: const Text("ADD TRAINERS"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Add_Trainer()));
                },),
              ListTile(title: const Text("VIEW USER"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>viewUser()));
                },),
              ListTile(title: const Text("SEARCH USER"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchUser()));
                },),
              ListTile(title: const Text("UPDATE PAYMENT"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdatePayment()));
                },)
            ],
          ),
        ),
      ),
    );
  }
}
