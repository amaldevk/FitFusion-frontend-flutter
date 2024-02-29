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
            icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.white),),
      ),
      body: FutureBuilder(
          future: data,
          builder: (context,AsyncSnapshot<List<Package>> snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData)            {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context,index){
                    return Card(
                      color: Colors.white.withOpacity(0.9),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text("Package Name:"+snapshot.data![index].packageName.toString(),style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold,color: Color(0xFF000066)),
                            ),
                            subtitle: Text("Price:"+snapshot.data![index].price.toString()
                                +"\n"+"Duration:"+snapshot.data![index].duration.toString()
                                +"\n"+"description:"+snapshot.data![index].description.toString()
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