import 'package:fitfusion_app/Services/UpdateService.dart';
import 'package:flutter/material.dart';


class UpdatePayment extends StatefulWidget {
  @override
  _UpdatePaymentState createState() => _UpdatePaymentState();
}

class _UpdatePaymentState extends State<UpdatePayment> {
  final UserService _userService = UserService();
  final TextEditingController _emailController = TextEditingController();
  String _paymentStatus = "paid";

  void _updatePaymentStatus() async {
    final email = _emailController.text;
    try {
      final status = await _userService.updatePaymentStatus(email, _paymentStatus);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Status'),
          content: Text(status),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text(error.toString()),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: "Email Id",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
              ),
            ),
            SizedBox(height: 20),
            Text('Payment Status'),
            DropdownButton<String>(
              value: _paymentStatus,
              onChanged: (String? value) {
                setState(() {
                  _paymentStatus = value!;
                });
              },
              items: <String>['paid', 'pending']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updatePaymentStatus,
              child: Text('Update Payment Status'),
            ),
          ],
        ),
      ),
    );
  }
}
