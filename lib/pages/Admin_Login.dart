import 'package:fitfusion_app/pages/Approval.dart';
import 'package:fitfusion_app/pages/Menu.dart';
import 'package:fitfusion_app/pages/Update.dart';
import 'package:flutter/material.dart';
class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController username=new TextEditingController();
  TextEditingController password=new TextEditingController();

  void checkCredential(){
    if(username.text == "admin" && password.text=="admin" ){
      print("successful login");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminApprovalPage()));
    }
    else{
      print("Incorrect username or password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF752FFF),
          title: Text("Admin", style: TextStyle(color: Colors.white)),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
            tooltip: 'Admin',
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xE4B7B8EA),
                    Color(0xFF5E06E3)
                  ]
              )
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/Admin.jpg",),
                radius: 80,
              ),
              SizedBox(height: 50,),
              TextField(
                controller: username,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: "Username",
                    hintText: "Enter admin username",
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                    )
                ),
              ),
              SizedBox(height: 35,),
              TextField(
                obscureText: true,
                controller: password,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter admin password",
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)
                    )
                ),
              ),
              SizedBox(height: 55,),
              SizedBox(
                height: 45,
                width: 200,
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.white),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    onPressed: checkCredential,
                    child: Text("SIGN IN")),
              ),
              SizedBox(height: 55,)
            ],
          ),
        ),
      ) ,
    );
  }
}