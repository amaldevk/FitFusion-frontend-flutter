import 'package:fitfusion_app/pages/Menu.dart';
import 'package:fitfusion_app/pages/ViewUser.dart';
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
      Navigator.push(context, MaterialPageRoute(builder: (context)=>MenuPage()));
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
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xE4B7B8EA),
                    Color(0xFF5E06E3).withOpacity(0.3)
                  ]
              )
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage("assets/Gym.jpg",),
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
                obscureText:true,
                controller: password,
                obscureText: true,

                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter admin password",
                    suffixIcon: Icon(Icons.key),
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),

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

            ],
          ),
        ),
      ) ,
    );
  }
}