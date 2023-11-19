// ignore_for_file: prefer_const_constructors

import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:flutter/material.dart';

Widget customButton(
    {required VoidCallback tap,
    bool? status = false,
    String? text = 'Save',
    BuildContext? context}) {
  return GestureDetector(
    onTap: status == true ? null : tap,
    child: Container(
      height: 48,
      margin: const EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: status == false ? KprimaryColor : Colors.grey,
          borderRadius: BorderRadius.circular(8)),
      width: MediaQuery.of(context!).size.width,
      child: Text(
        status == false ? text! : 'Please wait...',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    ),
  );
}
