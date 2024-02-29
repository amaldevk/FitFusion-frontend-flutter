import 'package:fitfusion_app/Models/TrainerModel.dart';
import 'package:fitfusion_app/Services/TrainerService.dart';
import 'package:flutter/material.dart';

class View_Trainer extends StatefulWidget {
  const View_Trainer({Key? key}) : super(key: key);

  @override
  State<View_Trainer> createState() => _View_TrainerState();
}

class _View_TrainerState extends State<View_Trainer> {
  late Future<List<Trainer>> data;

  @override
  void initState() {
    super.initState();
    data = TrainerApiService().getTrainerApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF752FFF),
        title: Text(
          "View Trainer",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
          tooltip: 'View Trainer',
        ),
      ),
      body: FutureBuilder<List<Trainer>>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Trainer trainer = snapshot.data![index];
                return Card(
                  color: Colors.white.withOpacity(0.9),
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 27,
                          backgroundColor: Color(0xFF000066),
                          child: Text(
                            trainer.name != null ? trainer.name![0] : '?',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                        title: Text(
                          "Trainer Name: ${trainer.name ?? 'Unknown'}",
                          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color(0xFF000066)),
                        ),
                        subtitle: Text(
                          "Gender: ${trainer.gender ?? 'Unknown'}\n"
                              "Contact Number: ${trainer.phnno ?? 'Unknown'}\n"
                              "Address: ${trainer.address ?? 'Unknown'}\n"
                              "Experience: ${trainer.experience ?? 'Unknown'}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
