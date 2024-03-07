import 'dart:convert';
import 'package:fitfusion_app/Models/currentmodel.dart';
import 'package:fitfusion_app/Services/currentService.dart';
import 'package:flutter/material.dart';
import 'package:fitfusion_app/Models/subscriptionModel.dart';
import 'package:fitfusion_app/Services/subscriptionServices.dart';

class CurrentPackage extends StatefulWidget {
  //final String token;
  final String userId;

  const CurrentPackage({Key? key, required this.userId}) : super(key: key);//, required this.token,

  @override
  _CurrentPackageState createState() => _CurrentPackageState();
}

class _CurrentPackageState extends State<CurrentPackage> {
  late Future<List<Current>> _currentPackageList;

  @override
  void initState() {
    super.initState();
    _currentPackageList =
        CurrentApiSer().getPackage(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Selected Packages'),
      ),
      body: FutureBuilder<List<Current>>(
        future: _currentPackageList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error loading packages:',
                    style: TextStyle(color: Colors.red),
                  ),
                  Text(
                    '${snapshot.error}',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            );
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            // Check if data is null or empty
            return Center(
              child: Text(
                'No packages found.',
                style: TextStyle(color: Colors.grey),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final subscription = snapshot.data![index];
                final package = subscription.packageid!;
                final user = subscription.userid!;

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    // title: Text(
                    //   'Package Name: ${package.packageName}',
                    //   style: TextStyle(fontWeight: FontWeight.bold),
                    // ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Package Name: ${package.packageName}'),
                        Text('Price: ${package.price}'),
                        Text('Duration: ${package.duration}'),
                        // Assuming description and subscriptionDate are properties of subscription model
                        // Text('Description: ${subscription.description}'),
                        // SizedBox(height: 8),
                        // Text('Subscription Date: ${subscription.subscriptionDate}'),
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
