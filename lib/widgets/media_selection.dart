// ignore_for_file: use_key_in_widget_constructors

import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:flutter/material.dart';

class MediaSelection extends StatelessWidget {
  const MediaSelection({
    required this.text,
    required this.icon,
  });
  final String text;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: KprimaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: icon,
    );
  }
}
