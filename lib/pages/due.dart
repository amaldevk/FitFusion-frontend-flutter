import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DueScreen extends StatelessWidget {
  final List<Map<String, dynamic>> subscriptionDetails;

  const DueScreen({Key? key, required this.subscriptionDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Due Subscriptions'),
      ),
      body: ListView.builder(
        itemCount: subscriptionDetails.length,
        itemBuilder: (context, index) {
          final subscription = subscriptionDetails[index];
          return Card(
            child: ListTile(
              title: Text('Name: ${subscription['name']}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email ID: ${subscription['emailid']}'),
                  Text('Package Name: ${subscription['packageName']}'),
                  Text('Package Price: ${subscription['packagePrice']}'),
                  Text('Due Amount: ${subscription['dueAmount']}'),
                  Text('Remaining Days for Due: ${subscription['remainingDaysForDue']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
