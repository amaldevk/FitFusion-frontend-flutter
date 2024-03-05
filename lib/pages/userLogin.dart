import 'package:fitfusion_app/Services/userService.dart';
import 'package:fitfusion_app/pages/Admin_Login.dart';
import 'package:fitfusion_app/pages/selectPackage.dart';
import 'package:fitfusion_app/pages/userRegister.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String email="",password="",message="";
  TextEditingController n1 =new TextEditingController();
  TextEditingController n2 =new TextEditingController();

  void loginCheck() async{
    final response = await userApiService().loginApi(n1.text, n2.text);

     if(response["status"]=="success"){

      String userId =response["userdata"]["_id"].toString();
      String userToken =response["token"].toString();

      SharedPreferences.setMockInitialValues({});
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("userid", userId);
      preferences.setString("token", userToken);

      print("successfull uid"+userId);
      print("Token is:"+userToken);

      Navigator.push(context,MaterialPageRoute(builder: (context)=>selectPackagepage()));
    }

    else if(response["status"]=="Invalid user"){
      setState(() {
        message="Invalid emailID";
      });
    }
    else if(response["status"]=="Incorrect password"){
      setState(() {
        message="Invalid Password";
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(

          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 90,),

              CircleAvatar(
                  radius: 100,
                  child:SvgPicture.asset("assets/Mobile login-rafiki.svg")

              ),
              SizedBox(height:40,),
              TextField(
                controller: n1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "EmailID",
                  fillColor: Color(0xFF0dadae0).withOpacity(0.2),
                  filled: true,
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: n2,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Password",
                    fillColor: Color(0xFF0dadae0).withOpacity(0.2),
                    filled: true,
                    suffixIcon: Icon(Icons.key)
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: 600,height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF752FFF).withOpacity(0.6),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)
                        )
                    ),
                    onPressed:loginCheck, child: Text("Log In ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
              ),
              SizedBox(height: 30,),
              Row( mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Text(message,style: TextStyle(fontSize: 15,color:Colors.red )),],
              ),
              SizedBox(height: 10,),
              Text("OR",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Colors.black45 )),
              SizedBox(height: 30,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                   onTap:(){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>UserRegister()));
                    },
                  child: Text("Register",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Color(0xFF752FFF).withOpacity(0.7) )),
                  ),
                SizedBox(width: 35,),
               GestureDetector(
              onTap:(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminLogin()));},
              child: Text("AdminLogin",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color:Color(0xFF752FFF) )),
               )
                ],
              ),
            ],

          ),

        ),
      ),
    );
  }
}
