import 'package:flutter/material.dart';
import 'package:fitfusion_app/Services/subscriptionServices.dart';

class UpdatePackagePage extends StatelessWidget {
  final String token;
  final String userId;
  final String newPackageId;

  UpdatePackagePage({
    required this.token,
    required this.userId,
    required this.newPackageId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Package'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              await
              // Navigate to the desired page after successful update
              Navigator.pop(context); // Close the update page
            } catch (e) {
              // Handle the error, show an error message to the user, log, etc.
              print('Error updating package: $e');
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Error'),
                    content: Text('Failed to update package. Please try again.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Text('Update Package'),
        ),
      ),
    );
  }
}
