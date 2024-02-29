import 'package:fitfusion_app/Services/transactionservice.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class transactionPage extends StatefulWidget {
  const transactionPage({Key? key}) : super(key: key);

  @override
  State<transactionPage> createState() => _transactionPage();
}

class _transactionPage extends State<transactionPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  void sendmoney()async
  {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    String PackageId =prefer.getString("packageid") ?? "";
    SharedPreferences prefer2= await SharedPreferences.getInstance();
    String userId = prefer2.getString("userid") ?? "";
    final response = await PostApiService().sendData(userId, PackageId);
    if (response["status"] == "success") {
      print("Transaction added");
    }
    else {
      print("Payment Failed!!");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("PAYMENT"),
        backgroundColor: Color(0xFF752FFF),
      ),
      body:SingleChildScrollView(
        child: Container(

          decoration: BoxDecoration(
              color: Colors.black
          ),
          padding: EdgeInsets.symmetric(vertical: 220),
          child: Column(
            children: [
              SizedBox(width: 400,),
              Row(
                children: [
                  SizedBox(width: 40,),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                      ),
                      height: 500,
                      width: 400,
                      padding:EdgeInsets.all(8.0),
                      margin: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(height: 20,),

                          SizedBox(
                            height: 55,
                          ),
                          SizedBox(
                            height: 50,
                            width: 450,
                            child: Center(child:Text("AMOUNT")),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: 450,
                            height: 50,
                            child: Center(child: Text("DUE")),
                          ),
                          SizedBox(
                            height: 5,
                          ),

                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: 450,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Color(0xFF752FFF),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
                                ),onPressed:(){

                            }, child: Text("Make payment")),
                          ),
                          SizedBox(
                            height: 55,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Safe", style: TextStyle(color: Colors.black),),
                              TextButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                  ),onPressed: ()
                              {
                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                              }, child: Text("Secure"))
                            ],
                          )

                        ],
                      )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}