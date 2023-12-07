import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:human_resources/datas/icons.dart';
import 'package:human_resources/theme.dart';
import 'package:flutter_svg/svg.dart';

class Profile extends StatelessWidget {
  final String name;
  final String role;

  Profile({required this.name, required this.role});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 15,
        ),
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.account_circle_rounded,
                size: 40,
              ),
              SizedBox(
                width: 20,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  name,
                  style: bold16,
                  textAlign: TextAlign.left,
                ),
                Text(
                  role,
                  style: regular12_5,
                  textAlign: TextAlign.left,
                ),
              ]),
            ],
          ),
        ));
  }
}
