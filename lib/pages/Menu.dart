import 'package:fitfusion_app/pages/Packege.dart';
import 'package:fitfusion_app/pages/Trainer.dart';
import 'package:fitfusion_app/pages/Update.dart';
import 'package:fitfusion_app/pages/ViewTransaction.dart';
import 'package:fitfusion_app/pages/ViewUser.dart';
import 'package:fitfusion_app/pages/due.dart';
import 'package:fitfusion_app/pages/viewHistory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}
List<Map<String, dynamic>> subscriptionDetails = [];
class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
              ListTile(title: const Text("UPDATE PAYMENT"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdatePayment()));
                },),
              ListTile(title: const Text("VIEW TRANSACTION"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewTransactionScreen()));
                },)  ,
              ListTile(title: const Text("VIEW DUE"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DueScreen(subscriptionDetails: subscriptionDetails)));
                },),
              ListTile(title: const Text("VIEW HISTORY"),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewHistory()));
                },)
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/home.png"), // Provide path to your background image
              fit: BoxFit.fitWidth,
            ),
          ),)
    );
  }
}

