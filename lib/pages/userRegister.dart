import 'package:fitfusion_app/Services/userService.dart';
import 'package:fitfusion_app/pages/userLogin.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class UserRegister extends StatefulWidget {
  const UserRegister({Key? key}) : super(key: key);

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  String status = "Pending";
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController contactno = TextEditingController();
  TextEditingController emailid = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController bloodgroup = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController idproof = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != DateTime.now()) {
      setState(() {
        dob.text = DateFormat('yyyy-MM-dd').format(picked); // Using DateFormat here
        _calculateAge(picked);
      });
    }
  }

  void _calculateAge(DateTime selectedDate) {
    DateTime currentDate = DateTime.now();
    int userAge = currentDate.year - selectedDate.year;
    if (currentDate.month < selectedDate.month ||
        (currentDate.month == selectedDate.month &&
            currentDate.day < selectedDate.day)) {
      userAge--;
    }

    setState(() {
      age.text = userAge.toString();
    });
  }

  void regUser() async {
    final response = await userApiService().Sentdata(
      name.text,
      address.text,
      dob.text,
      age.text,
      contactno.text,
      emailid.text,
      gender.text,
      bloodgroup.text,
      height.text,
      weight.text,
      idproof.text,
      username.text,
      password.text,
      status,
    );

    if (response['status'] == 'success') {
      print("Successfully added");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()), // Replace LoginPage with your actual login page
      );
    } else {
      print("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF752FFF),
          title: Text(
            "FitFusion",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your name",
                    labelText: "Name",
                    fillColor: Color(0xFF0dadae0).withOpacity(0.2),
                    filled: true,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: address,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your address",
                    labelText: "Address",
                    fillColor: Color(0xFF0dadae0).withOpacity(0.2),
                    filled: true,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(height: 20),
                TextField(
                  controller: age,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your age",
                    labelText: "Age",
                    fillColor: Color(0xFF0dadae0).withOpacity(0.2),
                    filled: true,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: contactno,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your contact No.",
                    labelText: "Contact No.",
                    fillColor: Color(0xFF0dadae0).withOpacity(0.2),
                    filled: true,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: dob,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "DoB",
                    labelText: "Date of Birth",
                    fillColor: Color(0xFF0dadae0).withOpacity(0.2),
                    filled: true,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: emailid,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter your email ID",
                    labelText: "Email ID",
                    fillColor: Color(0xFF0dadae0).withOpacity(0.2),
                    filled: true,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: gender,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "F/M",
                    labelText: "Gender",
                    fillColor: Color(0xFF0dadae0).withOpacity(0.2),
                    filled: true,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: bloodgroup,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Blood group",
                    labelText: "Blood group",
                    fillColor: Color(0xFF0dadae0).withOpacity(0.2),
                    filled: true,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 45,
                      width: 120,
                      child: TextField(
                        controller: height,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Height",
                          fillColor: Color(0xFF0dadae0).withOpacity(0.2),
                          filled: true,
                        ),
                      ),
                    ),
                    SizedBox(width: 50),
                    SizedBox(
                      height: 45,
                      width: 120,
                      child: TextField(
                        controller: weight,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Weight",
                          fillColor: Color(0xFF0dadae0).withOpacity(0.2),
                          filled: true,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                TextField(
                  controller: idproof,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "ID proof no.",
                    labelText: "ID proof no.",
                    fillColor: Color(0xFF0dadae0).withOpacity(0.2),
                    filled: true,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: username,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "User Name",
                    labelText: "User Name",
                    fillColor: Color(0xFF0dadae0).withOpacity(0.2),
                    filled: true,
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Password",
                    labelText: "Password",
                    fillColor: Color(0xFF0dadae0).withOpacity(0.2),
                    filled: true,
                    suffixIcon: Icon(Icons.key_outlined, color: Color(0xFF752FFF)),
                  ),
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: 200,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF752FFF).withOpacity(0.9),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: regUser,
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(UserRegister());
}
