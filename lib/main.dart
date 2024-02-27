import 'package:fitfusion_app/pages/Admin_Login.dart';
import 'package:fitfusion_app/pages/userLogin.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(home());
}
class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AdminLogin(),
    );
  }
}


