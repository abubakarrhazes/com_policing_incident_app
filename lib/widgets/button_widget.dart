// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Function() onPress;
  bool? status = false;
  ButtonWidget({required this.text, required this.onPress, this.status});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: KprimaryColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 2),
          ),
        ),
      ),
    );
  }
}
