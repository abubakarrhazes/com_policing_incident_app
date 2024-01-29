// ignore_for_file: prefer_const_constructors, unused_field, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  //late final WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(top: 30),
      child: Image.asset(
        'assets/images/location.jpeg',
        fit: BoxFit.cover,
      ),
    ));
  }

  // Function to get JavaScriptMode based on the platform
}
