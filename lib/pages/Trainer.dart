import 'package:fitfusion_app/Services/TrainerService.dart';
import 'package:fitfusion_app/pages/ViewTrainers.dart';
import 'package:flutter/material.dart';
class Add_Trainer extends StatefulWidget {
  const Add_Trainer({super.key});
  @override
  State<Add_Trainer> createState() => _Add_TrainerState();
}
class _Add_TrainerState extends State<Add_Trainer> {
  TextEditingController name=new TextEditingController();
  TextEditingController gender=new TextEditingController();
  TextEditingController phnno=new TextEditingController();
  TextEditingController address=new TextEditingController();
  TextEditingController experience=new TextEditingController();

  void SendValuesToApiAddTrainer() async {

    final response = await TrainerApiService().addTrainerApi(
        name.text,
        gender.text,
        phnno.text,
        address.text,
        experience.text);

    if(response["status"]=="success")
    {

      print("successfully added");
    }
    else
    {
      print("Error");
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFF752FFF),
        title: Text("Trainers",style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => View_Trainer()));},
              icon: Icon(Icons.remove_red_eye_rounded, color: Colors.white),tooltip: 'View Trainer'),
        ],),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white
          ),
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 60,),
              TextField(
                controller: name,
                decoration: InputDecoration(
                    labelText: "Name",
                    hintText: "Enter Name",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: gender,
                decoration: InputDecoration(
                    labelText: "Gender",
                    hintText: "Enter Gender",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              SizedBox(height: 25,),
              TextField(
                controller: phnno,
                decoration: InputDecoration(
                    labelText: "Phone Number",
                    hintText: "Enter phone n.o",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: address,
                decoration: InputDecoration(
                    labelText: "Address",
                    hintText: "Enter Address",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: experience,
                decoration: InputDecoration(
                    labelText: "Experience",
                    hintText: "Enter Experience",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              SizedBox(height: 25,),
              SizedBox(
                height: 45,
                width: 150,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF752FFF),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )),
                    onPressed:SendValuesToApiAddTrainer, child:Text("Add",style: TextStyle(fontSize:20 ),)),),
            ],
          ),
        ),
      ),
    );
  }
}