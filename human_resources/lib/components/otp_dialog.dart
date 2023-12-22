import 'package:flutter/material.dart';
import 'package:human_resources/pages/admin_page.dart';
import 'package:human_resources/pages/home_page.dart';

class OtpDialog extends StatelessWidget {
  Map<String, dynamic> user;
  TextEditingController otpController = TextEditingController(); // Move it here

  OtpDialog({required this.user});

  void userPage(Map<String, dynamic> user, context) {
    String userName = user['name'];
    String userRole = user['role'];
    if (userRole == "admin") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdminPage(name: userName, role: userRole),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AdminPage(name: userName, role: userRole),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String otpParam = user['otp'];
    String emailParam = user['email'];

    return AlertDialog(
      title: Text('Please fill OTP Code for $emailParam'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: otpController,
              decoration: InputDecoration(labelText: 'OTP Code'),
            )
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (otpController.text == otpParam) {
              print("otp is correct");
              userPage(user, context);
            } else {
              print("something wrong");
            }
            // Call the onUpdate function with the entered data
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Confirm'),
        ),
      ],
    );
  }
}
