import 'package:flutter/material.dart';

class CreateDataDialog extends StatelessWidget {
  final Function(String, String, String, String) onCreate;

  CreateDataDialog({required this.onCreate});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController roleController = TextEditingController();

    return AlertDialog(
      title: Text('Create New Data'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            TextField(
              controller: roleController,
              decoration: InputDecoration(labelText: 'Role'),
            ),
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
            // Call the onCreate function with the entered data
            onCreate(
              emailController.text,
              nameController.text,
              passwordController.text,
              roleController.text,
            );
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Create'),
        ),
      ],
    );
  }
}
