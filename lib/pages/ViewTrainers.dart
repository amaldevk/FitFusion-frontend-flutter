import 'package:fitfusion_app/Models/TrainerModel.dart';
import 'package:fitfusion_app/Services/TrainerService.dart';
import 'package:flutter/material.dart';

class View_Trainer extends StatefulWidget {
  const View_Trainer({super.key});

  @override
  State<View_Trainer> createState() => _View_TrainerState();
}

class _View_TrainerState extends State<View_Trainer> {
  Future<List<Trainer>> ? data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data=TrainerApiService().getTrainerApi();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFF752FFF),
        title: Text("View Trainer",style: TextStyle(color: Colors.white),),
        leading: IconButton(onPressed: () {Navigator.pop(context);},
            icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.white),tooltip: 'View Package'),
      ),
      body:  FutureBuilder(
          future: data,
          builder: (context,snapshot){
            if(snapshot.hasData && snapshot.data!.isNotEmpty)
            {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context,index){
                    return Card(
                      color: Colors.white.withOpacity(0.9),
                      child: Column(
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              radius: 27,
                              backgroundColor: Color(0xFF000066),
                              child: Text(snapshot.data![index].name[0],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
                            ),
                            title: Text("Trainer Name:"+snapshot.data![index].name,style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Color(0xFF000066)),
                            ),
                            subtitle: Text("Gender:"+snapshot.data![index].gender
                                +"\n"+"Contact Number:"+snapshot.data![index].phnno
                                +"\n"+"Address:"+snapshot.data![index].address
                                +"\n"+"Experience:"+snapshot.data![index].experience
                              ,style:TextStyle(fontSize: 16) ,
                            ),
                          ),
                          SizedBox(height: 10,)
                        ],
                      ),
                    );
                  });
            }
            else
            {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}