import 'package:fitfusion_app/Models/DueModel.dart';
import 'package:fitfusion_app/Services/subscriptionServices.dart';
import 'package:flutter/material.dart';

class SubscriptionListView extends StatefulWidget {
  @override
  _SubscriptionListViewState createState() => _SubscriptionListViewState();
}

class _SubscriptionListViewState extends State<SubscriptionListView> {
  late Future<List<DueAmount>> _futureSubscriptions;

  @override
  void initState() {
    super.initState();
    _futureSubscriptions = SubscriptionService().getDueSubscriptions();
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DueAmount>>(
      future: _futureSubscriptions,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          List<DueAmount> subscriptions = snapshot.data!;
          return ListView.builder(
            itemCount: subscriptions.length,
            itemBuilder: (context, index) {
              DueAmount subscription = subscriptions[index];
              return ListTile(
                title: Text('Name: ${subscription.name}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Email: ${subscription.email}'),
                    Text('Package Name: ${subscription.packageName}'),
                    Text('Package Price: \$${subscription.packagePrice}'),
                    Text('Due Amount: \$${subscription.dueAmount}'),
                    Text('Remaining Days for Due: ${subscription.remainingDaysForDue}'),
                  ],
                ),
              );
            },
          );
        } else {
          return Center(child: Text('No data available'));
        }
      },
    );
  }
}

