
import 'package:fitfusion_app/Services/PackageService.dart';
import 'package:fitfusion_app/pages/ViewPackage.dart';
import 'package:flutter/material.dart';
class Add_Packege extends StatefulWidget {
  const Add_Packege({super.key});
  @override
  State<Add_Packege> createState() => _Add_PackegeState();
}
class _Add_PackegeState extends State<Add_Packege> {
  TextEditingController packageName=new TextEditingController();
  TextEditingController price=new TextEditingController();
  TextEditingController duration=new TextEditingController();
  TextEditingController description=new TextEditingController();

  void SendValuesToApiAddPackage() async {

    final response = await PackageApiService().addPackageApi(
        packageName.text,
        price.text,
        duration.text,
        description.text);

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
        title: Text("Packages",style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          IconButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => View_Package()));},
              icon: Icon(Icons.remove_red_eye_rounded, color: Colors.white),tooltip: 'View Package'),
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
                controller: packageName,
                decoration: InputDecoration(
                    labelText: "Package Name",
                    hintText: "Enter  Package name",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: price,
                decoration: InputDecoration(
                    labelText: "Price",
                    hintText: "Enter Price",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              SizedBox(height: 25,),
              TextField(
                controller: duration,
                decoration: InputDecoration(
                    labelText: "Duration",
                    hintText: "Enter Duration",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                ),
              ),
              SizedBox(height: 25,),
              TextField(
                controller: description,
                decoration: InputDecoration(
                    labelText: "description",
                    hintText: "Enter description ",
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
                    onPressed:SendValuesToApiAddPackage, child:Text("Add",style: TextStyle(fontSize:20 ),)),),
            ],
          ),
        ),
      ),);
  }
}