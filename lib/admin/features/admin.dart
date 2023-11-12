// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:com_policing_incident_app/admin/features/widgets/dashboard_data.dart';
import 'package:com_policing_incident_app/admin/features/widgets/drawer_header_tiles.dart';
import 'package:com_policing_incident_app/admin/features/widgets/side_menu.dart';
import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:com_policing_incident_app/widgets/avatar.dart';
import 'package:flutter/material.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Row(
              children: [
                Avatar.medium(img: NetworkImage('')),
              ],
            )
          ],
        ),
        body: Row(
          children: [
            Expanded(child: SideMenu()),
            Expanded(
              flex: 3,
              child: Container(
                  height: 500,
                  decoration: BoxDecoration(
                      color: KprimaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text('')),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 500,
                decoration: BoxDecoration(
                    color: KprimaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(''),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
