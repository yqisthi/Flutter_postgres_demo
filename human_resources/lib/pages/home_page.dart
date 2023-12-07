import "package:flutter/material.dart";

import 'package:flutter/material.dart';
import 'package:human_resources/components/header.dart';
import 'package:human_resources/components/menu.dart';
import 'package:human_resources/components/profile.dart';
import 'package:human_resources/theme.dart';

class HomePage extends StatelessWidget {
  final String name;
  final String role;
  const HomePage({super.key, required this.name, required this.role});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: limeGreen,
        title: const Header(),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Profile(name: name, role: role), Menu()],
      )),
    );
  }
}
