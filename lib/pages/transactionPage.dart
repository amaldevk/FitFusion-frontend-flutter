
import 'package:flutter/material.dart';

class transactionPage extends StatefulWidget {
  const transactionPage({Key? key}) : super(key: key);

  @override
  State<transactionPage> createState() => _transactionPage();
}

class _transactionPage extends State<transactionPage> {


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
                            child: Text(""),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: 450,
                            height: 50,
                            child: Text(""),
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
                                    backgroundColor: Colors.black,
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
                              Text("Don't you have account?", style: TextStyle(color: Colors.black),),
                              TextButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                  ),onPressed: ()
                              {
                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
                              }, child: Text("Safe"))
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
