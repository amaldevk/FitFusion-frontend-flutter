
import 'package:fitfusion_app/Models/PackageModel.dart';
import 'package:fitfusion_app/Services/PackageService.dart';
import 'package:flutter/material.dart';

class View_Package extends StatefulWidget {
  const View_Package({super.key});

  @override
  State<View_Package> createState() => _View_PackageState();
}

class _View_PackageState extends State<View_Package> {
  Future<List<Package>> ? data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data=PackageApiService().getPackageApi();
  }
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFF752FFF),
        title: Text("View Packages",style: TextStyle(color: Colors.white),),
        leading: IconButton(onPressed: () {Navigator.pop(context);},
            icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.white),tooltip: 'View Package'),
      ),
      body: FutureBuilder(
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
                            title: Text("Package Name:"+snapshot.data![index].packageName,style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Color(0xFF000066)),
                            ),
                            subtitle: Text("Price:"+snapshot.data![index].price
                                +"\n"+"Duration:"+snapshot.data![index].duration
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