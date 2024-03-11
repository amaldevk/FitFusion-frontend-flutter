import 'package:fitfusion_app/Services/dueService.dart';
import 'package:flutter/material.dart';
import 'package:fitfusion_app/Models/dueModel.dart';

class duePage extends StatefulWidget {
  final String userId;

  const duePage({Key? key, required this.userId}) : super(key: key);

  @override
  State<duePage> createState() => _duePageState();
}

class _duePageState extends State<duePage> {
  late Future<List<Due>> _dueList = Future.value([]);

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      _dueList = dueApiSer().fetchdue(widget.userId);
      if (mounted) {
        setState(() {
          print(_dueList);
        });
      }
    } catch (e) {
      // Handle exceptions
      print("Error fetching due information: $e");
      // Optionally, show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF752FFF),
        title: Text("Remaining days Information",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
          tooltip: 'Search User',
        ),
      ),
      body: FutureBuilder<List<Due>>(
        future: _dueList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error loading due information:',
                    style: TextStyle(color: Colors.red),
                  ),
                  Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData && snapshot.data == null) {
            // Check if data is null or empty
            return Center(
              child: Text(
                'No due information found.',
                style: TextStyle(color: Colors.grey),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final due = snapshot.data![index];

                return Card(
                  color: Colors.black,
                  child: ListTile(
                    title: Text(
                      'Package Name: ${due.packageName}',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Package Price: ${due.packagePrice}',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'New Package Duration: ${due.newPackageDuration} days',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          'Remaining days of current package: ${due.remainingDaysForDue} days',
                          style: TextStyle(color: Colors.white),
                        ),
                        // Add more information as needed
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
