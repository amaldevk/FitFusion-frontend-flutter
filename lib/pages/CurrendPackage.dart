import 'package:fitfusion_app/Services/transactionservice.dart';
import 'package:flutter/material.dart';

class CurrentPackagePage extends StatefulWidget {
  final String userId;

  const CurrentPackagePage({Key? key, required this.userId}) : super(key: key);

  @override
  _CurrentPackagePageState createState() => _CurrentPackagePageState();
}

class _CurrentPackagePageState extends State<CurrentPackagePage> {
  late Future<String> _currentPackage = Future.value(""); // Initialize with an empty string

  @override
  void initState() {
    super.initState();
    _fetchCurrentPackage();
  }

  Future<void> _fetchCurrentPackage() async {
    try {
      final currentPackage = await PostApiService.getSelectedPackage(widget.userId);
      setState(() {
        _currentPackage = Future.value(currentPackage);
      });
    } catch (error) {
      setState(() {
        _currentPackage = Future.error('Failed to fetch current package: $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Package'),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: _currentPackage,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Text('Current Package: ${snapshot.data}');
            }
          },
        ),
      ),
    );
  }
}
