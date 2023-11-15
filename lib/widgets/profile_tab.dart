// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab(
      {required this.icon,
      required this.text,
      this.navIcon,
      this.onPressed,
      this.color});
  final String text;
  final IconData? icon;
  final IconData? navIcon;
  final Color? color;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: TextStyle(
                color: KprimaryColor,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 210,
            ),
            Expanded(
              child: Icon(
                navIcon,
                color: KprimaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
