// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:com_policing_incident_app/admin/features/widgets/dashboard_data.dart';
import 'package:com_policing_incident_app/admin/features/widgets/drawer_header_tiles.dart';
import 'package:com_policing_incident_app/admin/features/widgets/side_menu.dart';
import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:flutter/material.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: SideMenu(),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: KprimaryColor,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
