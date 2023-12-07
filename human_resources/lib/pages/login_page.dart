import 'package:flutter/material.dart';
import 'package:human_resources/pages/admin_page.dart';
import 'package:human_resources/pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    final String apiUrl = 'http://localhost:8080/getdata';
    String queryString = 'email=$email&password=$password';
    String urlWithParameters = '$apiUrl?$queryString';

    try {
      final response = await http.get(Uri.parse(urlWithParameters));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        if (data.isNotEmpty) {
          Map<String, dynamic> user = data[0];

          // Access the user data
          String userName = user['name'];
          String userRole = user['role'];

          // Navigate to HomePage on successful login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AdminPage(name: userName, role: userRole),
            ),
          );
          if (userRole == "admin") {
          } else if (userRole != "admin") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(name: userName, role: userRole),
              ),
            );
          }
        } else {
          // Handle case where no matching user is found
          // setState(() {
          //   result = 'No user found with the provided email and password.';
          // });
        }
      } else {
        // Handle error cases
        setState(() {
          // result = 'Error: ${response.statusCode}\n${response.body}';
        });
      }
    } catch (e) {
      // Handle network or other errors
      setState(() {
        // result = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login'),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
