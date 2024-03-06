import 'package:fitfusion_app/Services/subscriptionService.dart';
import 'package:fitfusion_app/pages/selectPackage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fitfusion_app/pages/transactionPage.dart';

class BuyPackage extends StatefulWidget {
  final String userId;

  const BuyPackage({Key? key, required this.userId}) : super(key: key);

  @override
  State<BuyPackage> createState() => _BuyPackageState();
}

class _BuyPackageState extends State<BuyPackage> {
  late String packageID;
  String message = '',UID='';

  @override
  void initState() {
    super.initState();
    _fetchIds();
  }

  Future<void> _fetchIds() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      packageID = preferences.getString("packageid") ?? "";
    });
  }
  void _showDialog(String title, String content, String imageAsset) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(color: Color(0xFF008000), fontSize: 20, fontWeight: FontWeight.bold),
        ),
        content: Image.asset(imageAsset),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SelectPackagePage())),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
  void buypkge() async {
    print("buy package is called");
    UID = widget.userId;

    try {
      final response = await subApiSer().buySub(widget.userId.toString(), packageID.toString());
      print("msg" + response["message"]);

      setState(() {
        message = response['message'];
      });

      if (message == "User already has a selected package") {
        _showDialog(
          'ALREADY HAVE A PACKAGE',
          'User already has a selected package',
          'assets/unsuccessfulGif.gif',
        );
      } else if (message == "Package selected successfully") {
        _showDialog(
          'Payment Successful',
          'Package selected successfully!',
          'assets/successGiff.gif',
        );
      } else {
        _showDialog(
          'Something Went Wrong',
          'Error: $message',
          'assets/sadGif.gif',
        );
      }
    } catch (e) {
      if (e.toString() == "Exception: User already has a selected packageeeee") {
        // Handle the case where the user already has a selected package
        _showDialog(
          'ALREADY HAVE A PACKAGE',
          'User already has a selected package',
          'assets/unsuccessfulGif.gif',
        );
      } else {
        print("Error in buypkge: $e");
        _showDialog(
          'Something Went Wrong',
          'Error: $e',
          'assets/sadGif.gif',
        );
      }
    }
  }


  // void buypkge() async {
  //   print("buy package is called");
  //   UID =widget.userId;
  //   final response = await subApiSer().buySub(widget.userId.toString(), packageID.toString());
  //   print("msg"+response["message"]);
  //   setState(() {
  //     message = response['message'];
  //   });
  //   if (message=="User already has a selected package") {
  //     setState(() {
  //       showDialog(
  //         context: context,
  //         builder: (_) => AlertDialog(
  //           title: Text('ALREADY HAVE A PACKAGE',
  //             style: TextStyle(color: Color(0xFF008000),fontSize: 20,fontWeight: FontWeight.bold),),
  //           content: Image.asset('assets/unsuccessfulGif.gif'),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>SelectPackagePage())),
  //               child: Text('OK'),
  //             ),
  //           ],
  //         ),
  //       );
  //       print("User already has a selected package");
  //       // Handle the case where the user already has a selected package
  //     }
  //   );
  //   } else if (message == "Package selected successfully") {
  //     setState(() {
  //       showDialog(
  //         context: context,
  //         builder: (_) => AlertDialog(
  //           title: Text('Payment Successfull',
  //             style: TextStyle(color: Color(0xFF008000),fontSize: 20,fontWeight: FontWeight.bold),),
  //           content: Image.asset('assets/successGiff.gif'),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>SelectPackagePage())),
  //               child: Text('OK'),
  //             ),
  //           ],
  //         ),
  //       );
  //       print("Package selected successfully!");
  //       // Handle the case where the package is successfully selected
  //       // You can navigate to a new screen or update the UI accordingly
  //     });
  //   } else {
  //     showDialog(
  //       context: context,
  //       builder: (_) => AlertDialog(
  //         title: Text('Something went wrong',
  //           style: TextStyle(color: Color(0xFF008000),fontSize: 20,fontWeight: FontWeight.bold),),
  //         content: Image.asset('assets/sadGif.gif'),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>SelectPackagePage())),
  //             child: Text('OK'),
  //           ),
  //         ],
  //       ),
  //     );
  //     print("Error: $message");
  //     // Handle other cases if needed
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF752FFF),
          title: Text(
            "Buy Package",
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_sharp, color: Colors.white),
            tooltip: 'Search User',
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            SizedBox(height: 15),

              SizedBox(
                width: 100,height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF752FFF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  onPressed: buypkge,
                  child: Text("Make Payment"),
                ),
              ),

            SizedBox(height: 55),
            //Text("userID :"+widget.userId+"\npackageID :"+packageID)

          ],
        ),
      ),
    );
  }
}
