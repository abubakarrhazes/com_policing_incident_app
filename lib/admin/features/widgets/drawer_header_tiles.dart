// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class DrawerHeaderTiles extends StatelessWidget {
  const DrawerHeaderTiles({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  final String text;
  final IconData icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
      ),
      title: Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
