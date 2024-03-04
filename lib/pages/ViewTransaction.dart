import 'package:fitfusion_app/Models/TransactionModel.dart';
import 'package:fitfusion_app/Services/transactionservice.dart';
import 'package:flutter/material.dart';
class ViewTransactionScreen extends StatefulWidget {
  const ViewTransactionScreen({Key? key}) : super(key: key);

  @override
  _ViewTransactionScreenState createState() => _ViewTransactionScreenState();
}

class _ViewTransactionScreenState extends State<ViewTransactionScreen> {
  late Future<List<Post2>> data;

  @override
  void initState() {
    super.initState();
    data = PostApiService().getAllTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF752FFF),
        title: Text(
          'View Transactions',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<Post2>>(
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
                Post2 transaction = snapshot.data![index];
                return Card(
                  color: Colors.white.withOpacity(0.9),
                  child: ListTile(
                    title: Text('User ID: ${transaction.userid}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Package ID: ${transaction.packageid}'),
                        Text('Post Date: ${transaction.postdate}'),
                      ],
                    ),
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

