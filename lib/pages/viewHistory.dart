import 'package:fitfusion_app/pages/duePage.dart';
import 'package:flutter/material.dart';
import 'package:fitfusion_app/Models/historymodel.dart';
import 'package:fitfusion_app/Services/historyService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewHistory extends StatefulWidget {
  const ViewHistory({Key? key}) : super(key: key);

  @override
  _ViewHistoryState createState() => _ViewHistoryState();
}

class _ViewHistoryState extends State<ViewHistory> {
  late Future<List<HistoryEntry>> data;
  late String userId="";

  @override
  void initState() {
    super.initState();
    getUserId();
    data = hisApiSer().gethistoryApi();
  }
  Future<void> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userId = preferences.getString("userid") ?? ""; // Replace with your actual key
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF752FFF),
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
                    title: Text('User: ${historyEntry.userId?.name ?? 'Unknown'}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('New Package: ${historyEntry.newPackageId?.packageName}'),
                        Text('Price: ${historyEntry.newPackageId?.price}'),
                        Text('Old Package: ${historyEntry.oldPackageId?.packageName}'),
                        Text('Price: ${historyEntry.oldPackageId?.price}'),
                        Text('Refund: ${historyEntry.refund}'),
                       // Text('Updated At: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(historyEntry.updatedAt)}'),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                       // Handle the Due action here
                        //For example, navigate to the DuePage
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => duePage(userId:historyEntry.userId?.id ?? ""),
                          ),
                        );
                      },
                      child: Text('Due'),
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
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(backgroundColor: Color(0xFF752FFF),
//         title: Text(
//           'View History',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: FutureBuilder<List<HistoryEntry>>(
//         future: data,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No history entries available.'));
//           } else {
//             List<HistoryEntry> historyEntries = snapshot.data!;
//             return ListView.builder(
//               itemCount: historyEntries.length,
//               itemBuilder: (context, index) {
//                 HistoryEntry historyEntry = historyEntries[index];
//                 return Card(
//                   margin: EdgeInsets.all(8.0),
//                   child: ListTile(
//                     title: Text('User: ${historyEntry.userId?.name ??
//                         'Unknown'}'),
//                     subtitle:
//                     Text('New Package: ${historyEntry.newPackageId.packageName}'+ "\n"+'Price: ${historyEntry.newPackageId.price}'+ "\n"+'Old Package: ${historyEntry.oldPackageId.packageName}'+"\n"+'Price: ${historyEntry.oldPackageId.price}'+ "\n"'Refund: ${historyEntry.refund}'),
//                     // Add more details as needed
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
//
