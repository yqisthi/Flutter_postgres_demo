import 'package:flutter/material.dart';
import 'package:human_resources/pages/home_page.dart';
import 'package:human_resources/pages/login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HR APP",
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
