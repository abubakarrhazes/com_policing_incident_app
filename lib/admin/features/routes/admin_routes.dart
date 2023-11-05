// ignore_for_file: prefer_const_constructors

import 'package:com_policing_incident_app/admin/features/admin.dart';
import 'package:com_policing_incident_app/admin/features/screens/sub-screens/add_police_station.dart';
import 'package:flutter/material.dart';

class AdminRoutes {
  //Creating a Default String Holders to each routing for admin

  String admin = '/';
  String addPoliceStations = '/add-police-station';

  Route<dynamic> controller(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => Admin());
      case '/add-police-station':
        return MaterialPageRoute(builder: (context) => AddPoliceStation());

      default:
        throw "Undefined Routes";
    }
  }
}
