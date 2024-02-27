import 'package:fitfusion_app/pages/Packege.dart';
import 'package:fitfusion_app/pages/Trainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(MenuPage());
}

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int currentIndex = 0; // Added currentIndex variable
  final List<Widget> pages = [
    Add_Packege(),
    Add_Trainer()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF752FFF), // Added app bar title
        ),
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            print(index);
            setState(() {
              currentIndex = index;
            });
          },
          currentIndex: currentIndex, // Added currentIndex to control active item
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_sharp, color: Color(0xFF752FFF)),
              label: "Package",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_sharp, color: Color(0xFF752FFF)),
              label: "Trainer",
            ),
            // Add other BottomNavigationBarItems here if needed
          ],
        ),
      ),
    );
  }
}
