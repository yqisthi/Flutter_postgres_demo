import 'package:flutter/material.dart';

class EditDataDialog extends StatelessWidget {
  final String emailParam;
  final String emailText;
  final String nameText;
  final String passwordText;
  final String roleText;

  final Function(String, String, String, String, String) onUpdate;

  EditDataDialog(
      {required this.emailParam,
      required this.emailText,
      required this.nameText,
      required this.passwordText,
      required this.roleText,
      required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController roleController = TextEditingController();

    // Set the initial values in the text fields
    emailController.text = emailText;
    nameController.text = nameText;
    passwordController.text = passwordText;
    roleController.text = roleText;

    return AlertDialog(
      title: Text('Edit Data for $emailParam'),
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
            // Call the onUpdate function with the entered data
            onUpdate(
              emailParam,
              emailController.text,
              nameController.text,
              passwordController.text,
              roleController.text,
            );
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Update'),
        ),
      ],
    );
  }
}
