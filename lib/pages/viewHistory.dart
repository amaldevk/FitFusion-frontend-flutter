import 'package:flutter/material.dart';
import 'package:fitfusion_app/Models/historymodel.dart';
import 'package:fitfusion_app/Services/historyService.dart';

class ViewHistory extends StatefulWidget {
  const ViewHistory({Key? key}) : super(key: key);

  @override
  _ViewHistoryState createState() => _ViewHistoryState();
}

class _ViewHistoryState extends State<ViewHistory> {
  late Future<List<HistoryEntry>> data;

  @override
  void initState() {
    super.initState();
    data = hisApiSer().gethistoryApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFF752FFF),
        title: Text(
          'View History',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<HistoryEntry>>(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No history entries available.'));
          } else {
            List<HistoryEntry> historyEntries = snapshot.data!;
            return ListView.builder(
              itemCount: historyEntries.length,
              itemBuilder: (context, index) {
                HistoryEntry historyEntry = historyEntries[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('User: ${historyEntry.userId?.name ??
                        'Unknown'}'),
                    subtitle:
                    Text('New Package: ${historyEntry.newPackageId.packageName}'+ "\n"+'Price: ${historyEntry.newPackageId.price}'+ "\n"+'Old Package: ${historyEntry.oldPackageId.packageName}'+"\n"+'Price: ${historyEntry.oldPackageId.price}'+ "\n"'Refund: ${historyEntry.refund}'),
                    // Add more details as needed
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

