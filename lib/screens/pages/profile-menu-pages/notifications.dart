// ignore_for_file: prefer_const_constructors

import 'package:com_policing_incident_app/models/get-models/crime_report.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final List<String> notifications = [
    'New message from John',
    'You have 3 unread emails',
    'Reminder: Meeting at 2:00 PM',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  notifications[index],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  // Handle notification tap
                  // You can navigate to a detailed notification page or perform other actions
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
