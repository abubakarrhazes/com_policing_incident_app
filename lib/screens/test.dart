import 'package:com_policing_incident_app/providers/auth_provider.dart';
import 'package:com_policing_incident_app/providers/persistance_data/user_persistance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userPersistence =
        Provider.of<UserPersistance>(context, listen: false).getUserId();
    return Scaffold(
      body: Text(
        '${userPersistence}',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
